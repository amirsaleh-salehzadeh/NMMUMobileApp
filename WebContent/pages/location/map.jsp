<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<link rel="stylesheet"
	href="css/themes/default/jquery.mobile-1.4.5.min.css">
<script type="text/javascript"
	src="js/location/camera/scanner/adapter.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.1.10/vue.min.js"></script>
<script type="text/javascript"
	src="js/location/camera/scanner/instascan.min.js"></script>
<link rel="stylesheet" href="css/jquery-mobile/jqm-demos.css">
<script src="js/jquery.min.js"></script>
<script src="js/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/location/path.navigation.css">
<link rel="stylesheet" href="css/location/path.navigation.buttons.css">
<link rel="stylesheet"
	href="css/location/path.navigation.current.location.css">
<link rel="stylesheet"
	href="css/location/path.navigation.search.list.css">
<link rel="stylesheet" href="css/location/path.navigation.trip.info.css">
<style type="text/css">
.gm-style .gm-style-iw {
	background-color: rgba(12, 28, 44, 1) !important;
	top: 0 !important;
	left: 0 !important;
	width: 100% !important;
	height: 100% !important;
	min-height: 60px !important;
	padding-top: 10px;
	display: block !important;
}

.iw-container {
	width: 100% !important;
	height: 100% !important;
	display: block !important;
	bottom: 0;
}

#iw-container {
	width: 100% !important;
	height: 100% !important;
	display: block !important;
	padding-top: 0em !important;
	padding-right: 1.1em;
	margin: 0;
	right: 0;
	margin: 0;
}

#headerInfo {
	width: 100%;
	background-color: rgb(247, 175, 35) !important;
	color: rgb(12, 28, 44) !important;
	font-size: 14pt;
	font-weight: bold !important;
	text-shadow: none !important;
	text-align: center !important;
}

#destInfo {
	color: rgb(247, 175, 35);
	text-shadow: none;
	top: 7.3em;
	width: 100%;
}

.gm-style div div div div div div div div {
	background-color: rgba(12, 28, 44, 1) !important;
	padding: 0;
	margin: 0;
	top: 0;
	color: #fff;
}

#start {
	background-image: url("images/icons/startBlue.png") !important;
	background-repeat: no-repeat;
	background-size: 48px 48px;
	border: none;
	width: 100%;
	float: left;
	min-height: 33px !important;
	display: block;
	top: 0;
	min-height: 33px !important;
}
</style>
<body>
	<div id="pageContents" style="width: 100%; height: 100%;">
		<input type="hidden" id="currentLocationName"
			placeholder="Current Location" value=""> <input type="hidden"
			id="currentTime" placeholder="Current Time" value="">
		<div data-role="popup" id="popupPathType">
			<a href="#" data-rel="back"
				class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
			<div class="ui-block-a">
				<label for="dirtroad" class="popupPathItem"
					style="width: 100%; text-align: center;"> <input
					type="radio" name="radio-choice-path-type" id="dirtroad" value="0"
					checked="checked">Shortest Path (This path may contain
					unsmooth walkways) <img alt="" src="images/icons/fastSpeed.png"
					style="width: 32px; height: 32px; vertical-align: middle;">
				</label> <br /> <label for="walking" class="popupPathItem"
					style="width: 100%; text-align: center;">Normal Path <input
					type="radio" name="radio-choice-path-type" id="walking" value="1">
					<img alt="" src="images/icons/normalSpeed.png"
					style="width: 32px; height: 32px; vertical-align: middle;">
				</label> <a data-role="button" href="#" onclick="getThePath()">Navigate
					Me</a>
			</div>
		</div>
		<input type="hidden" id="tripIds"> <input type="hidden"
			id="tripGPSs"> <input type="hidden" id="tripLocations">
		<input type="hidden" id="from" placeholder="Departure"> <input
			type="hidden" id="departureId" placeholder="DepartureId" value="0">
		<input type="hidden" id="departureName" placeholder="Departure">
		<input type="hidden" id="to"> <input type="hidden"
			id="destinationId" placeholder="DestinationId"> <input
			type="hidden" id="tripId">
		<div id="mapView" class="ui-block-solo">
			<div id="map_canvas"></div>
		</div>
		<div class="ui-block-solo" style="float: right; display: none;"
			id="viewFullScreen">
			<a href="#" data-role="button" id="btnToggleFullscreen" alt=""
				onclick="toggleFullScreen()"></a> <a href="#" data-role="button"
				id="btnEmergency" alt="" onclick="emergencyClick()"></a>
		</div>
		<div id="cameraView" class="ui-block-solo">
			<video id="videoContent"></video>
		</div>
		<!-- 		UPPER PANEL -->
		<div id="barcodeDescription" class="ui-block-solo">
			<span id="destinationInf">Main Building</span><br /> <span
				id="distanceLeftInf">4.35 Km</span><span id="arrivalTimeInf">15':14"</span>
		</div>
	</div>
	<!-- 	SEARCH FEILD -->
	<div id="searchBarDivTop">
		<div class="ui-block-solo" data-role="collapsible-set"
			id="autocompleteContainer" data-collapsed="false">
			<ul id="autocompleteDestination" data-role="listview"
				data-mini="true" data-inset="true" data-filter-reveal="true"
				data-filter="true" data-input="#destinationName">
			</ul>
		</div>
		<div class="ui-block-solo" id="destinationNameDiv">
			<input name="destinationName" id="destinationName"
				placeholder="Where to go" data-mini="true" autocomplete="on">
		</div>
	</div>
	<!-- 		MAP VIEW STYLE -->
	<div id="viewMapType">
		<input type="button" class="zoomBTN" id="satelliteView"
			onclick="mapSattelView()"> <input type="button"
			class="zoomBTN" id="mapViewIcon" onclick="mapMapView()">
	</div>
	<!-- 		ZOOM SETTINGS -->
	<div id="zoomSettings">
		<div class="ui-block-solo" style="display: none;">
			<input disabled="disabled" type="text" id="visitorCounter"
				placeholder="" value="">
		</div>
		<div class="ui-block-solo">
			<input type="button" class="zoomBTN" id="zoomin"
				onclick="zoomInMap()">
		</div>
		<div class="ui-block-solo">
			<input type="button" class="zoomBTN" id="zoomout"
				onclick="zoomOutMap()">
		</div>
	</div>
	<!-- 				DIRECTION SHOW -->
	<div id="directionShow"
		style="background-color: transparent; left: 23px; top: 73px; position: absolute; display: none;">
		<!-- 		changed position from left: 53px; top: 73px; <img alt="" -->
		<!-- 			src="images/icons/anim/arrow2.gif" id="arrowDirId"> <br /> <span -->
		<!-- 			id="navigationDesc" class="infoValue"> </span> -->
		<canvas id="directionCanvas" width="111" height="111"
			style="background-color: white"></canvas>
	</div>
<!-- 		CURRENT LOCATION SHOW -->
	<div class="ui-grid-a ui-block-solo" id="currentLocationShow">
		<div class="ui-block-a" id="currentLocationButtonContainer"
			onclick="removeTrip()">
			<div class="ui-block-solo">
				<button id="remove"></button>
			</div>
			<div class="ui-block-solo">Stop</div>
		</div>
		<div class="ui-block-b" id="currentLocationInfoContainer">
			<span id="currentLocationInf">Embizewni Building</span>
		</div>
	</div>
	<!-- 		 SCANNER BUTTON -->
	<div id="scannerBTNContainer" style="display: none;">
		<button class="navbtn" id="mapViewSelect" onclick="selectMapMode()">MAP</button>
		<button class="navbtn" id="dualModeSelect" onclick="selectDualMode()">Scan</button>
	</div>
	<!-- 		BOTTOM PANEL -->
<!-- 	<div class="ui-grid-c ui-block-solo" id="dashboardPanel"> -->
<!-- 		<!-- 			QR OR MAP MODE --> -->
<!-- 		<div class="ui-block-a"> -->
<!-- 			<div class="navbtnsdiv"> -->
<!-- 				<button class="navbtn" id="mapViewSelect" onclick="selectMapMode()">MAP</button> -->
<!-- 				<button type="button" class="navbtn" id="dualModeSelect" -->
<!-- 					onclick="selectDualMode()">Scan</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<!-- 				   START/STOPNAVIGATION --> -->
<!-- 		<div class="ui-block-b"> -->
<!-- 			<div class="navbtnsdiv"> -->
<!-- 				<button class="navbtn" id="remove" onclick="removeTrip()">Stop</button> -->
<!-- 				<button class="navbtn" id="start" onclick="initiateNavigation()">Go</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<!-- 				    MY CURRENT LOCATION --> -->
<!-- 		<div class="ui-block-c"> -->
<!-- 			<div class="navbtnsdiv"> -->
<!-- 				<button id="mylocation" class="navbtn" onclick="findMyLocation()">My&nbsp;location</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<!-- 				    SEARCH BUTTON --> -->
<!-- 		<div class="ui-block-d"> -->
<!-- 			<div class="navbtnsdiv"> -->
<!-- 				<button id="openSearchBTN" class="navbtn" -->
<!-- 					onclick="openCloseSearch()">Find</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
</body>
<script type="text/javascript" src="js/location/path.navigation.js"></script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&libraries=places,geometry&callback=initiMap"
	type="text/javascript"></script>
<script src="js/jquery/jquery-ui.js"></script>
<script type="text/javascript"
	src="js/location/path.navigation.directions.js"></script>
<script type="text/javascript"
	src="js/location/path.navigation.tools.js"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.js"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.scanner.js"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.ar.js"></script>
<script type="text/javascript" src="js/location/path.navigation.geo.js"></script>
<script src="js/location/path.navigation.search.panel.js"></script>
<script type="text/javascript" src="js/location/path.navigation.map.js"></script>
</html>