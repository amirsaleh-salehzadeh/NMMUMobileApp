<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<logic:iterate id="roleList" indexId="rowID"
	type="common.security.RoleENT" name="roleLST" property="roleENTs">
	<tr>
		<th>&nbsp;&nbsp;&nbsp;&nbsp; <%=rowID + 1%></th>
		<td><bean:write name="roleList" property="roleName" /></td>
		<td><bean:write name="roleList" property="comment" /></td>
		<td><a href="#popupBasic" data-transition="flip" data-rel="popup"
			data-role="button" data-icon="edit"
			onclick="loadEditRole(<%=roleList.getRoleID()%>)">Edit</a></td>
		<td><a href="#" data-role="button" data-icon="delete">Delete</a></td>
		<td><input type="checkbox" name="checkbox"
			id="<%=roleList.getRoleID()%>"></td>
	</tr>
</logic:iterate>
