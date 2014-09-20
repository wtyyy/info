package file;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.websocket.Session;

import org.apache.catalina.User;

import util.UserInfo;
import util.UserTable;
import jdbc.Conn;

@WebServlet(name = "uploadServlet", urlPatterns = { "/uploadServlet" })
@MultipartConfig(maxFileSize = 16177215)
// upload file's size up to 16MB
/**
 * *A servlet that can upload a single file to the database
 * It can handle post request, the request should have 2 parameters:
 * name: text field, which is the name of the file
 * file: file field, which is the content of the file
 * The file will be stored on the files table as a largeBlob
 * the file should be less then 16MB
 * @author 天一
 *
 */
public class FileUploadDBServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * Handle post request
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		

		UserInfo user = (UserInfo) request.getSession().getAttribute("user");

		String checkResult = null;
		try {
			checkResult = UploadCheck.check(user);
		} catch (Exception e) {
			request.setAttribute("message", "数据库异常，请重试");
			getServletContext().getRequestDispatcher("/message.jsp").forward(
					request, response);
			return;
		}
		
		if (checkResult != null) {
			request.setAttribute("message", checkResult);
			getServletContext().getRequestDispatcher("/message.jsp").forward(
					request, response);
			return;
		}
		
		String name = request.getParameter("name");
		if (name == null || "".equals(name)) {
			request.setAttribute("message", "文件名不能为空");
			getServletContext().getRequestDispatcher("/message.jsp").forward(
					request, response);
			return;
		}

		InputStream inputStream = null; 

		Part filePart = request.getPart("file");

		if (filePart != null && filePart.getSize() > 0) {
			System.out.println(filePart.getName());
			System.out.println(filePart.getSize());
			System.out.println(filePart.getContentType());

			inputStream = filePart.getInputStream();
		} else {
			request.setAttribute("message", "文件不能为空");
			// forwards to the message page
			getServletContext().getRequestDispatcher("/message.jsp").forward(
					request, response);
			return;
		}

		Connection conn = null; // connection to the database
		String message = null; // message will be sent back to client

		try {
			// connects to the database
			conn = Conn.getConn();

			// constructs SQL statement
			String sql = "INSERT INTO files (name, content, uploaderId) values (?, ?, ?)";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, name);
			statement.setInt(3, user.getId());
			if (inputStream != null) {
				statement.setBlob(2, inputStream);
			} else {
				request.setAttribute("message", "文件上传失败，请检查文件大小");
				getServletContext().getRequestDispatcher("/message.jsp")
						.forward(request, response);
				return;
			}

			// sends the statement to the database server
			int row = statement.executeUpdate();
			if (row > 0) {
				message = "文件上传成功";
			} else {
				message = "文件上传失败";
			}
		} catch (SQLException ex) {
			message = "ERROR: " + ex.getMessage();
			ex.printStackTrace();
		} catch (ClassNotFoundException ex) {
			message = "ERROR: " + ex.getMessage();
			ex.printStackTrace();
		} finally {
			if (conn != null) {
				// closes the database connection
				try {
					conn.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			// sets the message in request scope
			request.setAttribute("message", message);

			// forwards to the message page
			getServletContext().getRequestDispatcher("/message.jsp").forward(
					request, response);
		}
	}
}
