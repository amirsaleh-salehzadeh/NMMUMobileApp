<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib prefix="ams" uri="/WEB-INF/AMSTag.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
<form id="dataFormMainPage">
	<div class="ui-grid-a">
		<fieldset class="ui-grid-a">
			<div class="ui-block-a">
				<input type="search" name="searchKey" id="roleSearchFeild"
					placeholder="Role Name" value="" data-theme="a"
					onkeyup="searchRole()">
			</div>
			<div class="ui-block-b">
				<select name="clientId" id="select-clients" onchange="searchRole()">
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
		<div class="ui-block-a">
			<bean:define id="totalRows" name="roleLST" property="totalItems"
				type="java.lang.Integer"></bean:define>
			<bean:define id="currentPage" name="roleLST" property="currentPage"
				type="java.lang.Integer"></bean:define>
			<bean:define id="pageSize" name="roleLST" property="pageSize"
				type="java.lang.Integer"></bean:define>
			<ams:ajaxPaginate currentPage="<%=currentPage%>"
				pageSize="<%=pageSize%>" totalRows="<%=totalRows%>" align="center">
				<table data-role="table" id="rolesGrid" data-mode="columntoggle"
					class="ui-responsive table-stroke">
					<thead>
						<tr>
							<th data-priority="5"></th>          
							<th data-priority="1">Role</th>          
							<th data-priority="3">Comment</th>
							<th data-priority="2">Edit</th>
							<th data-priority="2">Delete</th>
							<th data-priority="4"><input type="checkbox" name="checkAll"
								id="checkAll">&nbsp;&nbsp;&nbsp;</th>         
						</tr>
					</thead>
					<tbody id="gridRows">
					</tbody>
				</table>
			</ams:ajaxPaginate>
		</div>
	</div>
	<div data-role="popup" id="popupBasic">
		<a href="#" data-rel="back" data-role="button" data-theme="a"
			data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a>
	</div>
	</form>
</body>
<script>
	$(document).ready(function() {
		searchRole();
	});
	function loadEditRole(x) {
		$("div#popupBasic").load("security.do?reqCode=edit&roleID=" + x);
	}
	function searchRole() {
		var url = "security.do?reqCode=search";
		callAGrid(url);
	}
</script>
</html>