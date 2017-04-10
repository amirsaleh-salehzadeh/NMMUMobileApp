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
		<input type="hidden" name="reqCode" id="reqCode" value="roleGrid">
		<div class="ui-grid-a" id="searchFilters">
			<fieldset class="ui-grid-a">
				<div class="ui-block-a">
					<input type="search" name="searchKey" id="roleSearchFeild"
						placeholder="Role Name" value="" data-theme="a"
						onkeyup="refreshGrid();">
				</div>
				<div class="ui-block-b">
					<select name="clientID" data-native-menu="false" onchange="refreshGrid();">
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
			</fieldset>
		</div>
		<div class="ui-grid-solo">
			<div class="ui-block-a" id="gridContainer"></div>
		</div>
	</form>
</body>
<script>
	$(document).ready(function() {
		refreshGrid();
	});
</script>
</html>