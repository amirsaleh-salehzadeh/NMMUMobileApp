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
<script type="text/javascript">
	$(document).ready(function() {
		refreshPlaceHolders();
	});
	function changeUsernamePasswordValidation() {
		saveTheForm();
	}
</script>
<body style="padding: .6em .4em .6em .4em">
	<form id="dataFilterGridMainPage" action="user.do">
		<input type="hidden" name="reqCode" value="saveNewPassword">
		<ams:message messageEntity="${message}"></ams:message>
		<input type="hidden" name="userID"
			value="<%=request.getParameter("userID")%>">

		<html:text name="userENT" property="userName" title="Username" />
		<html:password name="userENT" property="password" title="Old Password" />
		<input type="password" 
		    name="newPW" id="newPW" value=""
			placeholder="New Password"> 
		<input type="password"
			name="newPWCheck" id="newPWCheck" value=""
			placeholder="Re-enter New Password">
		<div>
			<a href="#" data-role="button" data-inline="true" data-icon="check"
				data-theme="b" onclick="changeUsernamePasswordValidation();
					">Save</a>
			<a data-role="button" data-inline="true" data-icon="check"
				href="t_user.do?reqCode=userManagement" data-ajax="false">Back</a>
		</div>
	</form>
</body>
</html>