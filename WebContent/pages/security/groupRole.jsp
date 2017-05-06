<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib prefix="ams" uri="/WEB-INF/AMSTag.tld"%>
<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<form id="dataFilterGridMainPage" action="security.do">
		<input type="hidden" name="groupID" value="<%=request.getParameter("groupID")%>">
		<input type="hidden" name="reqCode" value="saveUpdateGroupRole">
			<div class="ui-grid-solo">
				<div class="ui-block-a">
					<html:text name="roleLST" property="searchRole.roleName"
						onkeyup="refreshGrid();" title="Role Name"></html:text>
				</div>
			</div>
		Roles for user "
		<bean:write name="groupENT" property="groupName" />
		"
		<logic:iterate id="groupsListIteration" indexId="rowId"
			name="groupsList" property="groupENTs" type="common.security.GroupENT">
			<%
				int counter = rowId % 3;
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
					<logic:iterate id="groupRoleIds" name="groupRoles"
						type="common.security.GroupENT">
						<input type="checkbox" value="<%=groupsListIteration.getGroupID()%>"
							<%if (groupsListIteration.getGroupID() == groupRoleIds
							.getGroupID()) {%>
							checked="checked" <%}%> data-inline="true">
					</logic:iterate>
					<%=groupsListIteration.getGroupName()%></div>
				<%
					if (counter == 2) {
				%>
			</div>
			<%
				}
			%>
		</logic:iterate>
		<!-- I took out data-inline="true" -->
			<div class=ui-block-a>
				<a href="#" data-role="button" data-icon="delete"
					onclick="callAnAction('security.do?reqCode=groupEdit');">Cancel/Back</a>
			</div>
			<div class=ui-block-b>
				<a href="#" data-role="button" data-icon="check"
					data-theme="b" onclick="saveTheForm();">Save</a>
			</div>
		</div>
	</form>
</body>
</html>

