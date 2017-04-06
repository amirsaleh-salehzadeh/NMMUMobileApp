<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<div class="ui-grid-a">
		<fieldset class="ui-grid-a">
			<div class="ui-block-a">
				<input type="search" name="text-basic" id="text-basic"
					placeholder="Role Name" value="" data-theme="a">
			</div>
			<div class="ui-block-b">
				<select name="select-clients" id="select-clients">
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
		<input type="submit" value="Search" data-theme="a">
	</div>
	<div class="ui-grid-solo">
		<div class="ui-block-a">
			<table data-role="table" id="table-column-toggle"
				data-mode="columntoggle" class="ui-responsive table-stroke">
				<thead>
					<tr>
						<th data-priority="5">Row</th>          
						<th data-priority="1">Role</th>          
						<th data-priority="3">Comment</th>
						<th data-priority="2">Edit</th>
						<th data-priority="2">Delete</th>
						<th data-priority="4"><input type="checkbox" name="checkAll"
							id="checkAll">&nbsp;&nbsp;&nbsp;</th>         
					</tr>
				</thead>
				<tbody>
					<logic:iterate id="roleList" indexId="rowID"
						type="common.security.RoleENT" name="roleENTs">
						<tr>
							<th>&nbsp;&nbsp;&nbsp;&nbsp; <%=rowID + 1%></th>
							<td><bean:write name="roleList" property="roleName" /></td>
							<td><bean:write name="roleList" property="comment" /></td>
							<td><a href="#popupBasic" data-transition="flip"
								data-rel="popup" data-role="button" data-icon="edit" onclick="loadEdit(<%=roleList.getRoleID()%>)">Edit</a></td>
							<td><a href="#" data-role="button" data-icon="delete">Delete</a></td>
							<td><input type="checkbox" name="checkbox"
								id="<%=roleList.getRoleID()%>"></td>
						</tr>
					</logic:iterate>
				</tbody>
			</table>
		</div>
	</div>
	<script>
function loadEdit(x){
	$("div#popupBasic").load("security.do?reqCode=list");
}
	</script>
	<div data-role="popup" id="popupBasic">
		<a href="#" data-rel="back" data-role="button" data-theme="a"
			data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a>
	</div>
</body>

</html>