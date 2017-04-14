<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<!-- the setting popup menu for roleEdit Page -->
	<!-- defines the clientID of the role -->
	<bean:define name="roleENT" id="clientID4Role" property="clientID" />
	<!-- defines the form to submit the information to the action security.do-->
	<form id="dataFilterGridMainPage" action="security.do">
		<!-- The reqCode which action must work with-->
		<input type="hidden" name="reqCode" value="saveUpdate">
		<!-- Formatting and putting the text fields in the page-->
		<div class="ui-block-solo">
			<input type="text" name="roleENT.roleName"
				value="<bean:write name="roleENT" property="roleName" />"
				placeholder="Role Name" data-theme="a" title="Role Name"> <input
				type="hidden" name="roleENT.roleID"
				value="<bean:write name="roleENT" property="roleID" />">
		</div>
		<!-- 		a block underneath containing a text area -->
		<div class="ui-block-solo">
			<label for="roleENT.comment">Comment:</label>
			<textarea name="roleENT.comment" placeholder="Comment">
<bean:write name="roleENT" property="comment" />
</textarea>
		</div>
		<div class="ui-block-solo">
			       <select name="roleENT.clientID" data-native-menu="false">
				<option value="0">Client</option>
				<!-- iterates upon all clients in the clientENTs which has came from the action as an attribute-->
				<logic:iterate id="clientList" type="common.client.ClientENT"
					name="clientENTs">
					<!-- 					during the loop checks if the clientID is as the same as the bean 
we defined at top including the role's clientID, then adds the selected="selected" means slect this one -->
					<option <%if (clientID4Role.equals(clientList.getClientID())) {%>
						selected="selected" <%}%>
						value="<bean:write name="clientList" property="clientID" />">
						<bean:write name="clientList" property="clientName" />
					</option>
				</logic:iterate>
			</select>
		</div>
		<!-- 		buttons -->
		<div class=ui-grid-a>
			<div class=ui-block-a>
				<a href="#" data-role="button" data-inline="true" data-icon="delete"
					onclick="callAnAction('security.do?reqCode=roleManagement');">Cancel</a>
			</div>
			<div class=ui-block-b>
				<a href="#" data-role="button" data-inline="true" data-icon="check"
					data-theme="b" onclick="saveTheForm();">Save</a>
			</div>
		</div>
	</form>
</body>

</html>