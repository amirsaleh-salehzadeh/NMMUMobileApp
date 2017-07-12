var map, marker, infoWindow;
var markers = [];
var paths = [];

function animateCircle(line) {
	var count = 0;
	window.setInterval(function() {
		count = (count + 1) % 200;
		var icons = line.get('icons');
		icons[0].offset = (count / 2) + '%';
		line.set('icons', icons);
	}, 20);
}

function openMarkerPopup(edit) {
	if (!edit
			&& ($("#locationTypeId").val() == "0" || $("#parentLocationId")
					.val() == "0")) {
		alert("Please select the marker type (at the top menu) and parent location (at the right side menu) first.");
		return;
	}
	$('#insertAMarker').popup().trigger('create');
	$('#insertAMarker').popup('open').trigger('create');
}

function openPathCreationPopup() {
	$('#insertAPath').popup().trigger('create');
	$('#insertAPath').popup('open').trigger('create');
}

var markerDest, pathPolyline;
function drawPath() {
	for ( var i = 0; i < paths.length; i++) {
		paths[i].setMap(null);
	}
	for ( var i = 0; i < markers.length; i++) {
		marker[i].setMap(null);
	}
	var url = "REST/GetLocationWS/GetADirectionFromTo?from=" + $("#from").val()
			+ "&to=" + $("#to").val() + "&pathType="
			+ $("[name='radio-choice-path-type']:checked").val();
	$.ajax({
		url : url,
		cache : true,
		async: false,
		success : function(data) {
			var pathIds = "";
			var pathGPSs = "";
			var pathLocations = "";
			var polylineLength = 0;
			markerDest = new google.maps.Marker();
			var pathCoor = [];
			$.each(data, function(k, l) {
				if (k == 0) {
					pathIds = l.departure.locationID + ","
							+ l.destination.locationID;
					pathGPSs += l.departure.gps + ";"
					+ l.destination.gps;
					pathLocations += l.departure.locationName + ","
					+ l.destination.locationName;
					$("#departureName").val(l.departure.locationName);
					$("#destinationName").val(l.destination.locationName);
				} else{
					pathIds += "," + l.destination.locationID;
					pathGPSs += ";" + l.destination.gps;
					pathLocations += "," + l.destination.locationName;
				}
				var pointPath1 = new google.maps.LatLng(parseFloat(l.departure.gps.split(',')[0]), parseFloat(l.departure.gps.split(',')[1]));
				var pointPath2 = new google.maps.LatLng(parseFloat(l.destination.gps.split(',')[0]), parseFloat(l.destination.gps.split(',')[1]));
				pathCoor.push(pointPath1);
				pathCoor.push(pointPath2);
				polylineLength += google.maps.geometry.spherical
				.computeDistanceBetween(pointPath1, pointPath2);
				if(markerDest != null)
					markerDest.setMap(null);
				markerDest = new google.maps.Marker({
					position : pointPath2,
					map : map,
					icon: 'http://icons.iconarchive.com/icons/icons8/windows-8/32/Sports-Finish-Flag-icon.png'
				});
			});
			var lineSymbol = {
					path : google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
					scale : 4,
					strokeColor : 'yellow'
				};
			pathPolyline = new google.maps.Polyline({
				path : pathCoor,
				geodesic : true,
				icons : [ {
					icon : lineSymbol,
					offset : '100%'
				} ],
				strokeColor : 'green',
				strokeOpacity : 1.0,
				strokeWeight : 3
			});
			pathPolyline.setMap(map);
			paths.push(pathPolyline);
			animateCircle(pathPolyline);
			$("#tripIds").val(pathIds);
			$("#tripGPSs").val(pathGPSs);
			$("#tripLocations").val(pathLocations);
			$("#distanceDef").html(getDistanceLeft(polylineLength));
			$("#departureId").val(pathIds.split(",")[0]);
			$("#destinationId").val(
					pathIds.split(",")[pathIds.split(",").length - 1]);
		}
	});
}

function getTimeLeft(distance, speed) {
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
	$("#navigationDashboard").css("display", "block");
	if(Kilometres != 0)
	$("#distanceDef").html(
			Kilometres + " kilometer(s) and " + Metres + " meter(s)");
	else
		$("#distanceDef").html(Metres + " meter(s)");
	return String;
}

function getDistanceLeft(distance) {
	var Kilometres = Math.floor(distance / 1000);
	var Metres = Math.round(distance - (Kilometres * 1000));
	$("#navigationDashboard").css("display", "block");
	var res = "";
	if(Kilometres != 0)
		res = Kilometres + " kilometer(s) and " + Metres + " meter(s)";
	else
		res = Metres + " meter(s)";
	return res;
	
}

function myLocation() {
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(successHandler, errorHandler,
				{
					enableHighAccuracy : true,
					maximumAge : 0
				});
	} else {
		handleLocationError(false, infoWindow, map.getCenter());
	}
}

function drawPolyline(currentPos){
	var pointPath = new google.maps.LatLng(parseFloat(currentPos.lat), parseFloat(currentPos.lng));
	var tmpPathCoor = [];
	var nextDestGPS = getCookie("TripPathGPSCookie").split(";");
	var nextPosition = new google.maps.LatLng(parseFloat(nextDestGPS[0].split(',')[0]), parseFloat(nextDestGPS[0].split(',')[1]));
	tmpPathCoor.push(pointPath);
	tmpPathCoor.push(nextPosition);
	for(var i = 0 ; i < getCookie("TripPathGPSCookie").split(";").length; i){
		tmpPathCoor.push(new google.maps.LatLng(parseFloat(nextDestGPS[i].split(',')[0]), parseFloat(nextDestGPS[i].split(',')[1])));
	}
	var nextDestName = getCookie("TripPathLocationsCookie").split(",")[0];
	var distanceToNextPosition = google.maps.geometry.spherical
	.computeDistanceBetween(pointPath, nextPosition);
	$("#distanceToDef").html(nextDestName + " " + getDistanceLeft(distanceToNextPosition));
	var lineSymbol = {
			path : google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
			scale : 4,
			strokeColor : 'yellow'
		};
	for ( var i = 0; i < paths.length; i++) {
		paths[i].setMap(null);
	}
	pathPolyline = new google.maps.Polyline({
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
	pathPolyline.setMap(map);
	paths.push(pathPolyline);
	animateCircle(pathPolyline);
}

var polyTracking = [];
var successTrackingHandler = function(position) {
	var currentPos = {
		lat : position.coords.latitude,
		lng : position.coords.longitude
	};
	if ($("#from").val() == "") {
		$("#from").val(
				position.coords.latitude + "," + position.coords.longitude);
	}
	drawPolyline(currentPos); 
	var heading = position.coords.heading;
	var speed = position.coords.speed;
	$("#speedDef").html("speed>> " + speed + " heading>> " + heading);
	marker.setPosition( currentPos );
	map.panTo( currentPos );
};

var walkingTimer;
function walkToDestination() {
	google.maps.event.addListener(map, 'bounds_changed', function () {
	window.clearTimeout(walkingTimer);
	walkingTimer = window.setTimeout(function () {
		if (navigator.geolocation) {
			navigator.geolocation.watchPosition(successTrackingHandler, errorHandler,
					{
						enableHighAccuracy : true,
						maximumAge : 0
					});
		} else {
			handleLocationError(false, infoWindow, map.getCenter());
		}
	    }, 500);
	}); 
}

function startTrip() {
	var url = "REST/GetLocationWS/StartTrip?from=" + $("#departureId").val()
			+ "&to=" + $("#destinationId").val();
	$.ajax({
		url : url,
		cache : true,
		async: true,
		success : function(data) {
			$("#tripId").val(data[0].tripId);
			setCookie('TripIdCookie', data[0].tripId, 1);
			setCookie('TripPathIdsCookie', $("#tripIds").val(), 1);
			setCookie('TripPathGPSCookie', $("#tripGPSs").val(), 1);
			setCookie('TripPathLocationsCookie', $("#tripLocations").val(), 1);
			walkToDestination();
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});

}

function setCookie(cname, cvalue, exdays) {
	var d = new Date();
	d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
	var expires = "expires=" + d.toUTCString();
	document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
	var name = cname + "=";
	var decodedCookie = decodeURIComponent(document.cookie);
	var ca = decodedCookie.split(';');
	for ( var i = 0; i < ca.length; i++) {
		var c = ca[i];
		while (c.charAt(0) == ' ') {
			c = c.substring(1);
		}
		if (c.indexOf(name) == 0) {
			return c.substring(name.length, c.length);
		}
	}
	return "";
}

function removeTrip() {
	var url = "REST/GetLocationWS/RemoveTrip?tripId=" + $("#tripId").val();
	$.ajax({
		url : url,
		cache : false,
		success : function(data) {
			for ( var i = 0; i < paths.length; i++) {
				paths[i].setMap(null);
			}
		}
	});
	clearInterval(walkingTimer);
	$("#from").val("");
	$("#departureId").val("");
	$("#to").val("");
	$("#destinationId").val("");
	$("#to").val("");
	$("#tripIds").val("");
	$("#tripGPSs").val("");
	$("#tripLocations").val("");
	if(markerDest != null)
		markerDest.setMap(null);
	$("#tripId").val("");
	$("#navigationDashboard").css("display", "none");
}

function openAR() {
	var tmp = $('#destinationId').val();
	if (tmp == null || tmp == "null" || tmp == "")
		tmp = 0;
	window.open("insta/docs/index.jsp?destinationId=" + tmp + "&pathType="
			+ $("[name='radio-choice-path-type']:checked").val());
}

var myLatLng = {
	lat : -34.009211,
	lng : 25.669051
};

var infoWindow;
var successHandler = function(position) {
	var pos = {
		lat : position.coords.latitude,
		lng : position.coords.longitude
	};
	if ($("#from").val() == "") {
		$("#from").val(
				position.coords.latitude + ", " + position.coords.longitude);
	}
	var heading = position.coords.heading;
	var speed = position.coords.speed;
	$("#speedDef").html(speed);
	map.setCenter(pos);
	marker = new google.maps.Marker({
		position : pos,
		map : map,
		icon: 'images/icons/target.png',
	});
};


var errorHandler = function(errorObj) {
	alert(errorObj.code + ": " + errorObj.message);

};

function initiMap() {
	map = new google.maps.Map(document.getElementById('map_canvas'), {
		center : {
			lat : -34.009211,
			lng : 25.669051
		},
		zoom : 17,
		fullscreenControl : true,
		streetViewControl: false
	});
	infoWindow = new google.maps.InfoWindow;
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(successHandler, errorHandler,
				{
					enableHighAccuracy : true,
					maximumAge : 0
				});
	} else {
		handleLocationError(false, infoWindow, map.getCenter());
	}
	input = document.getElementById('to');
	map.controls[google.maps.ControlPosition.BOTTOM_LEFT].push(document
			.getElementById('searchFields'));
	map.controls[google.maps.ControlPosition.LEFT_TOP].push(document
			.getElementById('navigationDashboard'));
//	google.maps.event.addListener(map, 'bounds_changed', (function () {
//	    return function() {
//	        clearTimeout(walkingTimer);
//	        walkingTimer = setTimeout(walkToDestination, 500);
//	    }
//	}()));
	google.maps.event.addListener(map, "click", function(event) {
		var lat = event.latLng.lat();
		var lng = event.latLng.lng();
		if ($("#to").val() == "") {
			$("#to").val(lat + ", " + lng);
			return;
		} else {
			drawPath();
		}
	});
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
	infoWindow.setPosition(pos);
	infoWindow
			.setContent(browserHasGeolocation ? 'Error: The Geolocation service failed.'
					: 'Error: Your browser doesn\'t support geolocation.');
	infoWindow.open(map);
}

function isFullScreen()
{
    return (document.fullScreenElement && document.fullScreenElement !== null)
         || document.mozFullScreen
         || document.webkitIsFullScreen;
}


function requestFullScreen(element)
{
    if (element.requestFullscreen)
        element.requestFullscreen();
    else if (element.msRequestFullscreen)
        element.msRequestFullscreen();
    else if (element.mozRequestFullScreen)
        element.mozRequestFullScreen();
    else if (element.webkitRequestFullscreen)
        element.webkitRequestFullscreen();
}

function exitFullScreen()
{
    if (document.exitFullscreen)
        document.exitFullscreen();
    else if (document.msExitFullscreen)
        document.msExitFullscreen();
    else if (document.mozCancelFullScreen)
        document.mozCancelFullScreen();
    else if (document.webkitExitFullscreen)
        document.webkitExitFullscreen();
}

function toggleFullScreen(element)
{
    if (isFullScreen())
        exitFullScreen();
    else
        requestFullScreen(element || document.documentElement);
}

$(document)
		.ready(
				function() {
					$("#map_canvas").css("min-width",
							parseInt($("#mainBodyContents").css("width")));
					$("#map_canvas")
							.height(parseInt($(window).height())
											- ($(".jqm-header").height()) - 27 - $(
													".ui-navbar").height());	
				});