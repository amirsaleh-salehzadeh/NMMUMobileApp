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
<link rel="stylesheet"
	href="css/location/path.navigation.current.location.css">
<link rel="stylesheet"
	href="css/location/path.navigation.search.list.css">
<link rel="stylesheet" href="css/location/path.navigation.trip.info.css">
<body>
	<div id="pageContents" style="width: 100%; height: 100%;">
		<input type="hidden" id="currentLocationName"
			placeholder="Current Location" value=""> <input type="hidden"
			id="currentTime" placeholder="Current Time" value="">
		<div data-role="popup" id="popupCurrentLocation">
			<a href="#" data-rel="back"
				class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
			You are at
			<%=request.getParameter("currentLocationName")%>
			<br>
			<%=request.getParameter("currentTime")%>
		</div>
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
			type="hidden" id="departureId" placeholder="DepartureId"> <input
			type="hidden" id="departureName" placeholder="Departure"> <input
			type="hidden" id="to"> <input type="hidden"
			id="destinationId" placeholder="DestinationId"> <input
			type="hidden" id="tripId">
		<div class="orientation-data" style="display: none;">
			<div>
				<span id="tiltFB"></span>
			</div>
			<div>
				<span id="tiltLR"></span>
			</div>
			<div>
				<span id="direction"></span>
			</div>
		</div>
		<div id="mapView" class="ui-block-solo">
			<div id="map_canvas"></div>
			<div id="zoomSettings">
				<div class="ui-block-solo">
					<input disabled="disabled" type="text" id="visitorCounter"
						placeholder="" value="" style="display: none;">
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
			<div id="viewMapType">
				<input type="button" class="zoomBTN" id="satelliteView"
					onclick="mapSattelView()"> <input type="button"
					class="navbtn zoomBTN" id="mapViewIcon" onclick="mapMapView()">
			</div>
			<div class="ui-block-solo" style="float: right; display: none;"
				id="viewFullScreen">
				<a href="#" data-role="button" id="btnToggleFullscreen" alt=""
					onclick="toggleFullScreen()"></a>
			</div>
		</div>
		<div id="cameraView" class="ui-block-solo">
			<video id="videoContent"></video>
		</div>

		<!-- 		UPPER PANEL -->
		<div id="barcodeDescription" class="ui-block-solo">
			<span id="destinationInf">Main Building</span><br /> <span
				id="distanceLeftInf">4.35 Km</span><span id="arrivalTimeInf">15':14"</span>
			<!-- 				</div> -->
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
		<!-- 				DIRECTION SHOW -->
		<div id="directionShow"
			style="background-color: transparent; left: 23px; top: 73px; position: absolute;">
			<!-- changed position from left: 53px; top: 73px; -->
			<img alt="" src="images/icons/anim/arrow2.gif" id="arrowDirId">
			<br /> <span id="navigationDesc" class="infoValue"> </span>
		</div>
		<!--  COMPASS -->
		<!-- //////////// CHANGED HERE -->
		<div class="compass" id="compassID" onclick="resizeCompass()"
			style="cursor: pointer;">
			<div class="arrow" id="compassArrowID"></div>
			<div class="disc" id="compassDiscImg"></div>
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
		<div id="scannerBTNContainer">
			<button class="navbtn" id="mapViewSelect" onclick="selectMapMode()">MAP</button>
			<button type="button" class="navbtn" id="dualModeSelect"
				onclick="selectDualMode()">Scan</button>
		</div>
		<!-- 		BOTTOM PANEL -->
		<div class="ui-grid-c ui-block-solo" id="dashboardPanel">
			<div class="blur" id="blurDivPanel"></div>
			<!-- 			QR OR MAP MODE -->
			<div class="ui-block-a">
				<div class="navbtnsdiv">
					<button class="navbtn" id="mapViewSelect" onclick="selectMapMode()">MAP</button>
					<button type="button" class="navbtn" id="dualModeSelect"
						onclick="selectDualMode()">Scan</button>
				</div>
			</div>
			<!-- 				   START/STOPNAVIGATION -->
			<div class="ui-block-b">
				<div class="navbtnsdiv">
					<button class="navbtn" id="remove" onclick="removeTrip()">Stop</button>
					<button class="navbtn" id="start" onclick="initiateNavigation()">Go</button>
				</div>
			</div>
			<!-- 				    MY CURRENT LOCATION -->
			<div class="ui-block-c">
				<div class="navbtnsdiv">
					<button id="mylocation" class="navbtn" onclick="findMyLocation()">My&nbsp;location</button>

				</div>
			</div>
			<!-- 				    SEARCH BUTTON -->
			<div class="ui-block-d">
				<div class="navbtnsdiv">
					<button id="openSearchBTN" class="navbtn"
						onclick="openCloseSearch()">Find</button>
				</div>
			</div>
		</div>
	</div>
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
<script src="js/location/path.panels.js"></script>
<script type="text/javascript" src="js/location/path.navigation.map.js"></script>
</html>