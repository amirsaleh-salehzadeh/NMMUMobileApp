package tools;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class AMSAJAXPagination extends BodyTagSupport {

	static String contentPattern = "[PLACEHOLDER]";

	int totalRows;
	int currentPage;
	int pageSize;
	String align;

	public AMSAJAXPagination() {
		super();
	}

	public int doStartTag() throws JspException {
		int res = super.doStartTag();
		try {
			String out = loadPagination(true);
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
			throw new JspException("error in AMSPagination: " + ex);
		}
		return super.doAfterBody();
	}

	public int doEndTag() throws JspException {
		int i = super.doEndTag();
		try {
			String out = loadPagination(false);
			out = out.substring(out.indexOf(contentPattern)
					+ contentPattern.length());
			pageContext.getOut().write(out);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return i;
	}

	String loadPagination(boolean b) {
		String sb = "";
		try {
			String realPath = pageContext.getServletContext().getRealPath(
					"images/ajaxpagination/ams_ajaxpagination.html");
			File f = new File(realPath);
			FileInputStream fin = new FileInputStream(f);
			byte buf[] = new byte[fin.available()];
			fin.read(buf);
			fin.close();
			sb = new String(buf);
			String pagination = createPagination(totalRows, currentPage,
					pageSize);
			if (b) {
				String jq = "<script src=\"images/ajaxpagination/ams_ajaxpagination.js\" type=\"text/javascript\"></script>";
				// jq +=
				// "<script src=\"js/common/jquery.getUrlParam.js\" type=\"text/javascript\" ></script>";
				sb = AMSUtililies.replace(sb, "[JQUERY]", jq);
			} else {
				sb = AMSUtililies.replace(sb, "[JQUERY]", "");
			}

			if (totalRows > pageSize) {
				if (!b) {
					pagination += "<input type='hidden' id='totalPages' value='"
							+ ((totalRows / pageSize) + 1) + "'>";
					String goToPageContent = ((totalRows / pageSize) + 1)
							+ " / <input id='specifiedPage' type='text' onkeyup='validate();' size='3'>";
					goToPageContent += "<input type='button' onclick='goToSpecifiedPage();' id='goToSpecifiedPageBtn' value='>' disabled='disabled' title='برو به ص�?حه'>";
					sb = AMSUtililies.replace(sb, "[GOTOPAGECONTENT]",
							goToPageContent);
				}
			} else {
				sb = AMSUtililies.replace(sb, "[GOTOPAGECONTENT]", "");
			}

			sb = AMSUtililies.replace(sb, "[CONTENT]", pagination);
			sb = AMSUtililies.replace(sb, "[ALIGN]", getAlign());

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		int pos = sb.indexOf(contentPattern);
		return sb;
	}

	public String createPagination(int totalRows, int currentPage, int pageSize) {
		String str = "";
		if (totalRows != 0) {
			int count = totalRows / pageSize;
			if (totalRows % pageSize != 0) {
				count += 1;
			}
			if (count > 1) {
				if (currentPage != 1) {
					str += "<input type='button' class='AMSpaginationMainBTN' data-icon='arrow-l' value='1' title='First' data-inline='true'/>";
					str += "<input type='button' class='AMSpaginationMainBTN' href='#' id='hrefed"
							+ (currentPage - 1)
							+ "' title='Previous' data-icon='carat-l' title='Previous' value='&nbsp;' data-inline='true'>";
				} else {
					str += "<input type='button' class='AMSpaginationMainBTN' data-icon='arrow-l' value='1' title='First' data-inline='true'/>";
					str += "<input type='button' class='AMSpaginationMainBTN' data-icon='carat-l' value='&nbsp;' title='Previous' data-inline='true'/>";
				}
				if (currentPage < 3) {
					for (int i = 1; i < 5 && i <= count; i++) {
						if (currentPage != i) {
							str += "<input type='button' class='AMSpaginationBTN' id='hrefed" + i
									+ "' value='" + i
									+ "' title='" + i
									+ "' data-inline='true' />";
						} else {
							str += "<input type='button' class='AMSpaginationBTN' id='hrefed" + i
									+ "' value='" + i
									+ "' title='" + i
									+ "' data-inline='true' disabled/>";
						}
					}
				} else if (currentPage > count - 2) {
					for (int j = count - 3; j <= count; j++) {
						if (j > 0) {
							if (currentPage != j) {
								str += "<input type=button class='AMSpaginationBTN' id='hrefed" + j
										+ "' value='" + j
									+ "' title='" + j
										+ "' data-inline='true'/> ";
							} else {
								str += "<input class='AMSpaginationBTN' type=button id='hrefed" + j
									+ "' title='" + j
										+ "' value='" + j
									+ "' data-inline='true' disabled/> ";
							}
						}
					}
				} else {
					for (int i = currentPage - 2; i < currentPage + 3
							&& i <= count; i++) {
						if (currentPage != i) {
							str += "<input type=button class='AMSpaginationBTN' id='hrefed" + i
									+ "' value=" + i + " title='" + i + "' data-inline='true'/> ";
						} else {
							str += "<input type=button class='AMSpaginationBTN' value='" + i
									+ "' title='" + i + "' data-inline='true'/> ";
						}
					}
				}
				if (count != 1 && currentPage != count) {
					str += "<input type='button' class='AMSpaginationMainBTN' data-inline='true' data-icon='carat-r' value='&nbsp;' title='Next'/>"
							+ "<input type='button' class='AMSpaginationMainBTN' title='Last' data-inline='true' data-icon='arrow-r' value='"+count+"' title='Last' />";
				} else {
					str += "<input type='button' class='AMSpaginationMainBTN' data-icon='carat-r' title='Next' value='&nbsp;' data-inline='true'/>";
					str += "<input type='button' class='AMSpaginationMainBTN' data-icon='arrow-r' title='Last' value='"+count+"' data-inline='true'>";
				}
			}
		}
		return str;
	}

	public String getAlign() {
		return align;
	}

	public void setAlign(String align) {
		this.align = align;
	}

	public int getTotalRows() {
		return totalRows;
	}

	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

}