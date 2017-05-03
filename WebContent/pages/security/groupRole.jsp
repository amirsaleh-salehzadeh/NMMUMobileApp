<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib prefix="ams" uri="/WEB-INF/AMSTag.tld"%>
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
<input name="page" type="hidden" id="hiddenPage"
	value="<%=currentPage%>" />
<%-- <input name="page" type="text" id="totalRows" value="<%=totalRows%>" /> --%>
<input name="page" type="hidden" id="totalPages" value="<%=totalPages%>" />
<ams:ajaxPaginate currentPage="<%=currentPage%>"
	pageSize="<%=pageSize%>" totalRows="<%=totalRows%>" align="center">
	<table data-role="table" id="rolesGrid" data-mode="columntoggle"
		class="ui-responsive table-stroke">
		<thead>
			<tr>
				<th data-priority="5"></th>          
				<th data-priority="1">Role</th>          
				<th data-priority="3">Comment</th>
				<th data-priority="2">Action</th>
				<th data-priority="4"><input type="checkbox" name="checkAll"
					id="checkAll">&nbsp;&nbsp;&nbsp;</th>   
			</tr>
		</thead>
		<tbody id="gridRows">
			<logic:iterate id="roleList" indexId="rowID"
				type="common.security.RoleENT" name="roleLST" property="roleENTs">
				<tr>
					<th>&nbsp;&nbsp;&nbsp;&nbsp; <%=rowID + first + 1%></th>
					<td><bean:write name="roleList" property="roleName" /></td>
					<td><bean:write name="roleList" property="comment" /></td>
					<td><bean:define id="roleID" name="roleList" property="roleID"
							type="java.lang.Integer"></bean:define> <a href="#popupMenu<%=roleID%>"
						data-rel="popup"
						class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-icon-gear 
						ui-btn-icon-left ui-btn-a"></a>
						<div data-role="popup" id="popupMenu<%=roleID%>" data-theme="b">
							<ul data-role="listview" data-inset="true"
								style="min-width: 210px;">
								<li><a href="#"
									onclick="callAnAction('security.do?reqCode=roleEdit&roleID=<%=roleID%>');">Edit</a></li>
								<li><a href="#">Delete</a></li>         
							</ul>
						</div></td>
					<td><input type="checkbox" name="checkbox"
						id="<%=roleList.getRoleID()%>"></td>
				</tr>
			</logic:iterate>
		</tbody>
	</table>
</ams:ajaxPaginate>

