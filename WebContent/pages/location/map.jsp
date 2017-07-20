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
			<div>
				<image>
			</div>
			<div></div>
		</div>
		<div data-role="popup" id="popupPathType">
			<a href="#" data-rel="back"
				class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
			<div class="ui-block-a">

				<label for="dirtroad" class="popupPathItem"
					style="width: 100%; text-align: center;"> <!-- //////////// CHANGED HERE START-->
					<input type="radio" name="radio-choice-path-type" id="dirtroad"
					value="0" checked="checked">Shortest Path (This path may
					contain unsmooth walkways) <img alt=""
					src="images/icons/fastSpeed.png"
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
	<input type="hidden" id="tripIds">
	<input type="hidden" id="tripGPSs">
	<input type="hidden" id="tripLocations">
	<input type="hidden" id="from" placeholder="Departure">
	<input type="hidden" id="departureId" placeholder="DepartureId">
	<input type="hidden" id="departureName" placeholder="Departure">
	<input type="hidden" id="to">
	<input type="hidden" id="destinationId" placeholder="DestinationId">
	<input type="hidden" id="tripId">
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
				<input type="button" class="zoomBTN" id="zoomin"
					onclick="zoomInMap()">
			</div>
			<div class="ui-block-solo">
				<input type="button" class="zoomBTN" id="zoomout"
					onclick="zoomOutMap()">
			</div>
		</div>
		<div id="viewMapType">
			<input type="button" class="navbtn" id="satelliteView"
				onclick="mapSattelView()"> <input type="button"
				class="navbtn" id="mapViewIcon" onclick="mapMapView()">
		</div>
		<div class="ui-block-solo" style="float: right" id="viewFullScreen">
			<a href="#" data-role="button" id="btnToggleFullscreen" alt=""
				onclick="toggleFullScreen()"></a>
		</div>
	</div>
	<div id="cameraView" class="ui-block-solo">
		<video id="videoContent"></video>
	</div>
	<!-- 		UPPER PANEL -->
	<div id="barcodeDescription" class="ui-block-solo">
		<div class="ui-grid-a">
			<!-- 				SPEED AND ALT -->
			<!-- //////////// CHANGED HERE -->
			<div class="ui-block-a" style="width: 50%;">
				<div class="ui-bar"
					style="min-height: 33px; padding-top: 0.4em; padding-right: 0.2em; padding-bottom: 0.2em; padding-left: 1em;">
					<div class="dashboardShow">
						<img alt="" src="images/icons/speed.png"
							class="destinationShowIMG"> <span class="infoValue"
							id="speedInf">5.7 Km/h</span>
					</div>
				</div>
				<!-- <br /> -->
				<div class="ui-bar"
					style="min-height: 33px; padding-top: 0.2em; padding-right: 0.2em; padding-bottom: 0.4em; padding-left: 1em;">
					<div class="dashboardShow">
						<img alt="" class="destinationShowIMG"
							src="images/icons/altitude.png"> <span class="infoValue"
							id="seaLevelInf"> 1321 m</span>
					</div>
				</div>
			</div>
			<div class="ui-block-b" style="width: 45%;">
				<div class="ui-bar"
					style="min-height: 33px; padding-top: 0.4em; padding-right: 0.2em; padding-bottom: 0.2em; padding-left: 0.2em;">
					<div class="dashboardShow">
						<img alt="" src="images/icons/distance.png"
							class="destinationShowIMG"> <span class="infoValue"
							id="distanceLeftInf">4.35 Km</span>
					</div>
				</div>
				<!-- <br /> -->
				<div class="ui-bar"
					style="min-height: 33px; padding-top: 0.2em; padding-right: 0.2em; padding-bottom: 0.4em; padding-left: 0.2em;">
					<div class="dashboardShow">
						<img alt="" src="images/icons/time.png" class="destinationShowIMG">
						<span class="infoValue" id="arrivalTimeInf">15':14"</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 	SEARCH FEILD -->
	<div id="searchBarDiv">
		<div class="ui-block-solo" data-role="collapsible-set"
			id="autocompleteContainer">
			<ul id="autocompleteDestination" data-role="listview"
				data-mini="true" data-inset="true" data-filter="true"
				data-input="#destinationName">
			</ul>
		</div>
		<div class="ui-block-solo" id="destinationNameDiv">
			<input name="destinationName" id="destinationName" data-type="search"
				placeholder="Choose destination" data-mini="true" autocomplete="off"">

		</div>


	</div>
	<!-- 				DIRECTION SHOW -->
	<div id="directionShow"
		style="background-color: transparent; left: 53px; top: 73px; position: absolute;">
		<!-- changed position from left: 53px; top: 73px; -->
		<img alt="" src="images/icons/anim/arrow.gif" id="arrowDirId"> <br />
		<span id="navigationDesc" class="infoValue">In 200 meters
			<p>TURN LEFT
		</span>
	</div>
	<!--  COMPASS -->
	<!-- //////////// CHANGED HERE -->
	<div class="compass" id="compassID" onclick="resizeCompass()"
		style="cursor: pointer;">
		<div class="arrow" id="compassArrowID"></div>
		<div class="disc" id="compassDiscImg"></div>
	</div>
	<!-- 		DESTINATION SHOW -->
	<div id="destinationShow">
		<img alt="" id="destinationShowIMG" src="images/icons/finish.png"
			style="width: 32px; height: 32px; z-index: 13;"> <span
			class="infoValue" id="destinationInf">Main Building</span>
	</div>
	<!-- 		BOTTOM PANEL -->
	<div class="ui-grid-c ui-block-solo" id="dashboardPanel">
		<div class="blur" id="blurDivPanel"></div>
		<!-- 			QR OR MAP MODE -->
		<div class="ui-block-a">
			<div class="navbtnsdiv">
				<input type="button" class="navbtn" id="mapViewSelect"
					onclick="selectMapMode()"> <input type="button"
					class="navbtn" id="dualModeSelect" onclick="selectDualMode()">
			</div>
		</div>
		<!-- 				   START/STOPNAVIGATION -->
		<div class="ui-block-b">
			<div class="navbtnsdiv">
				<input type="button" id="remove" class="navbtn"
					onclick="removeTrip()"> <input type="button" class="navbtn"
					id="start" onclick="initiateNavigation()">
			</div>
		</div>
		<!-- 				    MY CURRENT LOCATION -->
		<div class="ui-block-c">
			<div class="navbtnsdiv">
				<input type="button" id="mylocation" class="navbtn"
					onclick="findMyLocation()">
			</div>
		</div>
		<!-- 				    SEARCH BUTTON -->
		<div class="ui-block-d">
			<div class="navbtnsdiv">
				<input type="button" id="openSearchBTN" class="navbtn"
					onclick="openCloseSearch()">
			</div>
		</div>
	</div>
	</div>
</body>
<link rel="stylesheet" href="css/location/path.navigation.css">
<script type="text/javascript"
	src="js/location/path.navigation.js?noCache=true"></script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&libraries=places,geometry&callback=initiMap"
	type="text/javascript"></script>
<script src="js/jquery/jquery-ui.js"></script>
<script type="text/javascript"
	src="js/location/path.navigation.directions.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/path.navigation.tools.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.scanner.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.ar.js"></script>
<script type="text/javascript" src="js/location/path.navigation.geo.js"></script>
<script src="js/location/path.panels.js"></script>
<script type="text/javascript"
	src="js/location/path.navigation.map.js?noCache=true"></script>
</html>