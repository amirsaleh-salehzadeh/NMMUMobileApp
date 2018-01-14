<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<!-- no-cache, no-store, must-revalidate -->
<meta http-equiv="Pragma" content="public" />
<meta http-equiv="Expires" content="0" />
<!-- <meta http-equiv="Cache-control" content="public"> -->
<title>Find It | Nelson Mandela University</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<script src="js/jquery.min.js"></script>
<script src="js/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript" src="js/jquery/jquery-ui.js"></script>
<script type="text/javascript"
	src="js/location/camera/scanner/adapter.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.1.10/vue.min.js"></script>
<script type="text/javascript"
	src="js/location/camera/scanner/instascan.min.js"></script>
<link rel="icon" type="image/png" href="favicon.ico">
<link rel="stylesheet"
	href="css/themes/default/jquery.mobile-1.4.5.min.css">
<!-- <link rel="stylesheet" href="css/jquery-mobile/jqm-demos.css"> -->
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
.scrollable {
	overflow-y: scroll;
	-webkit-overflow-scrolling: touch;
}

/* /* iOS specific fix, don't use it on Android devices */
.scrollable>* {
	-webkit-transform: translateZ(0px);
}
</style>
<script type="text/javascript">
	$(window).bind('load', function() {
		// 		browserCheck();
		// 										errorMessagePopupOpen('hi');
		// 												arrivalMessagePopupOpen();
		// 		displayImage(266);
		// 		var myTimer = setInterval(test, 60);
	});
	var sdf = 0;
	function browserCheck() {
		var ua = navigator.userAgent;
		var platform = null;
		var browser = null;

		if (/Android/i.test(ua)) {
			platform = "Android";
		}
		// there is no way to be 100% sure of safari as all/most browsers use "Safari"in their userAgent strings
		//if ( /Safari/i.test(ua)){browser="Safari";}
		if (/Chrome/i.test(ua)) {
			browser = "Chrome";
		}
		if (/CriOS/i.test(ua)) {
			browser = "Chrome";
			platform = "iOS";
		}

		if (/iOS/i.test(ua)) {
			platform = "iOS";
		}
		// if iOS not picking up comment out the above line and uncomment the bottom one 
		//if(/iPad|iPhone|iPod/i.test(ua)){platform="iOS";}

		if (/rv/i.test(ua)) {
			browser = "Firefox";
		}

		if (platform == null) {
			platform = "desktop";
		}

		// 		if (platform == "iOS" || platform == "desktop") {
		$('#dualModeSelect').css('display', 'none');
		// 		}
		if (browser == null) {
			errorMessagePopupOpen("For better performance please use either Google Chrome, Firefox or Safari web browsers.");
		}
	}
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


	<div id="pageContents"
		style="width: 100%; height: 100%; overflow: hidden;" data-role="page"
		class="scrollable">


		<!-- 		MAP -->


		<div id="map_canvas" class="ui-block-solo"></div>


		<!-- 		HIDDEN INPUTS -->


		<input type="hidden" id="tripLocations"> <input type="hidden"
			id="from"> <input type="hidden" id="departureId" value="0">
		<input type="hidden" id="to"> <input type="hidden"
			id="destinationId"> <input type="hidden" id="pathType"
			value="2">



		<!-- 		CAMERA PANEL SMALL -->


		<div id="cameraView" class="ui-block-solo">
			<video id="videoContent"></video>
		</div>


		<!-- 		CURRENT LOCATION SHOW -->


		<div class="ui-grid-a ui-block-solo" id="currentLocationShow">
			<div class="ui-block-a" style="width: 33%">
				<div id="directionShow">
					<canvas id="directionCanvas" width="100%" height="100%"
						style="background-color: transparent; margin: 0 auto;"></canvas>
				</div>
				<div id="distanceToNextPoint">110 m</div>
			</div>
			<div class="ui-block-b" id="currentLocationInfoContainer"
				style="width: 67%">
				<span id="currentLocationInf"></span>
			</div>
		</div>



		<!-- 	SEARCH BUTTON -->


		<div id="searchBarDivTop">
			<div class="ui-block-solo" id="destinationNameDiv"
				style="display: none;">
				<a data-role="button" href="#" data-rel="popup" href="#"
					id="destinationName" onclick="searchResultPopupOpen();">Find a
					Place</a> <span onclick="clearSearchBTN()"></span>
			</div>

		</div>


		<!-- 		ZOOM SETTINGS -->

		<!-- 		<div id="menuBTNLeftSideDiv" style="width: 100%;" -->
		<!-- 			class="ui-block-solo"> -->
		<input type="button" class="zoomBTN" id="menuLeftSideBTN"
			onclick="showHideLeftSideMenu()"> <input type="button"
			class="zoomBTN" id="searchLeftSideBTN"
			onclick="searchResultPopupOpen();" data-theming="none">
		<!-- 		</div> -->
		<div id="zoomSettings">
			<div id="menuItems">
				<div id="visitorCounter">
					<a href="http://www.reliablecounter.com" target="_blank"> <img
						src="http://www.reliablecounter.com/count.php?page=findme-sc.mandela.ac.za/NMMUWebApp/location.do?reqCode=mapView&digit=style/plain/33/&reloads=0"
						alt="" title="" border="0"></a>
				</div>
				<div class="ui-block-solo">
					<input type="button" class="zoomBTN" id="mapViewSelect"
						onclick="selectMapMode()"></input> <input type="button"
						class="zoomBTN" id="dualModeSelect" onclick="selectDualMode()"></input>
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
				<div class="ui-block-solo">
					<!-- 			<button id="mylocation" class="navbtn" onclick="">My&nbsp;location</button> -->
					<input type="button" class="zoomBTN" id="mylocation"
						onclick="setOnMyLocation(); showHideLeftSideMenu();">
				</div>
			</div>
		</div>


		<!-- 	BOTTOM PANEL -->


		<div class="ui-block-solo" id="locationInfoDiv">
			<div class="blurBlue"></div>
			<div class="spinnerLoading" style="display: none;"></div>
			<div id="LocationInfoContainer">
				<div class="ui-grid-a">
					<div class="ui-block-a"></div>
					<div class="ui-block-b"></div>

				</div>
				<div id="locationInf"></div>
				<!-- 				WHILE CHANGING THIS TITLE CHANGE selectDestination() AS WELL -->
				<button id="start" onclick="selectDeparturePopupOpen();"
					data-role="none">
					<!-- 					WHILE CHANGING THIS TITLE CHANGE selectDestination() AS WELL -->
					Directions
				</button>
			</div>
		</div>


		<!-- 		PANEL NAVIGATION BOTTOM -->


		<div id="barcodeDescription">
			<div class="ui-block-solo">
				<div style="display: inline-block; right: 48;">
					<span id="distanceLeftInf"></span>
					<!-- 					<span id="arrivalTimeInf">4':14"</span> -->
					<div class="ui-block-solo" style="display: inline;">
						<span id="departureDescriptionSpan"></span><br> <img
							alt="Dest" src="images/icons/finish.png" width="32" height="32">
						<span id="destinationDescriptionSpan"></span>
					</div>
				</div>
				<div
					style="display: inline-block; right: 0; top: -6; width: 48px; position: absolute;"
					onclick="removeTrip()">
					<div>
						<img alt="#" src="images/icons/clearInput.png">
					</div>
				</div>
			</div>
			<div class="ui-block-solo ui-grid-b" id="tripTypeBar">
				<div class="ui-block-a" onclick="setPathType(1);" id="dirtRoadType">
					<img alt="" src="images/icons/grass.png"
						style="width: 32px; height: 32px;">
				</div>
				<div class="ui-block-b" onclick="setPathType(2);" id="walkwayType">
					<img alt="" src="images/icons/normalSpeed.png"
						style="width: 32px; height: 32px;">
				</div>
				<div class="ui-block-c" onclick="setPathType(6);"
					id="wheelChairType">
					<img alt="" src="images/icons/wheelchair.png"
						style="width: 32px; height: 32px;">
				</div>
				<!-- 				<div -->
				<!-- 					style="position: absolute; min-height: 100%; min-width: 100%; background-color: rgba(0, 0, 0, 0.5)"></div> -->
			</div>
		</div>


		<!-- SEARCH VIEW POPUP -->


		<div data-role="popup" id="popupSearchResult" class="ui-content"
			data-position-to="window">
			<div class="ui-block-solo">
				<div class="ui-block-solo popupSearchResultCloseBTNContainer"
					id="destinationButtonGroup">
					<a data-role="button" href="#" id="popupSearchResultCloseBTN"
						onclick="removeTrip();closePopup();" class="closePopupMessage"><img
						src="images/icons/clearInput.png" alt=""
						class="closeMessageButtonIcon" />Close</a>
				</div>
			</div>
			<div class="ui-block-solo" id="searchFieldDiv">
				<input type="text" id="searchField" placeholder="Find a Place"
					data-role="none"> <span onclick="searchFieldDivClearBTN();"></span>
			</div>
			<div class="ui-block-solo" id="resultsListViewDiv">
				<div data-role="content">
					<div data-role="collapsible-set" id="resultsListViewContentDiv"
						data-input="#searchField" data-filter="true"
						data-collapsed="false"></div>
				</div>
			</div>
		</div>



		<!-- 		SELECT DEPARTURE POPUP -->



		<div data-role="popup" id="popupSelectDeparture" class="ui-content"
			data-position-to="window">
			<div class="ui-block-solo popupGridItem">SELECT STARTING POINT
			</div>
			<div class="ui-block-solo popupGridItem">
				<a data-role="button" href="#"
					onclick="searchResultPopupOpenForDeparture();"><img
					src="images/icons/target.png" alt="" />From a buiding</a>

			</div>
			<div class="ui-block-solo popupGridItem">
				<a data-role="button" href="#"
					onclick="getDirectionFromCurrentLocation();"><img
					src="images/icons/target.png" alt="" />My Current Location</a>

			</div>
			<div class="ui-block-solo popupGridItem">
				<a data-role="button" href="#" onclick="closePopup();"><img
					src="images/icons/clearInput.png" alt=""
					id="closePopupSelectDeparture" />Cancel</a>
			</div>
		</div>



		<!-- 	ERROR POPUP -->


		<div id="popupErrorMessage" class="ui-content" style="display: none;">
			<div id="errorMessageHeader" class="ui-block-solo">Error!</div>
			<div id="errorMessageContent" class="ui-block-solo"></div>
			<div class="ui-block-solo popupSearchResultCloseBTNContainer"
				id="closeErrorPopupMessage">
				<a data-role="button" href="#" onclick="closePopup();"
					class="closePopupMessage" id="popupErrorMessageCloseBTN"><img
					src="images/icons/clearInput.png" alt=""
					class="closeMessageButtonIcon" />Close</a>
			</div>
		</div>


		<!-- 	ARRIVAL POPUP -->


		<div data-role="popup" id="popupArrivalMessage" class="ui-content"
			data-position-to="window">
			<!-- 			<a href="#" data-role="button" class="popupCloseBtn" -->
			<!-- 				onclick="$('#popupArrivalMessage').popup('close');blurFalse();"></a> -->
			<div id="arrivalMessageHeader" class="ui-block-solo">You are at</div>
			<div id="arrivalMessageContent" class="ui-block-solo">Content</div>
			<div class="ui-block-solo">
				<a data-role="button" href="#" onclick="closePopup();"
					class="closePopupMessage" id="popupArrivalMessageCloseBTN"><img
					src="images/icons/clearInput.png" alt=""
					class="closeMessageButtonIcon" />Close</a>
			</div>
		</div>
	</div>
	<div id="googleMapMarkerLabel" class="labelStyleClass"></div>
</body>
<script src="https://openlayers.org/en/v4.5.0/build/ol.js"></script>
<script
	src="https://cdn.rawgit.com/bjornharrtell/jsts/gh-pages/1.4.0/jsts.min.js"></script>
<script type="text/javascript"
	src="js/location/navigation/path.navigation.locations.polygon.js"></script>
<script type="text/javascript"
	src="js/location/navigation/path.navigation.tools.js"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.scanner.js"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.ar.js"></script>
<script type="text/javascript"
	src="js/location/camera/path.navigation.camera.js"></script>
<script type="text/javascript"
	src="js/location/navigation/path.navigation.directions.js"></script>
<script type="text/javascript"
	src="js/location/navigation/path.navigation.search.panel.js"></script>
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
