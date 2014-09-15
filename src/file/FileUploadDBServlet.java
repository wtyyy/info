package file;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
 


import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import jdbc.Conn;

@WebServlet(name = "uploadServlet", urlPatterns = { "/uploadServlet" })
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
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
     
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        // gets values of text fields
        String name = request.getParameter("name");
         
        InputStream inputStream = null; // input stream of the upload file
         
        // obtains the upload file part in this multipart request
        Part filePart = request.getPart("file");
        if (filePart != null) {
            // prints out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
             
            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        }
         
        Connection conn = null; // connection to the database
        String message = null;  // message will be sent back to client
         
        try {
            // connects to the database
            conn = Conn.getConn();
 
            // constructs SQL statement
            String sql = "INSERT INTO files (name, content) values (?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, name);
             
            if (inputStream != null) {
                // fetches input stream of the upload file for the blob column
            	statement.setBlob(2, inputStream);
                //statement.setBlob(2, inputStream);
            }
 
            // sends the statement to the database server
            int row = statement.executeUpdate();
            if (row > 0) {
                message = "文件上传成功";
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
            getServletContext().getRequestDispatcher("/message.jsp").forward(request, response);
        }
    }
}
