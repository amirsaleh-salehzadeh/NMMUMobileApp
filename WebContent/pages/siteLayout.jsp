<%@ page language="java" import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="tiles" uri="http://struts.apache.org/tags-tiles"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="css/themes/default/jquery.mobile-1.4.5.min.css">
<link rel="stylesheet" href="css/jquery-mobile/jqm-demos.css">
<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
<script src="js/jquery.js"></script>
<script src="js/jquery.form.js"></script>
<script src="js/index.js"></script>
<script src="js/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript">
	function displaySearch() {
		if ($("#searchFilters").css("display") == "block") {
			$("#searchFilters").fadeOut();
		} else
			$("#searchFilters").fadeIn();
	}
</script>
</head>
<body dir="ltr" bgcolor="white">
	<div data-role="page" class="jqm-demos jqm-home">
		<div data-role="header" class="jqm-header">
			<h2>
				<img src="images/nmmu_logo.gif" alt="NMMU Web Application">
			</h2>
			<a href="#"
				class="jqm-navmenu-link ui-btn ui-btn-icon-notext ui-corner-all ui-icon-bars ui-nodisc-icon ui-alt-icon ui-btn-left">Menu</a>
			<a href="#popupSettingMenu" data-rel="popup" id="mainBodyMenuSettingBTN"
				class="jqm-search-link ui-btn ui-btn-icon-notext ui-corner-all ui-icon-gear ui-nodisc-icon ui-alt-icon ui-btn-right">Search</a>
		</div>
		<div role="main" id="mainBodyContents" class="jqm-content">
			<tiles:insert attribute="body" />
		</div>
		<div data-role="panel" class="jqm-navmenu-panel" data-position="left"
			data-display="overlay" data-theme="a">
			<tiles:insert attribute="menu" />
		</div>
	</div>
</body>
</html>
