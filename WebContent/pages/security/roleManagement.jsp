<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
<!-- form to send information to the security.do action -->
	<form id="dataFilterGridMainPage" action="security.do">
<!-- 	indicates the reqCode to show the grid-->
		<input type="hidden" name="reqCode" id="reqCode" value="roleGrid">
<!-- 		creates a div containing our search filters ..... keep the id same searchFilters -->
		<div class="ui-grid-a" id="searchFilters">
		<!-- 		one horizontal column containing block a and b 
		you need to create more columns sometimes, depends on the number of fields we decide to have to filter a grid 
		-->
			<fieldset class="ui-grid-a">
<!-- 			block a containing a text input on keyup it submits the form and refresh the grid-->
				<div class="ui-block-a">
					<input type="search" name="searchKey" id="roleSearchFeild"
						placeholder="Role Name" value="" data-theme="a"
						onkeyup="refreshGrid();">
				</div>
<!-- 				block b containing the dropdown select option -->
				<div class="ui-block-b">
					<select name="clientID" data-native-menu="false" onchange="refreshGrid();">
						<option value="0">Client</option>
<!-- 						logic:iterate reads the attribute clientENTs from the action and iterates upon the items (type: common.client.ClientENT) in it -->
						<logic:iterate id="clientList" type="common.client.ClientENT"
							name="clientENTs">
<!-- 							creates an option  beans read items in clientList which refers to the id of logic iterate-->
							<option
								value="<bean:write name="clientList" property="clientID" />">
								<bean:write name="clientList" property="clientName" />
							</option>
						</logic:iterate>
					</select>
				</div>
			</fieldset>
		</div>
<!-- 		includes grid container which refers to roleListGrid.jsp based on the reqCode when refreshGrid submits the form -->
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