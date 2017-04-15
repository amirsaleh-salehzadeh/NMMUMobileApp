<%@page import="java.util.List"%>
<%@page import="common.PopupENT"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<%@taglib prefix="ams" uri="/WEB-INF/AMSTag.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
	$(document).ready(function() {
		refreshGrid();
	});
</script>
</head>
<body>
	<!-- 	form to send information to the security.do action -->
	<form id="dataFilterGridMainPage" action="security.do">
	<ams:message messageEntity="${message}" ></ams:message>
		<!-- 	indicates the reqCode to show the grid-->
		<input type="hidden" name="reqCode" id="reqCode" value="gridJson">
		<!-- 		creates a div containing our search filters ..... keep the id same searchFilters -->
		<div class="ui-grid-a" id="searchFilters">
			<!-- 		one horizontal column containing block a and b 
		you need to create more columns sometimes, depends on the number of fields we decide to have to filter a grid 
		-->
			<fieldset class="ui-grid-a">
				<!-- 			block a containing a text input on keyup it submits the form and refresh the grid-->
				<div class="ui-block-a">
					<input type="search" name="searchKey" id="roleSearchFeild"
						placeholder="Role Name" data-theme="a"
						onkeyup="refreshGrid();">
				</div>
				<!-- 				block b containing the dropdown select option -->
				<div class="ui-block-b">
					<ams:dropDown dropDownItems="${clientENTs}" name="clientID" selectedVal="0" onChange="refreshGrid()" title="Client"></ams:dropDown>
				</div>
			</fieldset>
		</div>
		<!-- 		includes grid container which refers to roleListGrid.jsp based on the reqCode when refreshGrid submits the form -->
		<div class="ui-grid-solo">
			<bean:define id="totalRows" name="roleLST" property="totalItems"
				type="java.lang.Integer"></bean:define>
			<bean:define id="first" name="roleLST" property="first"
				type="java.lang.Integer"></bean:define>
			<bean:define id="currentPage" name="roleLST" property="currentPage"
				type="java.lang.Integer"></bean:define>
			<bean:define id="pageSize" name="roleLST" property="pageSize"
				type="java.lang.Integer"></bean:define>
			<bean:define id="totalPages" name="roleLST" property="totalPages"
				type="java.lang.Integer"></bean:define>
			<ams:ajaxPaginate currentPage="<%=currentPage%>"
				pageSize="<%=pageSize%>" totalRows="<%=totalRows%>" align="center"
				columns="roleID,roleName,comment,clientID"
				popupID="roleManagementSettingMenu"
				popupGridSettingItems="${gridMenuItem}" 
				popupMenuSettingItems="${settingMenuItem}">
				<table id="gridList" class="display cell-border dt-body-center"  cellspacing="0" width="100%">
					<thead>
						<tr>
							<th><input type="checkbox" id="checkAllHead"></th>
							<th data-priority="1">Role</th>
							<th data-priority="3">Comment</th>
							<th data-priority="2">Client</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th><input type="checkbox" id="checkAllFoot" ></th>
							<th data-priority="1">Role</th>
							<th data-priority="3">Comment</th>
							<th data-priority="2">Client</th>
						</tr>
					</tfoot>
				</table>
			</ams:ajaxPaginate>
		</div>
	</form>
</body>
</html>