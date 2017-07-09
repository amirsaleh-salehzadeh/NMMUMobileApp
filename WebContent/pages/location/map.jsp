<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<style type="text/css">
#map_canvas {
	height: 333px;
	width: 100%;
	top: 0;
	bottom: 0;
}

#autocompleteContainer {
	position: absolute;
	max-height: 22em;
	display: inline;
	bottom: 11em;
	overflow: auto;
	z-index: 1000;
	background-color: white;
}

#autocompleteDestination {
	display: block;
	cursor: pointer;
	margin: 0 !important;
}

#searchFields {
	padding-bottom: 17px;
	right: 5em !important;
	left: 0.66em !important;
}

.inlineIcon {
	display: inline-block;
	position: relative;
	vertical-align: middle;
	width: auto !important;
	padding: 0;
}

.NoDisk:after {
	background-color: transparent;
}

.ui-icon-walking:after {
	background-image: url("images/icons/walking.png");
	background-size: ewpx 24px;
	border-radius: 0;
}

.ui-icon-dirt-road:after {
	background-image: url("images/icons/grass.png");
	background-size: 24px 24px;
	border-radius: 0;
}

.ui-icon-start-trip:after {
	background-image: url("images/icons/start.png");
	background-size: 24px 24px;
	border-radius: 0;
}

.ui-icon-current-location:after {
	background-image: url("images/icons/target.png");
	background-size: 24px 24px;
	border-radius: 0;
}

.ui-icon-clear-trip:after {
	background-image: url("images/icons/bin.png");
	background-size: 24px 24px;
	border-radius: 0;
}

#navigationInfo {
	font-size: 10pt;
	color: black;
	padding-bottom: .66em;
	padding-top: .66em;
	padding-left: 17em;
	background-color: rgba(255, 255, 255, 0.33);
	border: 1px solid grey;
	display: block;
	width: 100%;
	min-height: 2.2em;
}
#destinationPresentation {
	font-size: 10pt;
	color: black;
	padding-left: 1em;
	padding-bottom: .66em;
	padding-right: 1em;
	padding-top: .66em;
	background-color: rgba(255, 255, 255, 0.33);
	display: none;
}

.dashboardHeader {
	font-weight: bold;
	font-size: 10pt;
	color: red;
}
</style>
</head>
<body>
	<input type="hidden" id="tripId">
	<div data-role="tabs" id="tabs">
		<div data-role="navbar">
			<ul>
				<li><a href="#mapView" data-ajax="false" class="ui-btn-active">Map
						View</a></li>
				<li><a href="#" data-ajax="false" onclick="openAR();">AR
						View</a></li>
			</ul>
		</div>
		<div id="navigationInfo">
			<span class="dashboardHeader">Speed</span> <span class="dashboardRes"
				id="speedDef">5.4 km/h</span>
		</div>
		<div id="destinationPresentation">
			<span
				class="dashboardRes" id="distanceDef">4 Km and 430 Meters to </span><span
				class="dashboardRes" id="destinationDef">NMU main building in south campus</span>
			<!-- 			<span class="dashboardHeader">Distance to </span> <span -->
			<!-- 				class="dashboardRes" id="distanceToDef">Building 9</span><br />  -->
		</div>
		<input type="hidden" class='tripInfo' id="tripIds"> <input
			type="hidden" class='tripInfo' id="tripGPSs"> <input
			type="hidden" class='tripInfo' id="tripLocations">
		<div id="mapView" class="ui-body-d ui-content">
			<div id="map_canvas"></div>
			<div id="searchFields">
				<div class="ui-block-solo" id="autocompleteContainer">
					<ul id="autocompleteDestination" data-role="listview"
						data-inset="true" data-filter="true" data-input="#destinationName"></ul>
				</div>
				<div id="navBar" class="ui-grid-a" style="width: 100%;">
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
								value="1" onclick="myLocation()"> <label for="startTrip"><span
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
	</div>
</body>
<script type="text/javascript" src="js/location/path.navigation.js"></script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&libraries=places,geometry&callback=initiMap"
	type="text/javascript"></script>
</html>