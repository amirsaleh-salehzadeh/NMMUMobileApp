var map, marker, infoWindow, markerDest, markerDepart;
var pathPolylineConstant, pathPolylineTrack, polylineConstantLength;
var walkingTimer, speed, speedTimer, heading, walkingWatchID, speedWatchID, altitude;
var distanceToNextPosition, distanceToDestination, angleToNextDestination;
var paths = [];
var ajaxCallSearch;

// KEY PRESS

function KeyPress(e) {
	var eventKeys = window.event ? event : e;

	// SHOW/VIEW VISITORS

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
	// if (GPSCook != "") {
	// if (markerDest != null)
	// markerDest.setMap(null);
	// markerDest = new google.maps.Marker({
	// position : getGoogleMapPosition(GPSCook.split("_")[GPSCook
	// .split("_").length - 1]),
	// map : map,
	// icon : 'images/map-markers/marker-orange.png'
	// });
	// resetWalking();
	// drawConstantPolyline();
	// showViewItems();
	// return;
	// }
	var url = "REST/GetLocationWS/GetADirectionFromTo?departureId="
			+ $("#departureId").val() + "&destinationId="
			+ $("#destinationId").val() + "&from=" + $("#from").val() + "&to="
			+ $("#to").val() + "&pathType=1";
	if ($("#to").val().length > 2) {
		var destPoint = getGoogleMapPosition($("#to").val());
		if (markerDest != null)
			markerDest.setMap(null);
		markerDest = new google.maps.Marker({
			position : destPoint,
			map : map,
			icon : 'images/map-markers/marker-orange.png'
		});
	}
	$
			.ajax({
				url : url,
				cache : true,
				async : true,
				// dataType: 'json',
				beforeSend : function() {
					blurTrue();
					showBottomPanel();
					$("#locationInf").html('');
					$(".spinnerLoading").css('display', 'block').trigger(
							"create");
				},
				success : function(data) {
					var pathIds = "";
					var pathGPSs = "";
					var pathLocations = "";
					var dataLength = data.length;
					$.each(data, function(k, l) {
						if (k == 0) {
							pathIds = l.depL.id + "," + l.desL.id;
							if (l.pathRoute != null && l.pathRoute.length > 0) {
								pathGPSs += l.depL.g.replace(" ", "") + "_"
										+ l.pathRoute + "_"
										+ l.desL.g.replace(" ", "");
							} else {
								pathGPSs += l.depL.g.replace(" ", "") + "_"
										+ l.desL.g.replace(" ", "");
							}
							pathLocations += l.depL.n + "_" + l.desL.n;
							// alert($("#departureId").val());
							// $("#departureId").val(l.departure.locationID);
						} else {
							if (l.pathRoute != null && l.pathRoute.length > 0) {
								pathGPSs += l.pathRoute + "_"
										+ l.desL.g.replace(" ", "");
							} else {
								pathGPSs += "_" + l.desL.g.replace(" ", "");
							}

							pathLocations += "_" + l.desL.n;
							$("#destinationDef").html(l.desL.n);
						}
					});
					$("#departureId").val(pathIds.split(",")[0]);
					$("#destinationId").val(
							pathIds.split(",")[pathIds.split(",").length - 1]);
					setCookie('TripPathIdsCookie', pathIds, 1);
					setCookie('TripPathGPSCookie', pathGPSs, 1);
					setCookie('TripPathLocationsCookie', pathLocations, 1);
					blurFalse();
					if (dataLength == 0) {
						hideBottomPanel();
						blurFalse();
						removeTrip();
						errorMessagePopupOpen("There is no routes for this enquiry");
					}else{
						resetWalking();
						drawConstantPolyline();
						hideBottomPanel();
						setTimeout(showViewItems(), 1500);
					}
				},
				error : function(xhr, ajaxOptions, thrownError) {
					hideBottomPanel();
					blurFalse();
					removeTrip();
					errorMessagePopupOpen(thrownError);
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
	setCookie("TripPathIdsCookie", getCookie("TripPathIdsCookie").replace(
			removeVarIDS + ",", ""), 1);
	setCookie("TripPathGPSCookie", getCookie("TripPathGPSCookie").replace(
			removeVarGPS + ",", ""), 1);
	setCookie("TripPathLocationsCookie", getCookie("TripPathLocationsCookie")
			.replace(removeVarNames + "_", ""), 1);
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
			console.log(getGoogleMapPosition(nextDestGPS[i]));
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
			strokeColor : '#081B2C',
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
	marker.setIcon('images/icons/target-old.png');
	console.log(distanceToNextPosition);
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
	// clearTimeout(walkingTimer);
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
	$("#tripLocations").val("");
	$("#destinationName").val("");
	if (markerDepart != null)
		markerDepart.setMap(null);
	if (markerDest != null)
		markerDest.setMap(null);
	markerDest = null;
	markerDepart = null;
	findMyLocation();
	clearSearchBTN();
	showViewItems();
}

var myLatLng = {
	lat : -34.009211,
	lng : 25.669051
};

var errorHandler = function(errorObj) {
	errorMessagePopupOpen(errorObj.code + ": " + errorObj.message);

};

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
	infoWindow.setPosition(pos);
	infoWindow
			.setContent(browserHasGeolocation ? 'Error: The Geolocation service failed.'
					: 'Error: Your browser doesn\'t support geolocation.');
	errorMessagePopupOpen(browserHasGeolocation ? 'Error: The Geolocation service failed.'
			: 'Error: Your browser doesn\'t support geolocation.');
	infoWindow.open(map);
}

function initiateNavigation() {
	var bounds = new google.maps.LatLngBounds();
	bounds.extend(markerDest.getPosition());
	bounds.extend(marker.getPosition());
	map.fitBounds(bounds);
	getThePath();
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
	marker.setIcon('images/icons/target-old.png');
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
			errorMessagePopupOpen(thrownError);
		}
	});
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
	marker.setIcon('images/icons/target-old.png');
	marker.setPosition(currentPos);
	map.panTo(currentPos);
	map.setCenter(currentPos);
};

$(document).ready(function() {
	$('#destinationName').val("");
	removeTrip();
	getLocationTypePanel();
});