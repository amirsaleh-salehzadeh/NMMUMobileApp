package tools;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class AMSMessage extends BodyTagSupport {

	String errorMessage = "";
	String successMessage = "";

	public AMSMessage() {
		super();
	}
	
	public int doStartTag() throws JspException {
		int res = super.doStartTag();
		try {
			pageContext.getOut().write(loadHeaderTitle());
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
			throw new JspException("error in AIPPagination: " + ex);
		}
		return super.doAfterBody();
	}

	public int doEndTag() throws JspException {
		int i = super.doEndTag();
		try {
			pageContext.getOut().write("");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return i;
	}
	
	String loadHeaderTitle() {
		String sb = "";
		try {
			String realPath = pageContext.getServletContext().getRealPath("images/skin/message/amsskin_message.html");
//			String realPath = "/home/aip/programs/MyEclipse_6.5_workspace/AIPNIOPDCSell/WebRoot/images/skin/message/aipskin_message.html";
			File f = new File(realPath);
			FileInputStream fin = new FileInputStream(f);
			byte buf[] = new byte[fin.available()];
			fin.read(buf);
			fin.close();
			sb = new String(buf);
			String strBegin = sb.substring(0,sb.indexOf("<td class='rr_YELLOW_center' id='messageContainer'>")+"<td class='rr_YELLOW_center' id='messageContainer'>".length());
			String strEnd = sb.substring(sb.indexOf("<td class='rr_YELLOW_center' id='messageContainer'>")+"<td class='rr_YELLOW_center' id='messageContainer'>".length());

			sb = strBegin + 
				 "<label id='errorDescription' style='color:red;'>"+getErrorMessage()+"</label>" 
				 + "<br>" + 
				 "<label id='successDescription' style='color:green;'>"+getSuccessMessage()+"</label>" 
				 + strEnd;
			
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return sb;
	}	
	
	
	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

	public String getSuccessMessage() {
		return successMessage;
	}

	public void setSuccessMessage(String successMessage) {
		this.successMessage = successMessage;
	}
	
	public static void main(String[] args) {
		AMSMessage message = new AMSMessage();
		
		message.loadHeaderTitle();
	}

}