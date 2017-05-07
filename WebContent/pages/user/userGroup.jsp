<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.management.relation.RoleList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib prefix="ams" uri="/WEB-INF/AMSTag.tld"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<html>
<head>
</head>
<body>
	<form id="dataFilterGridMainPage" action="user.do">
		<input type="hidden" name="userID"
			value="<%=request.getParameter("userID")%>">
			 <input type="hidden" name="reqCode" value="userGroupView"> 
			 Roles for user "
		      <bean:write name="userENT" property="userName" />
		     "
		<div>
			<html:text property="groupName" name="groupENT" onkeyup="saveTheForm()"
				title="Search for a group"></html:text>
		</div>
		<table data-role="table" id="table-column-toggle"
			class="ui-responsive table-stroke">
			<tbody>
				<logic:iterate id="groupsListIteration" indexId="rowId"
					name="groupsList" type="common.security.GroupENT">

					<%
						int counter;
							int idcount;
							counter = rowId % 3;
							if (counter == 0) {
					%>
					<tr>
						<%
							}
						%>
						<td><label><input type="checkbox"
								value="<%=groupsListIteration.getGroupID()%>"
								<logic:iterate id="userGroupIds"
									name="userGroup" type="common.security.GroupENT">
										<%if (groupsListIteration.getGroupID() == userGroupIds
							.getGroupID()) {%>
										checked="checked" <%}%> 
								</logic:iterate>
								data-inline="true"><%=groupsListIteration.getGroupName()%>
						</label></td>
						<%
							if (counter == 2) {
						%>
					</tr>
					<%
						}
					%>

				</logic:iterate>
			</tbody>
		</table>
			
<a href="#" data-role="button" data-inline="true"
 onclick="callAnAction('user.do?reqCode=userEdit&userID=<%=request.getParameter("userID")%>')">Back to user edit page</a>
	</form>
</body>

</html>