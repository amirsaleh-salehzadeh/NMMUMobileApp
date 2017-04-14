package tools;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import common.PopupENT;

public class AMSPopup extends BodyTagSupport {
	String popupID;
	static String contentPattern = "[PLACEHOLDER]";
	List<PopupENT> popupMenuItems;

	public List<PopupENT> getPopupMenuItems() {
		return popupMenuItems;
	}

	public void setPopupMenuItems(List<PopupENT> popupMenuItems) {
		this.popupMenuItems = new ArrayList<PopupENT>();
		this.popupMenuItems = popupMenuItems;
	}

	public int doStartTag() throws JspException {
		int res = super.doStartTag();
		try {
			String out = loadPopup();
			out = out.substring(0, out.indexOf(contentPattern));
			pageContext.getOut().write(out);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return res;
	}

	public int doAfterBody() throws JspException {
		try {
			BodyContent bodyContent = getBodyContent();
			JspWriter out = bodyContent.getEnclosingWriter();
			bodyContent.writeOut(out);
			bodyContent.clearBody();
		} catch (Exception ex) {
			throw new JspException("error in AMSPopupTag: " + ex);
		}
		return super.doAfterBody();
	}

	public int doEndTag() throws JspException {
		int i = super.doEndTag();
		try {
			String out = loadPopup();
			out = out.substring(out.indexOf(contentPattern)
					+ contentPattern.length());
			pageContext.getOut().write(out);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return i;
	}

	String loadPopup() {
		String sb = "";
		try {
			String realPath = pageContext.getServletContext().getRealPath(
					"images/amspopupmenu/ams_popup.html");
			File f = new File(realPath);
			FileInputStream fin = new FileInputStream(f);
			byte buf[] = new byte[fin.available()];
			fin.read(buf);
			fin.close();
			sb = new String(buf);
			String menuItemsString = createPopup(this.popupMenuItems);
			sb = AMSUtililies.replace(sb, "[CONTENT]", menuItemsString);
			sb = AMSUtililies.replace(sb, "[POPUPID]", "#" + this.popupID);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return sb;
	}

	private String createPopup(List<PopupENT> items) {
		ArrayList<PopupENT> temp = (ArrayList<PopupENT>) items;
		String str = "";
		for (int i = 0; i < temp.size(); i++) {
			PopupENT menuItem = temp.get(i);
			str += "<li><a href='" + menuItem.getHref() + "' onclick='"
					+ menuItem.getOnClick() + "' ";
			if (!menuItem.getId().equals(""))
				str += "id='" + menuItem.getId() +"'";
			str += " >" + menuItem.getValue() + "</a></li>";
		}
		return str;
	}

	public String getPopupID() {
		return popupID;
	}

	public void setPopupID(String popupID) {
		this.popupID = popupID;
	}

	public AMSPopup() {
		super();
	}

}