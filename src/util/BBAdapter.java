package util;

import java.util.HashMap;
import java.util.Map;

/**
 * A tool that converts BBcode text to html text
 * 
 * @author 天一
 *
 */
public class BBAdapter {

	public static String encode(String text) {
		if (text == null)
			return "";
		return text.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	}

	/**
	 * The main bbcode convert method
	 * 
	 * @param text
	 *            BBcode text
	 * @return The decoded html text
	 */
	public static String process(String text) {
		// System.out.println(text);
		String html = text;

		html = html.replaceAll("<br/>", "[br]");
		html = html.replaceAll("<", "&lt;");
		html = html.replaceAll(">", "&gt;");

		Map<String, String> bbMap = new HashMap<String, String>();

		bbMap.put("\\[br\\]", "<br/>");
		bbMap.put("(\r\n|\r|\n|\n\r)", "<br/>");
		bbMap.put("\\[b\\](.+?)\\[/b\\]", "<strong>$1</strong>");
		bbMap.put("\\[i\\](.+?)\\[/i\\]",
				"<span style='font-style:italic;'>$1</span>");
		bbMap.put("\\[u\\](.+?)\\[/u\\]",
				"<span style='text-decoration:underline;'>$1</span>");
		bbMap.put("\\[h1\\](.+?)\\[/h1\\]", "<h1>$1</h1>");
		bbMap.put("\\[h2\\](.+?)\\[/h2\\]", "<h2>$1</h2>");
		bbMap.put("\\[h3\\](.+?)\\[/h3\\]", "<h3>$1</h3>");
		bbMap.put("\\[h4\\](.+?)\\[/h4\\]", "<h4>$1</h4>");
		bbMap.put("\\[h5\\](.+?)\\[/h5\\]", "<h5>$1</h5>");
		bbMap.put("\\[h6\\](.+?)\\[/h6\\]", "<h6>$1</h6>");
		bbMap.put("\\[quote\\](.+?)\\[/quote\\]", "<blockquote>$1</blockquote>");
		bbMap.put("\\[p\\](.+?)\\[/p\\]", "<p>$1</p>");
		bbMap.put("\\[p=(.+?),(.+?)\\](.+?)\\[/p\\]",
				"<p style='text-indent:$1px;line-height:$2%;'>$3</p>");
		bbMap.put("\\[center\\](.+?)\\[/center\\]", "<div align='center'>$1");
		bbMap.put("\\[align=(.+?)\\](.+?)\\[/align\\]", "<div align='$1'>$2");
		bbMap.put("\\[color=(.+?)\\](.+?)\\[/color\\]",
				"<span style='color:$1;'>$2</span>");
		bbMap.put("\\[size=(.+?)\\](.+?)\\[/size\\]",
				"<span style='font-size:$1;'>$2</span>");
		bbMap.put("\\[img\\](.+?)\\[/img\\]", "<img src='$1' />");
		bbMap.put("\\[img=(.+?),(.+?)\\](.+?)\\[/img\\]",
				"<img width='$1' height='$2' src='$3' />");
		bbMap.put("\\[email\\](.+?)\\[/email\\]", "<a href='mailto:$1'>$1</a>");
		bbMap.put("\\[email=(.+?)\\](.+?)\\[/email\\]",
				"<a href='mailto:$1'>$2</a>");
		bbMap.put("\\[url\\](.+?)\\[/url\\]", "<a href='$1'>$1</a>");
		bbMap.put("\\[url=(.+?)\\](.+?)\\[/url\\]", "<a href='$1'>$2</a>");
		bbMap.put(
				"\\[youtube\\](.+?)\\[/youtube\\]",
				"<object width='640' height='380'><param name='movie' value='http://www.youtube.com/v/$1'></param><embed src='http://www.youtube.com/v/$1' type='application/x-shockwave-flash' width='640' height='380'></embed></object>");
		bbMap.put("\\[video\\](.+?)\\[/video\\]", "<video src='$1' />");
		bbMap.put(
				"\\[flash\\](.+?)\\[/flash\\]",
				"<embed src=\"$1\" allowFullScreen=\"true\" quality=\"high\" width=\"480\" height=\"400\" align=\"middle\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>");
		bbMap.put(
				"\\[youku\\](.+?)\\[/youku\\]",
				"<embed src=\"$1\" allowFullScreen=\"true\" quality=\"high\" width=\"480\" height=\"400\" align=\"middle\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>");
		bbMap.put("\\[sound\\](.+?)\\[/sound\\]",
				"<audio src=\"$1\" controls=\"controls\"></audio>");

		for (Map.Entry entry : bbMap.entrySet()) {
			html = html.replaceAll(entry.getKey().toString(), entry.getValue()
					.toString());
		}
		return html;
	}
}
