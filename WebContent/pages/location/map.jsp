<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
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
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<body>
	<div id="pageContents" style="min-width: 100%; min-height: 100%;">
		<div data-role="popup" id="popupPathType">
			<div class="ui-block-a">
				    <label for="dirtroad" class="popupPathItem"><input
					type="radio" name="radio-choice-path-type" id="dirtroad" value="0"
					checked="checked">Shortest Path (This path may contain
					unsmooth walkways)</label><br /> <label for="walking"
					class="popupPathItem">Normal Path<input type="radio"
					name="radio-choice-path-type" id="walking" value="1">
				</label> <a data-role="button" href="#" data-mini="true"
					onclick="getThePath()">Navigate Me</a>
			</div>
		</div>
		<div id="barcodeDescription" class="ui-block-solo">
			<span class="headingInfo">Current Location</span><span
				class="infoValue" id="currentLocationInf"></span><br /> <span
				class="headingInfo">Speed</span><span class="infoValue"
				id="speedInf"></span><br /> <span class="headingInfo">Sea
				level</span><span class="infoValue" id="seaLevelInf"></span><br /> <span
				class="headingInfo">Destination</span><span class="infoValue"
				id="destinationInf"></span><br /> <span class="headingInfo">Distance
				left</span><span class="infoValue" id="distanceLeftInf"></span><br /> <span
				class="headingInfo">Arrival time</span><span class="infoValue"
				id="arrivalTimeInf"></span><br />
			<div id="directionShow"
				style="background-color: transparent; left: 53px; position: absolute;">
				<img alt="" src="images/icons/anim/arrow.gif" id="arrowDirId">
			</div>
		</div>
		<input type="hidden" id="tripId">
		<div id="mapView" class="ui-block-solo"
			style="min-width: 100%; max-height: 50%;">
			<input type="hidden" id="tripIds"> <input type="hidden"
				id="tripGPSs"> <input type="hidden" id="tripLocations">
			<input type="hidden" id="from" placeholder="Departure"> <input
				type="hidden" id="departureId" placeholder="DepartureId"> <input
				type="hidden" id="departureName" placeholder="Departure"> <input
				type="hidden" id="to"> <input type="hidden"
				id="destinationId" placeholder="DestinationId">
			<div id="map_canvas"></div>
		</div>
		<div id="cameraView" class="ui-block-solo">
			<video id="videoContent"></video>
		</div>
	</div>
	<div id="buttonContainer">
		<input type="button" id="openMenuBTN" onclick="openCloseMenu()">
		<input type="button" id="openSearchBTN" onclick="openCloseSearch()">
	</div>
	<div id="searchBarDiv">
		<div class="ui-block-solo" data-role="collapsible-set" id="autocompleteContainer">
			<ul id="autocompleteDestination" data-role="listview" data-mini="true"
				data-inset="true" data-filter="true" data-input="#destinationName">
			</ul>
		</div>
		<div class="ui-block-solo" id="destinationNameDiv">
			<input name="destinationName" id="destinationName" data-type="search"
				placeholder="Search for a place" data-mini="true" autocomplete="off">
		</div>
	</div>
	<div id="dashboardPanel">
		<div class="compass">
			<div class="arrow"></div>
			<div class="disc" id="compassDiscImg"></div>
		</div>
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
		<div id="dashboardDiv">
			<div id="actionBTNs">
				<div id="mapModeSettings" class="buttonGroups">
					<div class="ui-block-solo">
						<input type="button" class="navbtn" id="satelliteView"
							onclick="mapSattelView()">
					</div>
					<div class="ui-block-solo">
						<input type="button" class="navbtn" id="mapViewIcon"
							onclick="mapMapView()">
					</div>
				</div>
				<div id="zoomSettings" class="buttonGroups">
					<div class="ui-block-solo">
						<input type="button" class="navbtn" id="zoomin"
							onclick="zoomInMap()">
					</div>
					<div class="ui-block-solo">
						<input type="button" class="navbtn" id="zoomout"
							onclick="zoomOutMap()">
					</div>
				</div>
				<div id="actionBTNsHorizontal">
					<div class="ui-block-solo">
						<div id="mapViewSettings" class="buttonGroups">
							<input type="button" class="navbtn" id="remove"
								onclick="removeTrip()" data-mini="true"> <input
								type="button" class="navbtn" id="start"
								onclick="initiateNavigation()"> <input type="button"
								class="navbtn" id="mylocation" onclick="findMyLocation()">
						</div>
					</div>
					<div class="ui-block-solo">
						<div id="navigationSettings" class="buttonGroups">
							<input type="button" class="navbtn" id="mapViewSelect"
								onclick="selectMapMode()"> <input type="button"
								class="navbtn" id="dualModeSelect" onclick="selectDualMode()">
							<input type="button" class="navbtn" id="cameraMode"
								onclick="selectCameraMode()">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript"
	src="js/location/path.navigation.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/path.navigation.directions.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/path.navigation.tools.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/path.navigation.map.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.scanner.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.ar.js"></script>
<script type="text/javascript" src="js/location/path.navigation.geo.js"></script>
<script src="js/location/path.search.js"></script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&libraries=places,geometry&callback=initiMap"
	type="text/javascript"></script>
</html>