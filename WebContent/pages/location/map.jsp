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

#searchFields {
	padding-bottom: 12px;
	right: 4em !important;
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
	background-image:
		url("images/icons/walking.png");
	background-size: ewpx 24px;
	border-radius: 0;
}

.ui-icon-dirt-road:after {
	background-image:
		url("images/icons/grass.png");
	background-size: 24px 24px;
	border-radius: 0;
}

.ui-icon-start-trip:after {
	background-image:
		url("images/icons/start.png");
	background-size: 24px 24px;
	border-radius: 0;
}

.ui-icon-current-location:after {
	background-image:
		url("images/icons/target.png");
	background-size: 24px 24px;
	border-radius: 0;
}

.ui-icon-clear-trip:after {
	background-image:
		url("images/icons/bin.png");
	background-size: 24px 24px;
	border-radius: 0;
}

#navigationDashboard {
	font-size: 14pt;
	color: black;
	background-color: white;
	margin-right: 2em;
	padding: 7px;
	background-color: rgba(255, 255, 255, 0.66);
	border: 3px solid black;
	display: none; 
}

.dashboardHeader {
	font-weight: bold;
}

.button, .button:visited {
	background: #222 url(overlay.png) repeat-x;
	display: inline-block;
	padding: 5px 10px 6px;
	color: #fff;
	text-decoration: none;
	-moz-border-radius: 6px;
	-webkit-border-radius: 6px;
	-moz-box-shadow: 0 1px 3px rgba(0,0,0,0.6);
	-webkit-box-shadow: 0 1px 3px rgba(0,0,0,0.6);
	text-shadow: 0 -1px 1px rgba(0,0,0,0.25);
	border-bottom: 1px solid rgba(0,0,0,0.25);
	position: relative;
	cursor: pointer
}


    .small.button, .small.button:visited 		{ font-size: 11px}
	.button, .button:visited,
	.medium.button, .medium.button:visited 		{ font-size: 13px;
												  font-weight: bold;
												  line-height: 1;
												  text-shadow: 0 -1px 1px rgba(0,0,0,0.25);
												  }

	.large.button, .large.button:visited 			        { font-size: 14px;
											  padding: 8px 14px 9px; }

	.super.button, .super.button:visited 			{ font-size: 34px;
											  padding: 8px 14px 9px; }
											  
.pink.button, .magenta.button:visited	{ background-color: #e22092; }
	.pink.button:hover					{ background-color: #c81e82; }
	.green.button, .green.button:visited	{ background-color: #91bd09; }
	.green.button:hover				        { background-color: #749a02; }
	.red.button, .red.button:visited		{ background-color: #e62727; }
	.red.button:hover					{ background-color: #cf2525; }
	.orange.button, .orange.button:visited	{ background-color: #ff5c00; }
	.orange.button:hover				{ background-color: #d45500; }
	.blue.button, .blue.button:visited   	        { background-color: #2981e4; }
	.blue.button:hover					{ background-color: #2575cf; }
	.yellow.button, .yellow.button:visited	{ background-color: #ffb515; }
	.yellow.button:hover				{ background-color: #fc9200; }											  

#mapNavBar .ui-btn
{
    background: #f6f6f6; url(overlay.png) repeat-x;
	display: inline-block;
	padding: 8px 14px 9px;
	color: #333;
	text-decoration: none;
	-moz-border-radius: 6px;
	-webkit-border-radius: 6px;
	-moz-box-shadow: 0 1px 3px rgba(0,0,0,0.6);
	-webkit-box-shadow: 0 1px 3px rgba(0,0,0,0.6);
	text-shadow: 0 -1px 1px rgba(0,0,0,0.25);
	border-bottom: 1px solid rgba(0,0,0,0.25);
	position: relative;
	cursor: pointer;
	width: auto;
	height: 20;
	font-size: 14px;
	
}	

.ui-icon-btnMapView:after {
	background-image:
		url("http://icons.iconarchive.com/icons/wwalczyszyn/iwindows/24/Recycle-Bin-icon.png");
	background-size: 24px 24px;
	border-radius: 0;
}

.ui-icon-btnARView:after {
	background-image:
		url("http://icons.iconarchive.com/icons/wwalczyszyn/iwindows/24/Recycle-Bin-icon.png");
	background-size: 24px 24px;
	border-radius: 0;
}

</style>
</head>
<body>
	<input type="hidden" id="tripId">
	<div data-role="tabs" id="tabs">
		<div data-role="navbar" id="mapNavBar">
			<ul>
				<li><a href="#mapView" data-ajax="false" class="ui-btn-active" id="btnMapView" >Map
						View</a></li>
				<li><a href="#" data-ajax="false" onclick="openAR();" id="btnARView" >AR
						View</a></li>
			</ul>
		</div>
		<div id="navigationDashboard">
<!-- 			<span class="dashboardHeader">Destination </span><span -->
<!-- 				class="dashboardRes" id="destinationDef">NMU main building in -->
<!-- 				south campus</span>  -->
				 <span class="dashboardHeader">Distance</span> <span
				class="dashboardRes" id="distanceDef">4 Km and 430 Meters</span><br />
				<span class="dashboardHeader">Distance to </span> <span
				class="dashboardRes" id="distanceToDef">Building 9</span><br />
			<span class="dashboardHeader">Speed</span> <span class="dashboardRes"
				id="speedDef">5.4 km/h</span>
		</div>
		<input type="hidden" class='tripInfo' id="tripIds">
		<input type="hidden" class='tripInfo' id="tripGPSs">
		<input type="hidden" class='tripInfo' id="tripLocations">
		<div id="mapView" class="ui-body-d ui-content">
			<div id="map_canvas"></div>
			<div id="searchFields" >
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
								value="1" onclick="startTrip()">
						</fieldset>
					</div>
				</div>
				<div class="ui-block-solo">
					<input type="hidden" id="from" placeholder="Departure"> <input
						type="hidden" id="departureId" placeholder="DepartureId">
					<input type="text" id="departureName" placeholder="Departure">
				</div>
				<div class="ui-block-solo">
					<input type="hidden" id="to" placeholder="Destination"> <input
						type="hidden" id="destinationId" placeholder="DestinationId">
					<input type="text" id="destinationName" placeholder="Destination">
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