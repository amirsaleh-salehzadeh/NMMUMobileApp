<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib prefix="ams" uri="/WEB-INF/AMSTag.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
	$(document).ready(function() {
		$(".formField").each(function() {
			$(this).attr("placeholder", $(this).attr("title"));
		});
	});
</script>
</head>
<body>
	<ams:message messageEntity="${message}"></ams:message>
	<!-- defines the form to submit the information to the action security.do-->
	<form id="dataFilterGridMainPage" action="security.do">
		<!-- The reqCode which action must work with-->
		<input type="hidden" name="reqCode" value="saveUpdate">
		<!-- Formatting and putting the text fields in the page-->
		<div class="ui-block-solo">
			<html:text name="roleENT" property="roleName" styleClass="formField"
				title="Role Name" />
			<html:hidden name="roleENT" property="roleID" styleId="roleID" />
		</div>
		<div class="ui-block-solo">
			<html:textarea name="roleENT" property="comment"
				styleClass="formField" styleId="comment" title="Comment" />
		</div>
		<div class="ui-block-solo">
			<bean:define id="selectedValue" name="roleENT" property="clientID"
				type="java.lang.Integer"></bean:define>
			<ams:dropDown dropDownItems="${clientENTs}"
				selectedVal="<%=selectedValue.toString()%>" name="clientID" title=""></ams:dropDown>
			<div class=ui-grid-a>
				<div class=ui-block-a>
					<a href="#" data-role="button" data-inline="true"
						data-icon="delete"
						onclick="callAnAction('security.do?reqCode=roleManagement');">Cancel</a>
				</div>
				<div class=ui-block-b>
					<a href="#" data-role="button" data-inline="true" data-icon="check"
						data-theme="b" onclick="saveTheForm();">Save</a>
				</div>
			</div>
		</div>
	</form>
</body>

</html>