<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta http-equiv="Cache-Control"
	content="public" />
<!-- no-cache, no-store, must-revalidate -->
<!-- <meta http-equiv="Pragma" content="public" /> -->
<!-- <meta http-equiv="Expires" content="0" /> -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<link rel="icon" type="image/png" href="favicon.ico">
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
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/location/path.navigation.css">
<link rel="stylesheet" href="css/location/path.navigation.buttons.css">
<link rel="stylesheet"
	href="css/location/path.navigation.current.location.css">
<link rel="stylesheet"
	href="css/location/path.navigation.search.list.css">
<link rel="stylesheet" href="css/location/path.navigation.trip.info.css">
<link rel="stylesheet"
	href="css/location/path.navigation.infowindow.css">
<link rel="stylesheet" href="css/location/loading.nmu.css">
<link rel="stylesheet" href="css/location/message.dialog.css">
<style type="text/css">
</style>
<script type="text/javascript">
	$(window).bind('load', function() {
		$('#work-in-progress').fadeOut(1000);
		// 				errorMessagePopupOpen('hi');
		// 										arrivalMessagePopupOpen();
// 		displayImage(110);

	});
</script>
<body>

	<!-- INITIAL LOADING PAGE -->


	<div id="work-in-progress">
		<img alt="Nelson Mandela University" src="images/logos/nmulogo-s.jpg"
			width="100%" style="margin-top: 11px;">
		<!-- 		<div> -->
		<!-- 			<img>Smart Navigation Widget -->
		<!-- 		</div> -->
		<div class="spinner"></div>
		<br>
		<div id="fountainTextG">
			<div id="fountainTextG_1" class="fountainTextG">L</div>
			<div id="fountainTextG_2" class="fountainTextG">O</div>
			<div id="fountainTextG_3" class="fountainTextG">A</div>
			<div id="fountainTextG_4" class="fountainTextG">D</div>
			<div id="fountainTextG_5" class="fountainTextG">I</div>
			<div id="fountainTextG_6" class="fountainTextG">N</div>
			<div id="fountainTextG_7" class="fountainTextG">G</div>
		</div>
	</div>

	<!-- 		PAGE CONTENT -->


	<div id="pageContents" style="max-width: 100%; max-height: 100%;"
		data-role="page">


		<!-- 	SELECT PATH POPUP -->


		<div data-role="popup" id="popupPathType" style="display: none;">
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


		<!-- 		MAP -->


		<div id="mapView" class="ui-block-solo">
			<div id="map_canvas"></div>
		</div>


		<!-- 		HIDDEN INPUTS -->


		<input type="hidden" id="tripLocations"> <input type="hidden"
			id="from" placeholder="Departure"> <input type="hidden"
			id="departureId" placeholder="DepartureId" value="0"> <input
			type="hidden" id="to"> <input type="hidden"
			id="destinationId" placeholder="DestinationId">


		<!-- 		FULL SCREEN -->


		<div class="ui-block-solo" style="float: right; display: none;"
			id="viewFullScreen">
			<a href="#" data-role="button" id="btnToggleFullscreen" alt=""
				onclick="toggleFullScreen()"></a>
		</div>


		<!-- 		CAMERA PANEL SMALL -->


		<div id="cameraView" class="ui-block-solo">
			<video id="videoContent"></video>
		</div>


		<!-- 		PANEL TOP -->


		<div id="barcodeDescription" class="ui-block-solo">
			<div class="ui-grid-a ui-block-solo">
				<div class="ui-block-a" style="width: 7%">
					<img alt="" src="images/icons/normalSpeed.png"
						id="walkingImageInfoBox">
				</div>
				<div class="ui-block-b" style="width: 93%">
					<input type="text" class="descriptionInput"
						id="departureDescriptionInput" value="Current Location"
						data-role="none" disabled="disabled"> <input type="text"
						data-role="none" class="descriptionInput" disabled="disabled"
						id="destinationDescriptionInput">
				</div>
			</div>
			<span id="distanceLeftInf"></span>
			<!-- 				<span id="arrivalTimeInf">15':14"</span> -->
		</div>


		<!-- 	SEARCH BUTTON -->


		<div id="searchBarDivTop">
			<div class="ui-block-solo" id="destinationNameDiv">
				<a data-role="button" href="#" data-rel="popup" href="#"
					data-transition="turn" id="destinationName"
					onclick="searchResultPopupOpen('Where To?');">Find a Place</a> <span
					onclick="clearSearchBTN()"></span>
			</div>

		</div>


		<!-- 		MAP VIEW MODE -->


		<!-- 		<div id="viewMapType"> -->
		<!-- 			<input type="button" class="zoomBTN" id="satelliteView" -->
		<!-- 				onclick="mapSattelView()"> <input type="button" -->
		<!-- 				class="zoomBTN" id="mapViewIcon" onclick="mapMapView()"> -->
		<!-- 		</div> -->


		<!-- 		ZOOM SETTINGS -->


		<div id="zoomSettings">
			<div id="visitorCounter">
				<a href="https://www.reliablecounter.com" target="_blank"> <img
					src="https://www.reliablecounter.com/count.php?page=findme-sc.mandela.ac.za/NMMUWebApp/location.do?reqCode=mapView&digit=style/plain/33/&reloads=0"
					alt="" title="" border="0"></a>
			</div>
			<div class="ui-block-solo" style="display: none;">
				<input disabled="disabled" type="text" id="visitorCounter"
					placeholder="" value="">
			</div>
			<div class="ui-block-solo">
				<input type="button" class="zoomBTN" id="satelliteView"
					onclick="mapSattelView()"> <input type="button"
					class="zoomBTN" id="mapViewIcon" onclick="mapMapView()">
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
				style="background-color: white;"></canvas>
		</div>


		<!-- 		CURRENT LOCATION SHOW -->


		<div class="ui-grid-a ui-block-solo" id="currentLocationShow">
			<div class="ui-block-a" id="currentLocationButtonContainer"
				onclick="removeTrip()">
				<div class="ui-block-solo">
					<button id="remove" data-role="none"></button>
				</div>
				<div class="ui-block-solo">Stop</div>
			</div>
			<div class="ui-block-b" id="currentLocationInfoContainer">
				<span id="currentLocationInf"></span>
			</div>
		</div>


		<!-- 	BOTTOM PANEL -->


		<div class="ui-block-solo" id="locationInfoDiv">
			<div class="blurBlue"></div>
			<div class="spinnerLoading" style="display: none;"></div>
			<div id="LocationInfoContainer">
				<div id="locationInf"></div>
				<!-- WHILE CHANGING THIS TITLE CHANGE selectDestination() AS WELL -->
				<button id="start" onclick="searchResultPopupOpen('From?');">
					<!-- WHILE CHANGING THIS TITLE CHANGE selectDestination() AS WELL -->
					Get <br />Directions
				</button>
			</div>
		</div>


		<!-- 		 SCANNER BUTTON -->


		<div id="scannerBTNContainer" style="display: none;">
			<button class="navbtn" id="mapViewSelect" onclick="selectMapMode()">MAP</button>
			<button class="navbtn" id="dualModeSelect" onclick="selectDualMode()">Scan</button>
		</div>



		<!-- 		BOTTOM PANEL -->
		<!-- 	<div class="ui-grid-c ui-block-solo" id="dashboardPanel"> -->
		<!-- 			QR OR MAP MODE -->
		<!-- 		<div class="ui-block-a"> -->
		<!-- 			<div class="navbtnsdiv"> -->
		<!-- 				<button class="navbtn" id="mapViewSelect" onclick="selectMapMode()">MAP</button> -->
		<!-- 				<button type="button" class="navbtn" id="dualModeSelect" -->
		<!-- 					onclick="selectDualMode()">Scan</button> -->
		<!-- 			</div> -->
		<!-- 		</div> -->
		<!-- 				    MY CURRENT LOCATION -->
		<!-- 		<div class="ui-block-c"> -->
		<!-- 			<div class="navbtnsdiv"> -->
		<!-- 				<button id="mylocation" class="navbtn" onclick="findMyLocation()">My&nbsp;location</button> -->
		<!-- 			</div> -->
		<!-- 		</div> -->
		<!-- 	</div> -->


		<!-- 	ERROR POPUP -->


		<div data-role="popup" id="popupErrorMessage" class="ui-content"
			data-position-to="window" data-transition="turn">
			<a href="#" data-role="button" class="popupCloseBtn"
				onclick="$('#popupErrorMessage').popup('close');$('#map_canvas').toggleClass('off');"></a>
			<div id="errorMessageHeader" class="ui-block-solo">Error!</div>
			<div id="errorMessageContent" class="ui-block-solo"></div>
			<div class="ui-block-solo">
				<a data-role="button" href="#"
					onclick="$('#popupErrorMessage').popup('close');$('#map_canvas').toggleClass('off');"
					class="closePopupMessage"><img
					src="images/icons/clearInput.png" alt=""
					class="closeMessageButtonIcon" />Close</a>
			</div>
		</div>


		<!-- 	ARRIVAL POPUP -->


		<div data-role="popup" id="popupArrivalMessage" class="ui-content"
			data-position-to="window" data-transition="turn">
			<a href="#" data-role="button" class="popupCloseBtn"
				onclick="$('#popupArrivalMessage').popup('close');$('#map_canvas').toggleClass('off');"></a>
			<div id="arrivalMessageHeader" class="ui-block-solo">Header</div>
			<div id="arrivalMessageContent" class="ui-block-solo">Content</div>
			<div class="ui-block-solo">
				<a data-role="button" href="#"
					onclick="$('#popupArrivalMessage').popup('close');$('#map_canvas').toggleClass('off');"
					class="closePopupMessage"><img
					src="images/icons/clearInput.png" alt=""
					class="closeMessageButtonIcon" />Close</a>
			</div>
		</div>


		<!-- SEARCH VIEW POPUP -->


		<div data-role="popup" id="popupSearchResult" class="ui-content"
			data-position-to="window" data-transition="turn">
			<a href="#" data-role="none" class="popupCloseBtn"
				onclick="$('#popupSearchResult').popup('close');$('#map_canvas').toggleClass('off');"></a>
			<div class="ui-block-solo" id="searchPopupHeader"></div>
			<div class="ui-block-solo" id="searchFieldDiv">
				<input type="text" id="searchField" placeholder="Find a Place"
					data-role="none"> <span onclick="searchFieldDivClearBTN();"></span>
			</div>
			<div class="ui-block-solo">
				<ul data-role="listview" id="resultsListView" data-filter="true"
					data-inset="true" data-input="#searchField"></ul>
			</div>
			<div class="ui-grid-a ui-block-solo" style="display: none;"
				id="departureButtonGroup">
				<div class="ui-block-a">
					<a data-role="button" href="#" id="popupSearchResultCloseBTNDual"
						onclick="$('#popupSearchResult').popup('close');$('#map_canvas').toggleClass('off');"
						class="closePopupMessage"><img
						src="images/icons/clearInput.png" alt=""
						class="closeMessageButtonIcon" />Close</a>
				</div>
				<div class="ui-block-b">
					<a data-role="button" href="#"
						id="popupSearchResultCurrentLocationBTN"
						onclick="getDirectionFromCurrentLocation();"
						class="closePopupMessage"><img src="images/icons/target.png"
						alt="" class="closeMessageButtonIcon" />My Location</a>
				</div>
			</div>
			<a data-role="button" href="#" id="popupSearchResultCloseBTN"
				onclick="$('#popupSearchResult').popup('close');$('#map_canvas').toggleClass('off');"
				class="closePopupMessage" style="margin: 5% auto !important;"><img src="images/icons/clearInput.png"
				alt="" class="closeMessageButtonIcon" />Close</a>

		</div>


	</div>
</body>
<script type="text/javascript"
	src="js/location/navigation/path.navigation.tools.js"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.scanner.js"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.ar.js"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.js"></script>
<script type="text/javascript" src="js/jquery/jquery-ui.js"></script>
<script type="text/javascript"
	src="js/location/navigation/path.navigation.directions.js"></script>
<script src="js/location/navigation/path.navigation.search.panel.js"></script>
<script type="text/javascript"
	src="js/location/navigation/path.navigation.js"></script>
<script type="text/javascript"
	src="js/location/navigation/path.navigation.map.js"></script>
<script type="text/javascript"
	src="js/location/navigation/path.navigation.popups.js"></script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&libraries=places,geometry&callback=initiMap"
	type="text/javascript"></script>
</html>
