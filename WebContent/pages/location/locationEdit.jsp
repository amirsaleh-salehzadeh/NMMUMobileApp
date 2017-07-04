<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<%@taglib prefix="ams" uri="/WEB-INF/AMSTag.tld"%>
<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib prefix="ams" uri="/WEB-INF/AMSTag.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<div id='formContainer'>
		<form id="dataFilterGridMainPage" action="location.do">
			<input type="hidden" name="reqCode" value="saveUpdateLocation">
			<div class="ui-block-solo">
				<html:text name="locationENT" property="locationName" title="Location Name" />
				<html:hidden name="locationENT" property="locationID"/>
			</div>
			<div class="ui-block-solo">
				<html:text name="locationENT" property="address" title="Address" />
			</div>
			<div class="ui-block-solo">
				<html:text name="locationENT" property="gps" title="GPS" />
			</div>
			<div class="ui-block-solo">
				<html:text name="locationENT" property="username" title="Username" />
			</div>

			<div class=ui-grid-b>
				<div class=ui-block-a>
					<a href="#" data-role="button" class="cancel-icon"
						onclick="callAnAction('location.do?reqCode=locationManagement');"
						data-mini="true">Cancel</a>
				</div>
				<div class=ui-block-b>
					<a href="#" data-role="button" class="save-icon"
						onclick="saveTheForm();" data-mini="true">Save</a>
				</div>
			</div>
		</form>
	</div>
</body>

</html>