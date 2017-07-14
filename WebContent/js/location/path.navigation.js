var map, marker, infoWindow, markerDest;
var pathPolylineConstant, pathPolylineTrack, polylineConstantLength;
var walkingTimer, speed, speedTimer, heading, walkingWatchID, speedWatchID;
var distanceToNextPosition, distanceToDestination, angleToNextDestination;
var alpha, beta, gamma;
var paths = [];

function getThePath() {
	if (pathPolylineConstant != null)
		return;
	if ($("#from").val().length < 5)
		findMyLocation();
	var GPSCook = getCookie("TripPathGPSCookie");
	if (GPSCook != "") {
		if (markerDest != null)
			markerDest.setMap(null);
		markerDest = new google.maps.Marker(
				{
					position : getGoogleMapPosition(GPSCook.split("_")[GPSCook.split("_").length-1]),
					map : map,
					icon : 'http://icons.iconarchive.com/icons/icons8/windows-8/48/Sports-Finish-Flag-icon.png'
				});
		drawConstantPolyline();
		resetWalking();
		return;
	}
	var url = "REST/GetLocationWS/GetADirectionFromTo?departureId="
			+ $("#departureId").val() + "&destinationId="
			+ $("#destinationId").val() + "&from=" + $("#from").val() + "&to="
			+ $("#to").val() + "&pathType="
			+ $("[name='radio-choice-path-type']:checked").val();
	if ($("#to").val().length > 2) {
		var destPoint = getGoogleMapPosition($("#to").val());
		if (markerDest != null)
			markerDest.setMap(null);
		markerDest = new google.maps.Marker(
				{
					position : destPoint,
					map : map,
					icon : 'http://icons.iconarchive.com/icons/icons8/windows-8/48/Sports-Finish-Flag-icon.png'
				});
	}
	$.ajax({
		url : url,
		cache : true,
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
					pathLocations += l.departure.locationName + ","
							+ l.destination.locationName;
					$("#departureName").val(l.departure.locationName);
					$("#destinationName").val(l.destination.locationName);
					$("#departureId").val(l.departure.locationID);
				} else {
					pathIds += "," + l.destination.locationID;
					pathGPSs += "_" + l.destination.gps.replace(" ", "");
					pathLocations += "," + l.destination.locationName;
					$("#destinationDef").html(l.destination.locationName);
				}
			});
			$("#tripIds").val(pathIds);
			$("#tripGPSs").val(pathGPSs);
			$("#tripLocations").val(pathLocations);
			$("#departureId").val(pathIds.split(",")[0]);
			$("#destinationId").val(
					pathIds.split(",")[pathIds.split(",").length - 1]);
			setCookie('TripPathIdsCookie', $("#tripIds").val(), 1);
			setCookie('TripPathGPSCookie', $("#tripGPSs").val(), 1);
			setCookie('TripPathLocationsCookie', $("#tripLocations").val(), 1);
			drawConstantPolyline();
		}
	});
	var url = "REST/GetLocationWS/StartTrip?from=" + $("#departureId").val()
			+ "&to=" + $("#destinationId").val();
	$.ajax({
		url : url,
		cache : true,
		async : false,
		success : function(data) {
			$("#tripId").val(data[0].tripId);
			setCookie('TripIdCookie', data[0].tripId, 1);
			resetWalking();
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});
}

function removeTheNextDestination() {
	var tripIds = $("#tripIds").val().split(",");
	var tripGPSs = $("#tripGPSs").val().split("_");
	var tripLocations = $("#tripLocations").val().split(",");
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
				removeVarNames += "," + tripLocations[int];
			}

			if (int == closestId)
				break;
		}
	$("#tripIds").val($("#tripIds").val().replace(removeVarIDS + ",", ""));
	$("#tripGPSs").val($("#tripGPSs").val().replace(removeVarGPS + "_", ""));
	$("#tripLocations").val(
			$("#tripLocations").val().replace(removeVarNames + ",", ""));
	setCookie('TripPathIdsCookie', $("#tripIds").val(), 1);
	setCookie('TripPathGPSCookie', $("#tripGPSs").val(), 1);
	setCookie('TripPathLocationsCookie', $("#tripLocations").val(), 1);
	if (pathPolylineTrack != undefined)
		pathPolylineTrack.setMap(null);
	if (pathPolylineConstant != undefined)
		pathPolylineConstant.setMap(null);
	pathPolylineTrack = null;
	pathPolylineConstant = null;
	if ($("#tripGPSs").val().length > 1)
		drawConstantPolyline();
	resetWalking();
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
		strokeColor : 'yellow'
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
			strokeColor : 'green',
			strokeOpacity : 1.0,
			strokeWeight : 3
		});
	else
		pathPolylineConstant.setPath(tmpPathCoor);
	pathPolylineConstant.setMap(map);
	paths.push(pathPolylineConstant);
	animateCircle(pathPolylineConstant);
}

function updatePolyLine(currentPos, altitude) {
	var pointPath = new google.maps.LatLng(parseFloat(currentPos.lat),
			parseFloat(currentPos.lng));
	var tmpPathCoor = [];
	var nextDestGPS = getCookie("TripPathGPSCookie").split("_");
	var nextPosition = getGoogleMapPosition(nextDestGPS[0]);
	if (nextDestGPS.length > 1) {
		var secondNextPosition = getGoogleMapPosition(nextDestGPS[1]);
		var headingTo1st = google.maps.geometry.spherical.computeHeading(
				pointPath, nextPosition);
		var headingTo2st = google.maps.geometry.spherical.computeHeading(
				nextPosition, secondNextPosition);
		angleToNextDestination = headingTo2st - headingTo1st;
		heading = angleToNextDestination;
	}
	tmpPathCoor.push(pointPath);
	tmpPathCoor.push(nextPosition);
	distanceToNextPosition = google.maps.geometry.spherical
			.computeDistanceBetween(pointPath, nextPosition);
	if (distanceToNextPosition <= 5) {
		removeTheNextDestination();
	}
	distanceToDestination = polylineConstantLength + distanceToNextPosition;
	var nextDestName = getCookie("TripPathLocationsCookie").split(",")[0];
	$("#speedDef").html(
			speed + " Km/h. " + Math.round(altitude)
					+ " meters above sea. In about "
					+ Math.round(distanceToNextPosition) + " meter(s), at "
					+ nextDestName + ", " + getAngleDirection(heading));
	$("[name='radio-choice-path-type']:checked").val();
	var lineSymbol = {
		path : google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
		scale : 4,
		strokeColor : 'yellow'
	};
	if (pathPolylineTrack == null) {
		pathPolylineTrack = new google.maps.Polyline({
			path : tmpPathCoor,
			geodesic : true,
			icons : [ {
				icon : lineSymbol,
				offset : '100%'
			} ],
			strokeColor : 'green',
			strokeOpacity : 1.0,
			strokeWeight : 3,
			map : map
		});
		paths.push(pathPolylineTrack);
		animateCircle(pathPolylineTrack);
	} else
		pathPolylineTrack.setPath(tmpPathCoor);
	pathPolylineTrack.setMap(null);
	pathPolylineTrack.setMap(map);
	$("#distanceDef").html(getDistanceLeft(distanceToDestination) + " to ");
}

function resetWalking() {
	clearTimeout(walkingTimer);
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
					maximumAge : 500,
					accuracy : 122000
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
					enableHighAccuracy : true,
					maximumAge : 50
				});
	} else {
		handleLocationError(false, infoWindow, map.getCenter());
	}
	var timeout = 500;
	if (map.getZoom() <= 15)
		timeout = 5000;
	else if (map.getZoom() <= 16)
		timout = 4000;
	else if (map.getZoom() <= 17)
		timout = 2000;
	else if (map.getZoom() <= 18)
		timout = 1000;
	// walkingTimer = setTimeout(walkToDestination, timeout);
}

function removeTrip() {
	var url = "REST/GetLocationWS/RemoveTrip?tripId=" + $("#tripId").val();
	$.ajax({
		url : url,
		cache : false,
		success : function(data) {
			for ( var i = 0; i < paths.length; i++) {
				if (paths[i] != undefined)
					paths[i].setMap(null);
			}
		}
	});
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
	$("#departureId").val("");
	$("#to").val("");
	$("#destinationId").val("");
	$("#to").val("");
	$("#tripIds").val("");
	$("#tripGPSs").val("");
	$("#tripLocations").val("");
	$("#destinationName").val("");
	if (markerDest != null)
		markerDest.setMap(null);
	markerDest = null;
	$("#tripId").val("");
	$("#destinationPresentation").css("display", "none");
	findMyLocation();
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
		featureType : "water",
		elementType : "labels",
		stylers : [ {
			visibility : "off"
		} ]
	} ];

	map = new google.maps.Map(document.getElementById('map_canvas'), {
		center : {
			lat : -34.009211,
			lng : 25.669051
		},
		zoom : 14,
		zoomControl : true,
		zoomControlOptions : {
			position : google.maps.ControlPosition.RIGHT_BOTTOM
		},
		streetViewControl : false,
		fullscreenControl : false,
		fullscreenControlOptions : {
			position : google.maps.ControlPosition.TOP_RIGHT
		},
		mapTypeControlOptions : {
			mapTypeIds : [ 'mystyle', google.maps.MapTypeId.ROADMAP,
					google.maps.MapTypeId.TERRAIN ]
		},
		mapTypeId : 'mystyle'
	});
	map.mapTypes.set('mystyle', new google.maps.StyledMapType(myStyle, {
		name : 'My Style'
	}));
	findMyLocation();
	input = document.getElementById('to');
	map.controls[google.maps.ControlPosition.LEFT_BOTTOM].push(document
			.getElementById('searchFields'));
	map.controls[google.maps.ControlPosition.LEFT_TOP].push(document
			.getElementById('destinationPresentation'));
	map.controls[google.maps.ControlPosition.TOP_RIGHT].push(document
			.getElementById('viewModeMap'));
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

function getDestination() {
	$("#autocompleteDestination")
			.on(
					"filterablebeforefilter",
					function(e, data) {

						var $ul = $("#autocompleteDestination"), $input = $("#destinationName"), value = $input
								.val(), html = "";
						$("#autocompleteDestination").css("display", "block");
						$ul.html("");
						if (value && value.length >= 3) {
							$ul
									.html("<li><div class='ui-loader'><span class='ui-icon ui-icon-loading'></span></div></li>");
							$ul.listview("refresh");
							$
									.ajax(
											{
												url : "REST/GetLocationWS/SearchForALocation?userName=NMMU"
														+ "&locationName="
														+ value,
												dataType : "json",
												crossDomain : true,
												async : true,
												cache : true
											})
									.then(
											function(response) {
												$
														.each(
																response,
																function(i, val) {
																	html += "<li id='"
																			+ val.locationID
																			+ "_"
																			+ val.gps
																			+ "' onclick='selectDestination(this)'>"
																			+ val.locationType.locationType
																			+ " "
																			+ val.locationName
																			+ "</li>";
																	$ul
																			.html(html);
																	$ul
																			.listview("refresh");
																	$ul
																			.trigger("updatelayout");
																});

											});
						}

					});
	$("#autocompleteDestination").css("width",
			$("#destinationName").css("width")).trigger("create");
}

function selectDestination(destination) {
	$("#destinationId").val($(destination).attr("id").split("_")[0]);
	$("#destinationName").val($(destination).html());
	$("#to").val($(destination).attr("id").split("_")[1].replace(" ", ""));
	$("#autocompleteDestination").css("display", "none");
	var destPoint = getGoogleMapPosition($("#to").val());
	if (markerDest != null)
		markerDest.setMap(null);
	markerDest = new google.maps.Marker(
			{
				position : destPoint,
				map : map,
				icon : 'http://icons.iconarchive.com/icons/icons8/windows-8/48/Sports-Finish-Flag-icon.png'
			});
	var bounds = new google.maps.LatLngBounds();
	bounds.extend(markerDest.getPosition());
	bounds.extend(marker.getPosition());
	map.fitBounds(bounds);
}

function getTimeLeft(distance) {
	if (speed > 0) {
		var TotalTime = (distance / 1000) / speed;
		var Hours = Math.floor(TotalTime);
		var Minutes = Math.floor((TotalTime - Hours) * 60);
		var Seconds = Math.round((TotalTime - Hours - Minutes) * 60);
	}
	var Kilometres = Math.floor(distance / 1000);
	var Metres = Math.round(distance - (Kilometres * 1000));
	// var String = "You are " + Kilometres + " kilometer/s and " + Metres + "
	// meter/s away from the destination. You will be there in about "
	// + Hours + " hour/s " + Minutes + " minute/s and " + Seconds + "
	// second/s.";
	$("#destinationPresentation").css("display", "block");
	if (Kilometres != 0)
		$("#distanceDef").html(
				Kilometres + " kilometer(s) and " + Metres + " meter(s)");
	else
		$("#distanceDef").html(Metres + " meter(s)");
	return String;
}

function getDistanceLeft(distance) {
	var Kilometres = Math.floor(distance / 1000);
	var Metres = Math.round(distance - (Kilometres * 1000));
	$("#destinationPresentation").css("display", "block");
	var res = "";
	if (Kilometres != 0)
		res = Kilometres + " kilometer(s) and " + Metres + " meter(s)";
	else
		res = Metres + " meter(s)";
	return res;
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
	if (position.coords.heading != null)
		heading = position.coords.heading;
	if (position.coords.speed != null) {
		speed = position.coords.speed * 3.6;
		speed = Math.round(speed);
	}
	if (getCookie("TripPathGPSCookie").length > 5)
		updatePolyLine(currentPos, position.coords.altitude);
	if (marker == null) {
		marker = new google.maps.Marker({
			map : map,
			icon : 'images/icons/target.png',
		});
		marker.addListener('click', function() {
			map.setZoom(17);
			map.setCenter(this.getPosition());
			resetWalking();
		});
	}
	marker.setPosition(currentPos);
};

var successGetCurrentPosition = function(position) {
	var currentPos = {
		lat : position.coords.latitude,
		lng : position.coords.longitude
	};
	$("#from").val(position.coords.latitude + "," + position.coords.longitude);
	$("#departureName").val("Current Location");
	if (marker == null) {
		marker = new google.maps.Marker({
			map : map,
			icon : 'images/icons/target.png',
		});
		marker.addListener('click', function() {
			map.setZoom(17);
			map.setCenter(this.getPosition());
			resetWalking();
		});
	}
	marker.setPosition(currentPos);
	map.panTo(currentPos);
};

function handleOrientation(event) {
	alpha = event.alpha;
	beta = event.beta; // In degree in the range [-180,180]
	gamma = event.gamma;// In degree in the range [-90,90]

	var strings = "alpha : " + alpha + "\n";
	strings += "beta : " + beta + "\n";
	strings += "gamma: " + gamma + "\n >>>> X: "
			+ compassHeading(alpha, beta, gamma);// +
	// event.acceleration.x
	// console.log(strings);
}

window.addEventListener('deviceorientation', handleOrientation, true);

function compassHeading(alpha, beta, gamma) {

	// Convert degrees to radians
	var alphaRad = alpha * (Math.PI / 180);
	var betaRad = beta * (Math.PI / 180);
	var gammaRad = gamma * (Math.PI / 180);

	// Calculate equation components
	var cA = Math.cos(alphaRad);
	var sA = Math.sin(alphaRad);
	var cB = Math.cos(betaRad);
	var sB = Math.sin(betaRad);
	var cG = Math.cos(gammaRad);
	var sG = Math.sin(gammaRad);

	// Calculate A, B, C rotation components
	var rA = -cA * sG - sA * sB * cG;
	var rB = -sA * sG + cA * sB * cG;
	var rC = -cB * cG;

	// Calculate compass heading
	var compassHeading = Math.atan(rA / rB);

	// Convert from half unit circle to whole unit circle
	if (rB < 0) {
		compassHeading += Math.PI;
	} else if (rA < 0) {
		compassHeading += 2 * Math.PI;
	}

	// Convert radians to degrees
	compassHeading *= 180 / Math.PI;

	return compassHeading;

}

$(document).ready(
		function() {
			$("#map_canvas").css("min-width",
					parseInt($("#mainBodyContents").css("width")));
			$("#map_canvas").height(
					parseInt($(window).height()) - ($(".jqm-header").height())
							- 27 - $(".ui-navbar").height());

		});
