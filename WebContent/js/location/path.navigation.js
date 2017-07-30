var map, marker, infoWindow, markerDest;
var pathPolylineConstant, pathPolylineTrack, polylineConstantLength;
var walkingTimer, speed, speedTimer, heading, walkingWatchID, speedWatchID, altitude;
var distanceToNextPosition, distanceToDestination, angleToNextDestination;
var paths = [];
var ajaxCallSearch;
function KeyPress(e) {
	var eventKeys = window.event ? event : e;
	if (eventKeys.keyCode == 86 && eventKeys.ctrlKey && eventKeys.shiftKey) {
		if ($("#visitorCounter").css("display") == "none") {
			$("#visitorCounter").css("display", "block");
			$("#visitorCounter").css("display");
		} else {
			$("#visitorCounter").css("display", "none");
			$("#visitorCounter").css("display");

		}
	}
}

document.onkeydown = KeyPress;
// starting a trip, fetches the path to destination, creates a trip and draw
// polylines
function getThePath() {
	if ($("#from").val().length < 5)
		findMyLocation();
	var GPSCook = getCookie("TripPathGPSCookie");
	if (GPSCook != "") {
		if (markerDest != null)
			markerDest.setMap(null);
		markerDest = new google.maps.Marker({
			position : getGoogleMapPosition(GPSCook.split("_")[GPSCook
					.split("_").length - 1]),
			map : map,
			icon : 'images/icons/finish.png'
		});
		resetWalking();
		drawConstantPolyline();
		showViewItems();
		return;
	}
	var url = "REST/GetLocationWS/GetADirectionFromTo?departureId="
			+ $("#departureId").val() + "&destinationId="
			+ $("#destinationId").val() + "&from=" + $("#from").val() + "&to="
			+ $("#to").val() + "&pathType=1";
	// + $("[name='radio-choice-path-type']:checked").val();
	if ($("#to").val().length > 2) {
		var destPoint = getGoogleMapPosition($("#to").val());
		if (markerDest != null)
			markerDest.setMap(null);
		markerDest = new google.maps.Marker({
			position : destPoint,
			map : map,
			icon : 'images/icons/finish.png'
		});
	}
	$.ajax({
		url : url,
		cache : false,
		async : false,
		success : function(data) {
			var pathIds = "";
			var pathGPSs = "";
			var pathLocations = "";
			$.each(data, function(k, l) {
				if (k == 0) {
					pathIds = l.departure.locationID + ","
							+ l.destination.locationID;
					pathGPSs += l.departure.gps.replace(" ", "") + "_"
							+ l.destination.gps.replace(" ", "");
					pathLocations += l.departure.locationName + "_"
							+ l.destination.locationName;
					$("#departureName").val(l.departure.locationName);
					$("#destinationName").val(l.destination.locationName);
					$("#departureId").val(l.departure.locationID);
				} else {
					pathGPSs += "_" + l.destination.gps.replace(" ", "");
					pathLocations += "_" + l.destination.locationName;
					$("#destinationDef").html(l.destination.locationName);
				}
			});
			$("#departureId").val(pathIds.split(",")[0]);
			$("#destinationId").val(
					pathIds.split(",")[pathIds.split(",").length - 1]);
			setCookie('TripPathIdsCookie', pathIds, 1);
			setCookie('TripPathGPSCookie', pathGPSs, 1);
			setCookie('TripPathLocationsCookie', pathLocations, 1);
			resetWalking();
			drawConstantPolyline();
			showViewItems();
			$('#popupPathType').popup();
			$('#popupPathType').popup('close');
			$('#popupPathType').popup("destroy");
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});
}

function removeTheNextDestination() {
	var tripIds = getCookie("TripPathIdsCookie").split(",");
	var tripGPSs = getCookie("TripPathGPSCookie").split("_");
	var tripLocations = getCookie("TripPathLocationsCookie").split("_");
	var closestDest = 0;
	var closestId = 0;
	var curGPS = marker.getPosition();
	if (tripGPSs.length > 1)
		for ( var int = 0; int < tripGPSs.length; int++) {
			var dist = getDistance(curGPS.lat() + "," + curGPS.lng(),
					tripGPSs[int]);
			if (int == 0)
				closestDest = dist;
			if (dist < closestDest) {
				closestDest = dist;
				closestId = int;
			}
		}
	var removeVarGPS = "";
	var removeVarIDS = "";
	var removeVarNames = "";
	if (tripGPSs.length > 1)
		for ( var int = 0; int < tripGPSs.length; int++) {
			if (int == 0) {
				removeVarGPS = tripGPSs[int];
				removeVarIDS = tripIds[int];
				removeVarNames = tripLocations[int];
			} else {
				removeVarGPS += "_" + tripGPSs[int];
				removeVarIDS += "," + tripIds[int];
				removeVarNames += "_" + tripLocations[int];
			}
			if (int == closestId)
				break;
		}
	// $("#tripIds").val($("#tripIds").val().replace(removeVarIDS + ",", ""));
	setCookie("TripPathIdsCookie", getCookie("TripPathIdsCookie").replace(
			removeVarIDS + ",", ""), 1);
	setCookie("TripPathGPSCookie", getCookie("TripPathGPSCookie").replace(
			removeVarGPS + ",", ""), 1);
	setCookie("TripPathLocationsCookie", getCookie("TripPathLocationsCookie")
			.replace(removeVarNames + "_", ""), 1);
	// $("#tripGPSs").val($("#tripGPSs").val().replace(removeVarGPS + "_", ""));
	// $("#tripLocations").val(
	// $("#tripLocations").val().replace(removeVarNames + ",", ""));
	// setCookie('TripPathIdsCookie', $("#tripIds").val(), 1);
	// setCookie('TripPathGPSCookie', $("#tripGPSs").val(), 1);
	// setCookie('TripPathLocationsCookie', $("#tripLocations").val(), 1);
	if (pathPolylineTrack != undefined)
		pathPolylineTrack.setMap(null);
	if (pathPolylineConstant != undefined)
		pathPolylineConstant.setMap(null);
	pathPolylineTrack = null;
	pathPolylineConstant = null;
	if (getCookie("TripPathGPSCookie").length > 1)
		drawConstantPolyline();
}

function drawConstantPolyline() {
	var tmpPathCoor = [];
	var nextDestGPS = getCookie("TripPathGPSCookie").split("_");
	polylineConstantLength = 0;
	if (nextDestGPS.length > 1)
		for ( var i = 0; i < nextDestGPS.length; i++) {
			if (i < nextDestGPS.length - 1)
				polylineConstantLength += getDistance(nextDestGPS[i],
						nextDestGPS[i + 1]);
			tmpPathCoor.push(getGoogleMapPosition(nextDestGPS[i]));
		}
	else
		return;
	var lineSymbol = {
		path : google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
		scale : 4,
		strokeColor : '#F7AF23'
	};
	if (pathPolylineConstant != undefined)
		pathPolylineConstant.setMap(null);
	if (pathPolylineConstant == null)
		pathPolylineConstant = new google.maps.Polyline({
			path : tmpPathCoor,
			geodesic : true,
			icons : [ {
				icon : lineSymbol,
				offset : '100%'
			} ],
			strokeColor : '#0C1C2C',
			strokeOpacity : 1,
			strokeWeight : 6
		});
	else
		pathPolylineConstant.setPath(tmpPathCoor);
	pathPolylineConstant.setMap(map);
	paths.push(pathPolylineConstant);
	animateCircle(pathPolylineConstant);
	resetWalking();
}

function updatePolyLine(currentPos, altitude) {
	var pointPath = new google.maps.LatLng(parseFloat(currentPos.lat),
			parseFloat(currentPos.lng));
	var tmpPathCoor = [];
	var nextDestGPS = getCookie("TripPathGPSCookie").split("_");
	var nextPosition = getGoogleMapPosition(nextDestGPS[0]);
	tmpPathCoor.push(pointPath);
	tmpPathCoor.push(nextPosition);
	distanceToNextPosition = google.maps.geometry.spherical
			.computeDistanceBetween(pointPath, nextPosition);
	var headingTo1st = google.maps.geometry.spherical.computeHeading(pointPath,
			nextPosition);
	marker.setIcon(null);
	marker.setIcon({
		path : google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
		scale : 7,
		strokeWeight : 3,
		rotation : headingTo1st
	});
	if (nextDestGPS.length > 1) {
		var secondNextPosition = getGoogleMapPosition(nextDestGPS[1]);
		var headingTo2st = google.maps.geometry.spherical.computeHeading(
				nextPosition, secondNextPosition);
		angleToNextDestination = headingTo2st - headingTo1st;
		console.log("headingTo1st " + headingTo1st);
		console.log("headingTo2st " + headingTo2st);
		heading = angleToNextDestination;
		$("#navigationDesc").html(getDistanceLeft(distanceToNextPosition));
		getAngleDirection(angleToNextDestination);
	}
	if (distanceToNextPosition <= 5) {
		removeTheNextDestination();
	}
	distanceToDestination = polylineConstantLength + distanceToNextPosition;
	getTripInfo();
	if (pathPolylineTrack == null) {
		var lineSymbol = {
			path : 'M 0,-1 0,1',
			strokeOpacity : 1,
			scale : 4
		};
		pathPolylineTrack = new google.maps.Polyline({
			path : tmpPathCoor,
			icons : [ {
				icon : lineSymbol,
				offset : '0',
				repeat : '20px'
			} ],
			strokeColor : 'white',
			strokeOpacity : 0,
			strokeWeight : 3,
			map : map
		});
		paths.push(pathPolylineTrack);
		animateCircle(pathPolylineTrack);
	} else
		pathPolylineTrack.setPath(tmpPathCoor);
	pathPolylineTrack.setMap(null);
	pathPolylineTrack.setMap(map);
}

function resetWalking() {
	if (walkingWatchID != undefined) {
		clearTimeout(walkingTimer);
		navigator.geolocation.clearWatch(walkingWatchID);
		walkingWatchID = null;
	}
	walkToDestination();
}

function findMyLocation() {
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(successGetCurrentPosition,
				errorHandler, {
					enableHighAccuracy : true,
					maximumAge : 1000
				});
	} else {
		handleLocationError(false, infoWindow, map.getCenter());
	}
}

function walkToDestination() {
	if (walkingWatchID != undefined) {
		navigator.geolocation.clearWatch(walkingWatchID);
		walkingWatchID = null;
	}
	if (navigator.geolocation) {
		walkingWatchID = navigator.geolocation.watchPosition(
				successTrackingHandler, errorHandler, {
					enableHighAccuracy : true
				});
	} else {
		handleLocationError(false, infoWindow, map.getCenter());
	}
}

function removeTrip() {
	for ( var i = 0; i < paths.length; i++) {
		if (paths[i] != undefined)
			paths[i].setMap(null);
	}
	if (pathPolylineTrack != undefined)
		pathPolylineTrack.setMap(null);
	if (pathPolylineConstant != undefined)
		pathPolylineConstant.setMap(null);
	pathPolylineTrack = null;
	pathPolylineConstant = null;
	clearTimeout(walkingTimer);
	if (walkingWatchID != undefined) {
		navigator.geolocation.clearWatch(walkingWatchID);
		walkingWatchID = null;
	}
	setCookie('TripIdCookie', "", 0);
	setCookie('TripPathIdsCookie', "", 0);
	setCookie('TripPathGPSCookie', "", 0);
	setCookie('TripPathLocationsCookie', "", 0);
	$("#from").val("");
	$("#departureId").val("0");
	$("#to").val("");
	$("#destinationId").val("0");
	$("#to").val("");
	$("#tripIds").val("");
	$("#tripGPSs").val("");
	$("#tripLocations").val("");
	$("#destinationName").val("");
	if (markerDest != null)
		markerDest.setMap(null);
	markerDest = null;
	$("#tripId").val("");
	$("#remove").css("display", "none");
	findMyLocation();
	showViewItems();
}

var myLatLng = {
	lat : -34.009211,
	lng : 25.669051
};

var errorHandler = function(errorObj) {
	alert(errorObj.code + ": " + errorObj.message);

};
function initiMap() {
	speed = 0;
	heading = 0;
	var myStyle = [ {
		featureType : "administrative",
		elementType : "labels",
		stylers : [ {
			visibility : "off"
		} ]
	}, {
		featureType : "poi",
		elementType : "labels",
		stylers : [ {
			visibility : "off"
		} ]
	}, {
		featureType : "road",
		elementType : "labels",
		stylers : [ {
			visibility : "off"
		} ]
	}, {
		featureType : "transit.station",
		elementType : "labels",
		stylers : [ {
			visibility : "off"
		} ]
	}, {
		featureType : "water",
		elementType : "labels",
		stylers : [ {
			visibility : "off"
		} ]
	}, {
		featureType : "landscape.man_made",
		elementType : "geometry",
		stylers : [ {
			color : "#f7f1df"
		} ]
	}, {
		featureType : "landscape.natural",
		elementType : "geometry",
		stylers : [ {
			color : "#d0e3b4"
		} ]
	}, {
		featureType : "landscape.natural.terrain",
		elementType : "geometry",
		stylers : [ {
			visibility : "off"
		} ]
	}, {
		featureType : "poi.business",
		elementType : "all",
		stylers : [ {
			visibility : "off"
		} ]
	}, {
		featureType : "poi.medical",
		elementType : "geometry",
		stylers : [ {
			color : "#fbd3da"
		} ]
	}, {
		featureType : "poi.park",
		elementType : "geometry",
		stylers : [ {
			color : "#bde6ab"
		} ]
	}, {
		featureType : "road",
		elementType : "geometry.stroke",
		stylers : [ {
			visibility : "off"
		} ]
	}, {
		featureType : "road.highway",
		elementType : "geometry.fill",
		stylers : [ {
			color : "#ffe15f"
		} ]
	}, {
		featureType : "road.highway",
		elementType : "geometry.stroke",
		stylers : [ {
			color : "#efd151"
		} ]
	}, {
		featureType : "road.arterial",
		elementType : "geometry.fill",
		stylers : [ {
			color : "#ffffff"
		} ]
	}, {
		featureType : "road.local",
		elementType : "geometry.fill",
		stylers : [ {
			color : "black"
		} ]
	}, {
		featureType : "water",
		elementType : "geometry",
		stylers : [ {
			color : "#a2daf2"
		} ]
	} ];

	map = new google.maps.Map(document.getElementById('map_canvas'), {
		center : {
			lat : -34.009211,
			lng : 25.669051
		},
		zoom : 14,
		zoomControl : false,
		streetViewControl : false,
		mapTypeControl : false,
		rotateControl : false,
		fullscreenControl : false
	// ,
	});
	map.mapTypes.set('mystyle', new google.maps.StyledMapType(myStyle, {
		name : 'My Style'
	}));
	input = document.getElementById('to');
	map.controls[google.maps.ControlPosition.TOP_LEFT].push(document
			.getElementById('viewMapType'));
	map.controls[google.maps.ControlPosition.RIGHT_CENTER].push(document
			.getElementById('zoomSettings'));
	map.controls[google.maps.ControlPosition.LEFT_TOP].push(document
			.getElementById('searchBarDivTop'));
	map.controls[google.maps.ControlPosition.LEFT_CENTER].push(document
			.getElementById('scannerBTNContainer'));
	map.setMapTypeId('mystyle');
	findMyLocation();
	$("#mapViewIcon").fadeOut();
	selectMapMode();
	getLocationTypePanel();
	if (getCookie("TripPathGPSCookie") != "")
		getThePath();
	else
		showViewItems();
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
	infoWindow.setPosition(pos);
	infoWindow
			.setContent(browserHasGeolocation ? 'Error: The Geolocation service failed.'
					: 'Error: Your browser doesn\'t support geolocation.');
	alert(browserHasGeolocation ? 'Error: The Geolocation service failed.'
			: 'Error: Your browser doesn\'t support geolocation.');
	infoWindow.open(map);
}

function isFullScreen() {
	return (document.fullScreenElement && document.fullScreenElement !== null)
			|| document.mozFullScreen || document.msFullScreen
			|| document.webkitIsFullScreen;
}

function requestFullScreen(element) {
	if (element.requestFullscreen)
		element.requestFullscreen();
	else if (element.msRequestFullscreen)
		element.msRequestFullscreen();
	else if (element.mozRequestFullScreen)
		element.mozRequestFullScreen();
	else if (element.webkitRequestFullscreen)
		element.webkitRequestFullscreen();
}

function exitFullScreen() {
	if (document.exitFullscreen)
		document.exitFullscreen();
	else if (document.msExitFullscreen)
		document.msExitFullscreen();
	else if (document.mozCancelFullScreen)
		document.mozCancelFullScreen();
	else if (document.webkitExitFullscreen)
		document.webkitExitFullscreen();
}

function toggleFullScreen(element) {
	if (isFullScreen()) {
		$('#btnToggleFullscreen').toggleClass('off');
		exitFullScreen();
	} else {
		$('#btnToggleFullscreen').toggleClass('off');
		requestFullScreen(element || document.documentElement);
	}
}

function animateCircle(line) {
	var count = 0;
	window.setInterval(function() {
		count = (count + 1) % 200;
		var icons = line.get('icons');
		icons[0].offset = (count / 2) + '%';
		line.set('icons', icons);
	}, 50);
}

var successTrackingHandler = function(position) {
	var currentPos = {
		lat : position.coords.latitude,
		lng : position.coords.longitude
	};
	$("#from").val(position.coords.latitude + "," + position.coords.longitude);
	$("#departureName").val("Current Location");
	if (position.coords.heading != null) {
		heading = position.coords.heading;
	}
	if (position.coords.speed != null) {
		speed = position.coords.speed * 3.6;
		speed = Math.round(speed);
	}
	altitude = position.coords.altitude;
	if (getCookie("TripPathGPSCookie").length > 5)
		updatePolyLine(currentPos, altitude);
	if (marker == null) {
		marker = new google.maps.Marker({
			map : map
		});
		marker.addListener('click', function() {
			map.setZoom(17);
			map.setCenter(this.getPosition());
			resetWalking();
		});
	}
	marker.setIcon(null);
	marker.setIcon({
		path : google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
		scale : 7,
		strokeWeight : 3,
		rotation : heading
	});
	marker.setPosition(currentPos);
};

var successGetCurrentPosition = function(position) {
	var currentPos = {
		lat : position.coords.latitude,
		lng : position.coords.longitude
	};
	$("#from").val(position.coords.latitude + "," + position.coords.longitude);
	var url = "REST/GetLocationWS/FindClosestBuilding?from=" + $("#from").val();
	$.ajax({
		url : url,
		cache : false,
		async : true,
		success : function(data) {
			$("#currentLocationInf").html(data.locationName);
			$("#currentLocationInfoContainer").trigger("create");
			$("#departureId").html(data.locationID);
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});
	$("#departureName").val("Current Location");
	if (marker == null) {
		marker = new google.maps.Marker({
			map : map
		});
		marker.addListener('click', function() {
			map.setZoom(17);
			map.setCenter(this.getPosition());
			resetWalking();
		});
	}
	marker.setIcon(null);
	marker.setIcon({
		path : google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
		scale : 7,
		strokeWeight : 3,
		rotation : heading
	});
	marker.setPosition(currentPos);
	map.panTo(currentPos);
	map.setCenter(currentPos);
};

$(document).ready(function() {
	// $("#mapViewIcon").fadeOut();
	// selectMapMode();
	// getLocationTypePanel();
	// showViewItems();
});

function resizeCompass() {
	if ($("#compassID").css("width") == "70px") {
		$("#compassID").css("height", "120px");
		$("#compassID").css("width", "120px");
		$("#compassArrowID").css("height", "120px");
		$("#compassArrowID").css("width", "120px");
		$("#compassDiscImg").css("height", "120px");
		$("#compassDiscImg").css("width", "120px");
	} else {
		$("#compassID").css("height", "70px");
		$("#compassID").css("width", "70px");
		$("#compassArrowID").css("height", "70px");
		$("#compassArrowID").css("width", "70px");
		$("#compassDiscImg").css("height", "70px");
		$("#compassDiscImg").css("width", "70px");
	}

}

function emergencyClick() {
	alert("Emergency button coming soon");
}
