<%@page import="javax.management.relation.RoleList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
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
			<input type="hidden" name="reqCode" value="userRoleView"> Roles for
		user "
		<bean:write name="userENT" property="userName" />
		"
		<div><input type="search" name="search-1" id="search-1" value=""> </div>
		
		<logic:iterate id="rolesListIteration" indexId="rowId"
			name="rolesList" property="roleENTs" type="common.security.RoleENT">
			<%
				int counter ;
			        counter = rowId % 3;
					if (counter == 0) {
			%>
			<div class="ui-grid-b">
				<%
					}
				%>
				<div class=<%if (counter == 0) {%>
					"ui-block-a"
				<%} else if (counter == 1) {%>
				"ui-block-b"
				<%} else if (counter == 2) {%>
				"ui-block-c"
				<%}%>>
				<div class="ui-grid-a">
				<div class="ui-block-a">
					<logic:iterate id="userRoleIds" name="userRoles" type="common.security.RoleENT">
					
						<input type="checkbox" value="<%=rolesListIteration.getRoleID()%>"
							<%if (rolesListIteration.getRoleID() == userRoleIds
							.getRoleID()) {%>
							checked="checked" <%}%> data-inline="true">
					</logic:iterate>
					</div>
					<div class="ui-block-b">
					<%=rolesListIteration.getRoleName()%>
					</div>
					</div>
					</div>
					
				<%
					if (counter == 2) {
				%>
			</div>
			<%
				}
			%>
		</logic:iterate>

	</form>
</body>

</html>