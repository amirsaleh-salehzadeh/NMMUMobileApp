<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<!-- <meta http-equiv="Cache-Control" -->
<!-- 	content="no-cache, no-store, must-revalidate" /> -->
<!-- no-cache, no-store, must-revalidate -->
<meta http-equiv="Pragma" content="public" />
<!-- <meta http-equiv="Expires" content="0" /> -->
<meta http-equiv="Cache-control" content="public">
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
/* .scrollable { */
/* 	overflow-y: scroll; */
/* 	-webkit-overflow-scrolling: touch; */
/* } */

/* /* iOS specific fix, don't use it on Android devices */
*
/
/* .scrollable>* { */
/* 	-webkit-transform: translateZ(0px); */
/* } */
</style>
<script type="text/javascript">
	$(window).bind('load', function() {
		$('#work-in-progress').fadeOut(1000);
		browserCheck();
		iOSCheck();
		// 										errorMessagePopupOpen('hi');
		// 												arrivalMessagePopupOpen();
		// 		displayImage(266);
		var myTimer = setInterval(test, 60);
		// 		test();
	});
	var sdf = 0;
	function test() {
		sdf = sdf + 1;
		if (sdf >= 360)
			sdf = 0;
		displayImage(sdf);
	}
	function browserCheck() {
		// 		var ua = navigator.userAgent;

		// 	    if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini|Mobile|mobile|CriOS/i.test(ua))
		// 	       alert(1);

		// 	    else if(/Chrome/i.test(ua))
		// 	    	alert(2);

		// 	    else
		// 	    	errorMessagePopupOpen("For a better performance please use either Google Chrome, Firefox or Safari web browsers.");
		// 	    return;
		var isFirefox = typeof InstallTrigger !== 'undefined';
		// Safari 3.0+ "[object HTMLElementConstructor]" 
		var isSafari = /constructor/i.test(window.HTMLElement)
				|| (function(p) {
					return p.toString() === "[object SafariRemoteNotification]";
				})
						(!window['safari']
								|| (typeof safari !== 'undefined' && safari.pushNotification));
		// Chrome 1+
		var isChrome = !!window.chrome && !!window.chrome.webstore;

		if ((!isFirefox) && (!isSafari) && (!isChrome)) {
			errorMessagePopupOpen("For a better performance please use either Google Chrome, Firefox or Safari web browsers.");
		}
	}
	function iOSCheck() {

		// determine OS
		var platform = /iPad|iPhone|iPod/.test(navigator.userAgent)
				&& !window.MSStream;

		if (platform == "iOS") {
			$('#mapViewSelect').css('display', 'none');
			$('#dualModeSelect').css('display', 'none');
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


	<div id="pageContents" style="max-width: 100%; max-height: 100%;"
		data-role="page" class="scrollable">


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
			</div>
			<div class="ui-block-b" id="currentLocationInfoContainer"
				style="width: 67%">
				<span id="currentLocationInf"></span>
			</div>
		</div>



		<!-- 	SEARCH BUTTON -->


		<div id="searchBarDivTop">
			<div class="ui-block-solo" id="destinationNameDiv">
				<a data-role="button" href="#" data-rel="popup" href="#"
					id="destinationName" onclick="searchResultPopupOpen('To');">Find
					a Place</a> <span onclick="clearSearchBTN()"></span>
			</div>

		</div>


		<!-- 		ZOOM SETTINGS -->


		<div id="zoomSettings">
			<div id="menuBTNLeftSideDiv" class="ui-block-solo">
				<input type="button" class="zoomBTN" id="menuLeftSideBTN"
					onclick="showHideLeftSideMenu()">
			</div>
			<div id="menuItems">
				<div id="visitorCounter">
					<a href="https://www.reliablecounter.com" target="_blank"> <img
						src="https://www.reliablecounter.com/count.php?page=findme-sc.mandela.ac.za/NMMUWebApp/location.do?reqCode=mapView&digit=style/plain/33/&reloads=0"
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
						onclick="findMyLocation(); showHideLeftSideMenu();">
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
				<button id="start" onclick="searchResultPopupOpen('FROM');"
					data-role="none">
					<!-- 					WHILE CHANGING THIS TITLE CHANGE selectDestination() AS WELL -->
					Get <br />Directions
				</button>
			</div>
		</div>


		<!-- 		PANEL NAVIGATION BOTTOM -->


		<div id="barcodeDescription">
			<div class="ui-block-solo">
				<div style="display: inline-block; right: 48;">
					<span id="distanceLeftInf"></span> <span id="arrivalTimeInf">15':14"</span>
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
				<div class="ui-block-a">
					<img alt="" src="images/icons/grass.png"
						style="width: 32px; height: 32px; vertical-align: middle;">
				</div>
				<div class="ui-block-b">
					<img alt="" src="images/icons/normalSpeed.png"
						style="width: 32px; height: 32px; vertical-align: middle;">
				</div>
				<div class="ui-block-c">
					<img alt="" src="images/icons/wheelchair.png"
						style="width: 32px; height: 32px; vertical-align: middle;">
				</div>
			</div>
		</div>


		<!-- SEARCH VIEW POPUP -->


		<div data-role="popup" id="popupSearchResult" class="ui-content"
			data-position-to="window">
			<div class="ui-grid-a" id="searchPopupHeader">
				<img src="images/icons/destination.png" alt=""
					id="searchPopupHeaderIcon"><span id="destinationDefVal"></span>
			</div>
			<div class="ui-block-solo">
				<div
					class="ui-grid-a ui-block-solo popupSearchResultCloseBTNContainer"
					style="display: none;" id="departureButtonGroup">
					<div class="ui-block-a">
						<a data-role="button" href="#" id="popupSearchResultCloseBTNDual"
							onclick="closePopup();showBottomPanel();"
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
				<div class="ui-block-solo popupSearchResultCloseBTNContainer"
					id="destinationButtonGroup">
					<a data-role="button" href="#" id="popupSearchResultCloseBTN"
						onclick="closePopup();" class="closePopupMessage"><img
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
</body>
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
