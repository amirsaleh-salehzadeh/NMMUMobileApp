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
<script src="js/location/path.search.js"></script>
<body>
	<div id="barcodeDescription"></div>
	<input type="hidden" id="tripId">
	<div id="pageContents" style="min-width: 100%; min-height: 100%;">
		<div id="mapView" class="ui-block-solo"
			style="min-width: 100%; max-height: 50%;">
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
		<input type="button" id="openMenuBTN" onclick="openMenu()"> 
		<input type="button" id="openSearchBTN" onclick="openSearch();">
	</div>
	<div id="searchBarDiv">
		<div class="ui-block-solo" data-role="collapsible-set" id="autocompleteContainer">
			<ul id="autocompleteDestination" data-role="listview"
				data-inset="true" data-filter="true" data-input="#destinationName">
			</ul>
		</div>
		<div class="ui-block-solo" id="destinationNameDiv">
			<input name="destinationName" id="destinationName" data-type="search"
				placeholder="Search for a place" data-mini="true" autocomplete="off">

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
	type="text/javascript"></script>
</html>