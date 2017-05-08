<%@page import="java.io.PrintWriter"%>
<%@page import="common.user.UserENT"%>
<%@page import="java.util.List"%>
<%@page import="common.PopupENT"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib prefix="ams" uri="/WEB-INF/AMSTag.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
	$(document).ready(function() {
		refreshPlaceHolders();
		$("#dob").attr("type", "date").trigger("create");//i changed the id dob's type to date, date has a meaning for jquery mobile framework
	});
</script>
<style type="text/css">
.flipswitchGender.ui-flipswitch .ui-btn.ui-flipswitch-on {
	text-indent: -3.9em;
}

.flipswitchGender.ui-flipswitch .ui-flipswitch-off {
	text-indent: 0.5em;
}

.flipswitchGender.ui-flipswitch {
	background-color: #FF0080;
	color: white;
	width: 6.875em;
	text-indent: 2em;
}

.flipswitchGender.ui-flipswitch.ui-flipswitch-active {
	background-color: #2E64FE;
	color: white;
	padding-left: 5em;
	width: 1.875em;
	text-indent: 2em;
}

.flipswitchActive.ui-flipswitch .ui-btn.ui-flipswitch-on {
	text-indent: -3.9em;
}

.flipswitchActive.ui-flipswitch .ui-flipswitch-off {
	text-indent: 0.5em;
}

.flipswitchActive.ui-flipswitch {
	background-color: #8A0808;
	color: white;
	width: 6.875em;
	font-weight: normal;
	text-indent: 2em;
}

.flipswitchActive.ui-flipswitch.ui-flipswitch-active {
	background-color: #2E64FE;
	color: white;
	padding-left: 5em;
	width: 1.875em;
	text-indent: 2em;
}
</style>
</head>
<body style="padding: .6em .4em .6em .4em">

	<ams:message messageEntity="${message}"></ams:message>
	<form id="dataFilterGridMainPage" action="user.do">
		<input type="hidden" name="reqCode" value="userSaveUpdate">
		<html:hidden name="userENT" property="userID" styleId="userID" />
		<bean:define id="genderValue" name="userENT" property="gender"
			type="java.lang.Boolean" />
		<bean:define id="activeValue" name="userENT" property="active"
			type="java.lang.Boolean" />
		<bean:define id="selectedValueClient" name="userENT"
			property="clientID" type="java.lang.Integer"></bean:define>
		<bean:define id="selectedValueEthnic" name="userENT"
			property="ethnicID" type="java.lang.Integer"></bean:define>
		<bean:define id="selectedValueTitle" name="userENT" property="titleID"
			type="java.lang.Integer"></bean:define>

		<fieldset class="ui-grid-a">
			<div class="ui-block-a">
				<html:text name="userENT" property="userName" title="Username" />
			</div>
			<div class="ui-grid-b">
				<ams:dropDown dropDownItems="${clientENTs}"
					selectedVal="<%=selectedValueClient.toString()%>" name="clientID"
					title=""></ams:dropDown>
			</div>
		</fieldset>
		<fieldset class="ui-grid-b">
			<div class="ui-block-a">
				<ams:dropDown dropDownItems="${titleENTs}"
					selectedVal="<%=selectedValueTitle.toString()%>" name="titleID"
					title=""></ams:dropDown>
			</div>
			<div class="ui-block-b">
				<html:text name="userENT" property="name" title="Name" />
			</div>
			<div class="ui-block-c">
				<html:text name="userENT" property="surName" title="Surname" />
			</div>
		</fieldset>

		<div class="ui-grid-a">
			<div class="ui-block-a ui-field-contain">
				<label for="dateOfBirth"
					style="white-space: nowrap !important; width: 100%">Date
					of Birth: </label>
				<html:text name="userENT" property="dateOfBirth"
					title="Date of Birth" styleId="dob" />
			</div>
			<div class="ui-block-b">
					<input type="checkbox" data-role="flipswitch" name="gender"
						id="flipswitchGender" data-on-text="Male" data-off-text="Female"
						data-wrapper-class="flipswitchGender" data-inline="true"
						<%if (genderValue.booleanValue() == true) {%> checked=""
						<%}
			;%> /> <input type="checkbox" data-role="flipswitch"
						data-inline="true" name="active" id="flipswitchActivation"
						selected="selected" data-on-text="Active" data-off-text="Inactive"
						data-wrapper-class="flipswitchActive"
						<%if (activeValue.booleanValue() == true) {%> checked=""
						<%}
			;%> />

			</div>
		</div>
		<div class="ui-block-solo">
			<ams:dropDown dropDownItems="${ethnicENTs}"
				selectedVal="<%=selectedValueClient.toString()%>" name="ethnicID"
				title=""></ams:dropDown>
		</div>
		<fieldset>
			<div class="ui-block-a">
				<html:password name="userENT" property="password" title="Password" />
			</div>
		</fieldset>
		<fieldset>
			<div class="ui-block-c">
				<span style="font-weight: bold">Registration Date&nbsp;</span> <bean:write name="userENT" property="registerationDate"/>
			</div>
		</fieldset>

		<div class=ui-grid-a>
			<div class=ui-block-a>
				<a href="#" data-role="button" data-inline="true" data-icon="delete"
					onclick="callAnAction('user.do?reqCode=userManagement');">Cancel</a>
			</div>
			<div class=ui-block-b>
				<a href="#" data-role="button" data-inline="true" data-icon="check"
					data-theme="b" onclick="saveTheForm();">Save</a>
			</div>
		</div>
	</form>
</body>

</html>