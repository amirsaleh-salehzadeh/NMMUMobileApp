<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<style type="text/css">
</style>
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="apple-mobile-web-app-capable" content="yes" />
<link rel="stylesheet"
	href="css/themes/default/jquery.mobile-1.4.5.min.css">
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/webrtc-adapter/3.3.3/adapter.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.1.10/vue.min.js"></script>
<script type="text/javascript"
	src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>
<link rel="stylesheet" href="css/jquery-mobile/jqm-demos.css">
<script src="js/jquery.min.js"></script>
<!-- <script src="js/index.js"></script> -->
<script src="js/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/location/path.navigation.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<body>
	<div id="barcodeDescription"></div>
	<input type="hidden" id="tripId">
	<div id="pageContents" style="min-width: 100%; min-height: 100%;">
		<div id="mapView" class="ui-block-solo"
			style="min-width: 100%; max-height: 50%;">

			<div id="viewModeMap">
				<img alt="" src="images/icons/camera-ar.png"
					style="cursor: pointer;" onclick="selectDualMode()"> <img
					alt="" src="images/icons/smart.png" style="cursor: pointer;"
					onclick="selectCameraMode()">
			</div>
			<input type="hidden" class='tripInfo' id="tripIds"> <input
				type="hidden" class='tripInfo' id="tripGPSs"> <input
				type="hidden" class='tripInfo' id="tripLocations">
			<div id="map_canvas"></div>
			<div id="searchFields">
				<div class="ui-block-solo" id="autocompleteContainer">
					<ul id="autocompleteDestination" data-role="listview"
						data-inset="true" data-filter="true" data-input="#destinationName"></ul>
				</div>
				<div id="navBar" class="ui-grid-a" style="">
					<div class="ui-block-a">
						<fieldset data-role="controlgroup" data-mini="true"
							data-type="horizontal"
							style="float: left; display: inline-block;">
							<input type="radio" name="radio-choice-path-type" id="dirtroad"
								value="0" checked="checked"> <label for="wheelchair"><span
								class="ui-icon-wheelchair ui-btn-icon-notext inlineIcon NoDisk"></span></label>
							<label for="walking"><span
								class="ui-icon-walking ui-btn-icon-notext inlineIcon NoDisk"></span></label>
							<input type="radio" name="radio-choice-path-type" id="walking"
								value="1"> <label for="dirtroad"> <span
								class="ui-icon-dirt-road ui-btn-icon-notext inlineIcon NoDisk"></span></label>
						</fieldset>
					</div>
					<div class="ui-block-B">
						<fieldset data-role="controlgroup" data-mini="true"
							data-type="horizontal"
							style="float: right; display: inline-block;">
							<label for="clearTrip"><span
								class="ui-icon-clear-trip ui-btn-icon-notext inlineIcon NoDisk"></span></label>
							<input type="radio" name="radio-choice-v-2" id="clearTrip"
								value="1" onclick="removeTrip()"> <label
								for="currentLocation"><span
								class="ui-icon-current-location ui-btn-icon-notext inlineIcon NoDisk"></span></label>
							<input type="radio" name="radio-choice-v-2" id="currentLocation"
								value="1" onclick="findMylocation()"> <label
								for="startTrip"><span
								class="ui-icon-start-trip ui-btn-icon-notext inlineIcon NoDisk"></span></label>
							<input type="radio" name="radio-choice-v-2" id="startTrip"
								value="1" onclick="getThePath()">
						</fieldset>
					</div>
				</div>
				<div class="ui-block-solo">
					<input type="hidden" id="from" placeholder="Departure"> <input
						type="hidden" id="departureId" placeholder="DepartureId">
					<input type="hidden" id="departureName" placeholder="Departure">
					<input type="hidden" id="to"> <input type="hidden"
						id="destinationId" placeholder="DestinationId">
				</div>
				<div class="ui-block-solo">
					<input name="destinationName" id="destinationName"
						data-type="search" placeholder="Search for a place"
						data-mini="true" autocomplete="off" onkeyup="getDestination();">
				</div>
			</div>
		</div>
		<div id="cameraView" class="ui-block-solo">
			<div id="viewModeCamera">
				<img alt="" src="images/icons/camera-ar.png"
					style="cursor: pointer; display: block-inline; float: right;"
					onclick="selectDualMode()"> <img alt=""
					src="images/icons/maps.png"
					style="cursor: pointer; display: block-inline; float: right;"
					onclick="selectMapMode()">
			</div>
			<video id="videoContent"></video>
		</div>
	</div>
	<div id="destinationPresentation">
		<span class="dashboardRes" id="distanceDef"></span> <span
			class="dashboardRes" id="destinationDef"></span> <span
			class="dashboardHeader">Speed</span> <span class="dashboardRes"
			id="speedDef"></span>
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
	</div>
</body>
<script type="text/javascript"
	src="js/location/path.navigation.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/path.navigation.tools.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/path.navigation.directions.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.scanner.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.ar.js"></script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&libraries=places,geometry&callback=initiMap"
	type="text/javascript"></script>
</html>