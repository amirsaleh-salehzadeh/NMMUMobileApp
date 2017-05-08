<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.management.relation.RoleList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib prefix="ams" uri="/WEB-INF/AMSTag.tld"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<html>
<body>
	<form id="dataFilterGridMainPage" action="user.do">
		<ams:message messageEntity="${message}"></ams:message>
		<input type="hidden" name="userID"
			value="<%=request.getParameter("userID")%>"> <input
			type="hidden" name="reqCode" value="userRolesSave"> Roles for
		user "
		<bean:write name="userENT" property="userName" />
		"
		<div>
			<html:text property="roleName" name="roleENT"
				styleId="searchKeyInput" onkeyup="searchForRole()"
				title="Search for a role"></html:text>
		</div>
		<label style="width: 100%">Select All <input type="checkbox"
			id="checkAllRoles" onclick="selectAllRoles()">
		</label> <a href="#" data-role="button" data-inline="true"
			onclick="callAnAction('user.do?reqCode=userEdit&userID=<%=request.getParameter("userID")%>')">Back</a>
		<a href="#" data-role="button" data-inline="true"
			onclick="saveTheForm()">Save</a>
		<table data-role="table" id="table-column-toggle"
			class="ui-responsive table-stroke">
			<tbody>
				<logic:iterate id="rolesListIteration" indexId="rowId"
					name="rolesList" type="common.security.RoleENT">

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
						<td><label><input type="checkbox" name="userRoleID"
								class="roleCheckBoxes"
								value="<%=rolesListIteration.getRoleID()%>"
								<logic:iterate id="userRoleIds"
									name="userRoles" type="common.security.RoleENT">
										<%if (rolesListIteration.getRoleID() == userRoleIds
							.getRoleID()) {%>
										checked="checked" <%}%> 
								</logic:iterate>
								data-inline="true"><%=rolesListIteration.getRoleName()%>
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
	</form>
</body>
<head>
<script type="text/javascript">
	$(document).ready(function() {
		refreshPlaceHolders();
	});
	function selectAllRoles() {
	
		$('.roleCheckBoxes').prop('checked', $("#checkAllRoles").is(':checked')).checkboxradio('refresh');   
            
	}
	function searchForRole() {
		var str = "user.do?reqCode=userRoleView&userID="
				+
<%=request.getParameter("userID")%>
	+ "&roleName="
				+ $('#searchKeyInput').val();
		callAnAction(str);

	}
</script>
</head>
</html>