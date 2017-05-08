<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<form id="dataFilterGridMainPage" action="security.do">
		<input type="hidden" name="reqCode" value="saveUpdate">
		<div class="ui-block-solo">
			<input type="text" name="roleName"
				value="<bean:write name="roleENT" property="roleName" />"
				placeholder="Role Name" data-theme="a" title="Role Name"> <input
				type="hidden" name="roleID"
				value="<bean:write name="roleENT" property="roleID" />">
		</div>
		<div class="ui-block-solo">
			<input type="text" name="comment"
				value="<bean:write name="roleENT" property="comment" />"
				placeholder="Comment" value="" data-theme="a" title="Comment">
		</div>
		<div class="ui-block-solo">
			       <select name="clientID" data-native-menu="false">
				<option value="0">Client</option>
				<logic:iterate id="clientList" type="common.client.ClientENT"
					name="clientENTs">
					<option
						value="<bean:write name="clientList" property="clientID" />">
						<bean:write name="clientList" property="clientName" />
					</option>
				</logic:iterate>
			</select>
		</div>
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