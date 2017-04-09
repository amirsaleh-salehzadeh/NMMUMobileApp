<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<div class="ui-grid-a">
		<div class="ui-block-a">
			<input type="text" name="text-basic" id="text-basic"
				placeholder="Role Name" value='' data-theme="a">
				<bean:write name="roleENT" property="RoleName"/>
		</div>
		<input type="submit" value="Search" data-theme="a">
	</div>
</body>

</html>