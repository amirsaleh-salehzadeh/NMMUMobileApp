<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<%@taglib prefix="ams" uri="/WEB-INF/AMSTag.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<div id='formContainer'>
		<form id="dataFilterGridMainPage" action="security.do">
			<input type="hidden" name="reqCode" value="saveUpdateGroup">
			<div class="ui-block-solo">
				<input type="text" name="groupName"
					value="<bean:write name="groupENT" property="groupName" />"
					placeholder="Group Name" data-theme="a" title="Group Name">
				<input type="hidden" name="groupID"
					value="<bean:write name="groupENT" property="groupID" />">
			</div>
			<div class="ui-block-solo">
				<input type="text" name="comment"
					value="<bean:write name="groupENT" property="comment" />"
					placeholder="Comment" value="" data-theme="a" title="Comment">
			</div>
			<div class="ui-block-solo">
				<bean:define id="selectedValue" name="groupENT" property="clientID"
					type="java.lang.Integer"></bean:define>
				<ams:dropDown dropDownItems="${clientENTs}"
					selectedVal="<%=selectedValue.toString()%>" name="clientID"
					title=""></ams:dropDown>
			</div>

			<div class=ui-grid-b>
				<!-- I took out data-inline="true" -->
				<div class=ui-block-a>
					<a href="#" data-role="button" class="cancel-icon"
						onclick="callAnAction('security.do?reqCode=groupManagement');"
						data-mini="true">Cancel/Back</a>
				</div>
				<bean:define id="groupIDVal" name="groupENT" property="groupID"
					type="java.lang.Integer"></bean:define>
				<div class=ui-block-b>
					<%
						if (groupIDVal != 0) {
					%>
					<a href="#" data-role="button" id="group-item"
						onclick="callAnAction('security.do?reqCode=groupRoleView&groupID=<%=groupIDVal%>');"
						data-mini="true">Group Roles</a>
					<%
						}
					%>
				</div>
				<div class=ui-block-c>
					<a href="#" data-role="button" class="save-icon"
						onclick="saveTheForm();" data-mini="true">Save</a>
				</div>
			</div>
		</form>
	</div>
</body>

</html>