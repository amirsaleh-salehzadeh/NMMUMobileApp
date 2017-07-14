<%@ page language="java" import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="tiles" uri="http://struts.apache.org/tags-tiles"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="css/themes/default/jquery.mobile-1.4.5.min.css">
<link rel="stylesheet" href="css/jquery-mobile/jqm-demos.css">
<link rel="stylesheet"
	href="css/jquery-mobile/jquery.dataTables.min.css">
<link rel="stylesheet" href="css/nmmu-web-app-style.css">
<script src="js/nmmu.main.scripts.js"></script>
<script src="js/jquery.min.js"></script>
<script src="js/jquery.form.js"></script>
<script src="js/index.js"></script>
<script src="js/jquery.mobile-1.4.5.min.js"></script>
<script src="js/jquery.dataTables.min.js"></script>
<script src="js/dataTables.bootstrap.min.js"></script>
<script src="js/dataTables.select.min.js"></script>
</head>
<body dir="ltr" bgcolor="#00457c" style="background-color: #00457c;">
	<div data-role="page" class="jqm-demos jqm-home">
		<div data-role="header" class="jqm-header">
			<h2>
				<img src="images/NMMU_logo.png" alt="NMMU Web Application">
			</h2>
			<a href="#"
				class="menu-icon jqm-navmenu-link ui-btn ui-corner-all ui-btn-left"></a>
				<a href="#rightpanel"
				class="menu-icon ui-btn ui-corner-all ui-btn-right"></a>
		</div>
		<div role="main" id="mainBodyContents" class="jqm-content">
			<tiles:insert attribute="body" />
		</div>
		<div data-role="panel" class="jqm-navmenu-panel" data-position="left"
			data-display="overlay">
			<tiles:insert attribute="menu" />
		</div>
	</div>
</body>
</html>
