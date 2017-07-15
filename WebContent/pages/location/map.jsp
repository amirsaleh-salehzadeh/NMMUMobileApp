<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<style type="text/css">
<<<<<<< HEAD

#map_canvas,#videoContent,#cameraView {
	width: 100%;
	top: 0;
	bottom: 0;
	display: block;
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
/* height: 333px;
	width: 100%; */
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

.ui-icon-pointer:after {
	background-image: url("images/icons/pointer.png");
	background-size: 32px 32px;
	border-radius: 0;
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

#viewModeCamera {
	display: block;
	position: absolute;
	float: right;
	padding-top: .6em;
	padding-left: .66em;
	z-index: 2;
	width: 100%;
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


    .small.button, .small.button:visited 	{ font-size: 11px}
	.button, .button:visited,
	.medium.button, .medium.button:visited 	{ font-size: 13px;
											font-weight: bold;
											line-height: 1;
											text-shadow: 0 -1px 1px rgba(0,0,0,0.25); }

	.large.button, .large.button:visited 	{ font-size: 14px; padding: 8px 14px 9px; }

	.super.button, .super.button:visited 	{ font-size: 34px; padding: 8px 14px 9px; }
											  
	.pink.button, .magenta.button:visited	{ background-color: #e22092; }
	.pink.button:hover						{ background-color: #c81e82; }
	.green.button, .green.button:visited	{ background-color: #91bd09; }
	.green.button:hover				        { background-color: #749a02; }
	.red.button, .red.button:visited		{ background-color: #e62727; }
	.red.button:hover						{ background-color: #cf2525; }
	.orange.button, .orange.button:visited	{ background-color: #ff5c00; }
	.orange.button:hover					{ background-color: #d45500; }
	.blue.button, .blue.button:visited   	{ background-color: #2981e4; }
	.blue.button:hover						{ background-color: #2575cf; }
	.yellow.button, .yellow.button:visited	{ background-color: #ffb515; }
	.yellow.button:hover					{ background-color: #fc9200; }											  

/* 
.jqm-home .ui-grid-a {
	margin: 0em 0em .2em;    
}

this fixes the gap problem for the mapNavBar but introduces a bug which doesnt allow the deparure/destination bars to resize properly now and then, so im leaving it here till we fix issue

*/

#mapNavBar .ui-btn {
	display: inline-block;
	/*padding: 8px 14px 9px;*/
	text-decoration: none;
	-moz-border-radius: 6px;
	-webkit-border-radius: 6px;
	-moz-box-shadow: 0 1px 3px rgba(0,0,0,0.6);
	-webkit-box-shadow: 0 1px 3px rgba(0,0,0,0.6);
	text-shadow: 0 -1px 1px rgba(0,0,0,0.25);
	border-bottom: 1px solid rgba(0,0,0,0.25);
	position: relative;
	cursor: pointer;
	height: 28px;
	font-size: 16px;
	border: none;
	width: 50%;
	
}	

#btnMapView {
	/*width: auto;
	background: #38c url(overlay.png) repeat-x;
	background-color: #38c;
	color: #333;*/
	
	background-image: url(css/images/map/maps-icon.png); /* 24px x 24px */
    
    background-repeat: no-repeat;  /* make the background image appear only once */
    background-position: 0px 0px;  /* equivalent to 'top left' */
    padding-left: 48px;     /* make text start to the right of the image */
    vertical-align: middle; /* align the text vertically centered */
    
}

@media (max-width: 1500px){
	#mapNavBar .ui-btn{
		/* for tinkering later*/}
	}	

#btnARView {
	/*width: auto;
	background: #f6f6f6 url(overlay.png) repeat-x;
	background-color: #38c;
	color: #333;*/
	background-image: url(css/images/map/smart-icon.png); /* 24px x 24px */
    
    background-repeat: no-repeat;  /* make the background image appear only once */
    background-position: 0px 0px;  /* equivalent to 'top left' */
    padding-left: 48px;     /* make text start to the right of the image */
    vertical-align: middle; /* align the text vertically centered */
}
#btnDualMode {
	margin: 0;
	padding: 0;
	border: 0;
	cursor: pointer; 
	width: 48px; 
	height: 48px;
	background-image: url(images/icons/camera-ar.png); /* 48px x 48px */
    background-repeat: no-repeat;  /* make the background image appear only once */
    background-position: 0px 0px;  /* equivalent to 'top left' */
 	background-color: transparent;
 	box-shadow: none;
}
#btnCameraMode {
	margin: 0;
	padding: 0;
	border: 0;
	cursor: pointer; 
	width: 48px; 
	height: 48px;
	background-image: url(images/icons/smart.png); /* 48px x 48px */
    background-repeat: no-repeat;  /* make the background image appear only once */
    background-position: 0px 0px;  /* equivalent to 'top left' */
	background-color: transparent;
	box-shadow: none;
}
#btnToggleFullscreen {
	margin: 0;
	padding: 0;
	border: 0;
	cursor: pointer; 
	width: 48px; 
	height: 48px;
	background-image: url(images/icons/maximise.png); /* 48px x 48px */
    background-repeat: no-repeat;  /* make the background image appear only once */
    background-position: 0px 0px;  /* equivalent to 'top left' */
 	background-color: transparent;
 	box-shadow: none;
}

#btnToggleFullscreen.off {
	background-image: url(images/icons/minimise.png); /* 48px x 48px */
}

#viewModeMap {
	margin: .66em .66em .66em;
	padding-left: 1em;
	height: 100px;
}

/* Tooltip container */ /* Further info at https://www.w3schools.com/css/css_tooltip.asp */
.tooltip {
    position: relative;
    display: inline-block;
 /* border-bottom: 1px dotted black;  If you want dots under the hoverable text or button */
}

/* Tooltip text */
.tooltip .tooltiptext {
    visibility: hidden;
    width: 48px;
    background-color: white;
    color: black;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;
    position: absolute;
    z-index: 1;
    top: 110%;
    left: 50%;
    margin-left: -24px; /* Use half of the width (48/2 = 24), to center the tooltip */
    /* Fade in tooltip - takes 1 second to go from 0% to 100% opac: */
    opacity: 0;
    transition: opacity 3s;
}

.tooltip .tooltiptext::after {
    content: "";
    position: absolute;
    bottom: 100%; /* Arrow At the top of the tooltip */
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: transparent transparent white transparent;
}

/* Show the tooltip text when you mouse over the tooltip container */
.tooltip:hover .tooltiptext {
    visibility: visible;
    opacity: 1;
}
=======
>>>>>>> Amir
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
	src="js/location/camera/scanner/adapter.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.1.10/vue.min.js"></script>
<script type="text/javascript"
	src="js/location/camera/scanner/instascan.min.js"></script>
<link rel="stylesheet" href="css/jquery-mobile/jqm-demos.css">
<script src="js/jquery.min.js"></script>
<!-- <script src="js/index.js"></script> -->
<script src="js/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/location/path.navigation.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<<<<<<< HEAD

=======
	<div id="barcodeDescription"></div>
	<input type="hidden" id="tripId">
>>>>>>> Amir
	<div id="pageContents" style="min-width: 100%; min-height: 100%;">
		<div id="mapView" class="ui-block-solo"
			style="min-width: 100%; max-height: 50%;">
<<<<<<< HEAD
		<!-- 	<div data-role="navbar" id="mapNavBar">
			<ul>
				<li><a href="#mapView" data-ajax="false" class="ui-btn-active" id="btnMapView" >Map
						View</a></li>
				<li><a href="#" data-ajax="false" onclick="openAR();" id="btnARView" >AR
						View</a></li>
			</ul>
			</div> -->
			<div id="destinationPresentation">
				<span class="dashboardRes" id="distanceDef">4 Km and 430
					Meters to </span><span class="dashboardRes" id="destinationDef">NMU
					main building in south campus</span> <span class="dashboardHeader">Speed</span>
				<span class="dashboardRes" id="speedDef">5.4 km/h</span>
				<!-- 			<span class="dashboardHeader">Distance to </span> <span -->
				<!-- 				class="dashboardRes" id="distanceToDef">Building 9</span><br />  -->
			</div>
			<div id="viewModeMap" class="ui-grid-b" >	
				<div class="ui-block-a">
				<div class="tooltip">
					<span class="tooltiptext">Dual Mode</span>
					<a href="#" data-role="button" id="btnDualMode"
						alt=""  onclick="selectDualMode()" align="top"></a>
					</div>
				</div>
					
				<div class="ui-block-b">
					<div class="tooltip">
					<span class="tooltiptext">Camera mode</span>	
					<a href="#" data-role="button" id="btnCameraMode" 
						alt="" onclick="selectCameraMode()" align="top"></a>
					</div>
				</div>
				
				<div class="ui-block-c">
					<div class="tooltip">
					<span class="tooltiptext">Full Screen</span>
					<a href="#" data-role="button" id="btnToggleFullscreen"
						alt="" onclick="toggleFullScreen()" align="top"></a>
					</div>
				</div>	
			</div>
			<input type="hidden" class='tripInfo' id="tripIds">
			<input type="hidden" class='tripInfo' id="tripGPSs">
			<input type="hidden" class='tripInfo' id="tripLocations">

=======
			<!-- 			<div id="viewModeMap"> -->
			<!-- 				<img alt="" src="images/icons/camera-ar.png" -->
			<!-- 					style="cursor: pointer;" onclick="selectDualMode()"> <img -->
			<!-- 					alt="" src="images/icons/smart.png" style="cursor: pointer;" -->
			<!-- 					onclick="selectCameraMode()"> -->
			<!-- 			</div> -->
			<input type="hidden" class='tripInfo' id="tripIds"> <input
				type="hidden" class='tripInfo' id="tripGPSs"> <input
				type="hidden" class='tripInfo' id="tripLocations"> <input
				type="hidden" id="from" placeholder="Departure"> <input
				type="hidden" id="departureId" placeholder="DepartureId"> <input
				type="hidden" id="departureName" placeholder="Departure"> <input
				type="hidden" id="to"> <input type="hidden"
				id="destinationId" placeholder="DestinationId">
>>>>>>> Amir
			<div id="map_canvas"></div>
			<!-- 			<div id="searchFields"> -->
			<!-- 							<div class="ui-block-solo" id="autocompleteContainer"> -->
			<!-- 								<ul id="autocompleteDestination" data-role="listview" -->
			<!-- 									data-inset="true" data-filter="true" data-input="#destinationName"></ul> -->
			<!-- 							</div> -->
			<!-- 				<div id="navBar" class="ui-grid-a" style=""> -->
			<!-- 					<div class="ui-block-a"> -->
			<!-- 						<fieldset data-role="controlgroup" data-mini="true" -->
			<!-- 							data-type="horizontal" -->
			<!-- 							style="float: left; display: inline-block;"> -->
			<!-- 							<input type="radio" name="radio-choice-path-type" id="dirtroad" -->
			<!-- 								value="0" checked="checked"> <label for="wheelchair"><span -->
			<!-- 								class="ui-icon-wheelchair ui-btn-icon-notext inlineIcon NoDisk"></span></label> -->
			<!-- 							<label for="walking"><span -->
			<!-- 								class="ui-icon-walking ui-btn-icon-notext inlineIcon NoDisk"></span></label> -->
			<!-- 							<input type="radio" name="radio-choice-path-type" id="walking" -->
			<!-- 								value="1"> <label for="dirtroad"> <span -->
			<!-- 								class="ui-icon-dirt-road ui-btn-icon-notext inlineIcon NoDisk"></span></label> -->
			<!-- 						</fieldset> -->
			<!-- 					</div> -->
			<!-- 				</div> -->
			<!-- 				<div class="ui-block-solo"> -->
			<!-- 					<input type="hidden" id="from" placeholder="Departure"> <input -->
			<!-- 						type="hidden" id="departureId" placeholder="DepartureId"> -->
			<!-- 					<input type="hidden" id="departureName" placeholder="Departure"> -->
			<!-- 					<input type="hidden" id="to"> <input type="hidden" -->
			<!-- 						id="destinationId" placeholder="DestinationId"> -->
			<!-- 				</div> -->
			<!-- 							<div class="ui-block-solo"> -->
			<!-- 								<input name="destinationName" id="destinationName" -->
			<!-- 									data-type="search" placeholder="Search for a place" -->
			<!-- 									data-mini="true" autocomplete="off" onkeyup="getDestination();"> -->
			<!-- 							</div> -->
			<!-- 			</div> -->
		</div>
		<div id="cameraView" class="ui-block-solo">
			<video id="videoContent"></video>
		</div>
	</div>
	<div id="buttonContainer">
		<input type="button" id="openMenuBTN" onclick="openMenu()"> <input
			type="button" id="openSearchBTN" onclick="openSearch()">
	</div>
	<div id="searchBarDiv">
		<div class="ui-block-solo" id="autocompleteContainer">
			<ul id="autocompleteDestination" data-role="listview"
				data-inset="true" data-filter="true" data-input="#destinationName"></ul>
		</div>
		<div class="ui-block-solo" id="destinationNameDiv">
			<input name="destinationName" id="destinationName" data-type="search"
				placeholder="Search for a place" data-mini="true" autocomplete="off"
				onkeyup="getDestination();">
		</div>
		<!-- 		<ul data-role="listview" class="ui-listview-outer"> -->
		<!-- 			<li><a href="#">Humans</a></li> -->
		<!-- 			<li data-role="collapsible" data-iconpos="right" data-shadow="false" -->
		<!-- 				data-corners="false">     -->
		<!-- 				<h2>Fish</h2>      -->
		<!-- 				<ul data-role="listview" data-shadow="false" data-inset="true" -->
		<!-- 					data-corners="false"> -->
		<!-- 					<li><a href="#">Salmon</a></li> -->
		<!-- 					<li>Pollock</li> -->
		<!-- 					<li>Trout</li> -->
		<!-- 				</ul> -->
		<!-- 			</li> -->
		<!-- 			<li data-role="collapsible" data-iconpos="right" data-shadow="false" -->
		<!-- 				data-corners="false">     -->
		<!-- 				<h2>Choose your preference</h2>      -->
		<!-- 				<form> -->
		<!-- 					       -->
		<!-- 					<fieldset data-role="controlgroup" data-type="horizontal"> -->
		<!-- 						        <label>Birds<input type="checkbox" -->
		<!-- 							id="choose-birds-regular"></label>         <label>Humans<input -->
		<!-- 							type="checkbox" id="choose-humans-regular"></label>         <label>Fish<input -->
		<!-- 							type="checkbox" id="choose-fish-regular"></label>        -->
		<!-- 					</fieldset> -->
		<!-- 					     -->
		<!-- 				</form>    -->
		<!-- 			</li> -->
		<!-- 		</ul> -->
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
<<<<<<< HEAD
					<div class="ui-block-B">
						<fieldset data-role="controlgroup" data-mini="true"
							data-type="horizontal"
							style="float: right; display: inline-block;">

							
						<!--  left ui-block-B behind in case we change our mind or need to put more buttons here -->	
								
							<label for="clearTrip"><span
								class="ui-icon-clear-trip ui-btn-icon-notext inlineIcon NoDisk"></span></label>
							<input type="radio" name="radio-choice-v-2" id="clearTrip"
								value="1" onclick="removeTrip()"> <label
								for="currentLocation"><span
								class="ui-icon-current-location ui-btn-icon-notext inlineIcon NoDisk"></span></label>
							<input type="radio" name="radio-choice-v-2" id="currentLocation"
								value="1" onclick="findMyLocation()"> <label
								for="startTrip"><span
								class="ui-icon-start-trip ui-btn-icon-notext inlineIcon NoDisk"></span></label>
							<input type="radio" name="radio-choice-v-2" id="startTrip"
								value="1" onclick="getThePath()">
				
						</fieldset> 
					</div>
				</div>
				<div class="ui-grid-a ui-responsive" style="width: 100%;">
					<div class=ui-block-a >
						<input type="hidden" id="from" placeholder="Departure"> <input
							type="hidden" id="departureId" placeholder="DepartureId">
						<input type="hidden" id="departureName" placeholder="Departure">
						<input type="hidden" id="to">
						<input type="hidden"
							id="destinationId" placeholder="DestinationId">
					</div>
					 <!--  <div class=ui-block-b > 
						<fieldset data-role="controlgroup" data-mini="true"
						data-type="horizontal"
						style="display: inline-block;">
						<label for="currentLocation">
						<span
							class="ui-icon-current-location ui-btn-icon-notext inlineIcon NoDisk">
						</span>
						</label>
						<input type="radio" name="radio-choice-v-2" id="currentLocation"
							value="1" onclick="myLocation()">
						</fieldset>
					</div> -->
				</div>
				<div class="ui-grid-a ui-responsive" style="width: 100%;">
					<div class=ui-block-a >
						<input name="destinationName" id="destinationName"
							data-type="search" placeholder="Search for a place"
							data-mini="true" autocomplete="off" onkeyup="getDestination();">
					</div>
				 	<!-- <div class=ui-block-b >
				 		<fieldset data-role="controlgroup" data-mini="true"
						data-type="horizontal"
						style="display: inline-block;">
						<label for="clearTrip">
							<span
								class="ui-icon-clear-trip ui-btn-icon-notext inlineIcon NoDisk">
							</span>
						</label>
						<input type="radio" name="radio-choice-v-2" id="clearTrip"
							value="1" onclick="removeTrip()">
							
						<label for="startTrip">
							<span
								class="ui-icon-start-trip ui-btn-icon-notext inlineIcon NoDisk">
							</span>
						</label>
						<input type="radio" name="radio-choice-v-2" id="startTrip"
							value="1" onclick="startTrip()">
						
						</fieldset>			
					</div>	-->
=======
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
								type="button" class="navbtn" id="start" onclick="getThePath()">
							<input type="button" class="navbtn" id="mylocation"
								onclick="findMyLocation()">
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
>>>>>>> Amir
				</div>
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
	src="js/location/path.navigation.map.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.scanner.js?noCache=true"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.ar.js"></script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&libraries=places,geometry&callback=initiMap"
	type="text/javascript">
</script>
<script type="text/javascript">
	$(document).ready(function() {	
		refreshPlaceHolders();	
	});	
</script>
</html>