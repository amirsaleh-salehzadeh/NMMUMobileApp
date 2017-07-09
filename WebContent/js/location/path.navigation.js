var map, marker, infoWindow, markerDest;
var pathPolylineConstant, pathPolylineTrack, polylineConstantLength;
var walkingTimer, speed, speedTimer, heading, walkingWatchID, speedWatchID;
var distanceToNextPosition, distanceToDestination;
var paths = [];

function getThePath() {
	if(pathPolylineConstant != null)
		return;
	startSpeedoMeter();
	var url = "REST/GetLocationWS/GetADirectionFromTo?departureId="+$("#departureId").val()+"&destinationId="
	+$("#destinationId").val()+"&from=" + $("#from").val()
			+ "&to=" + $("#to").val() + "&pathType="
			+ $("[name='radio-choice-path-type']:checked").val();
	if ($("#to").val().length > 2) {
		var destPoint = new google.maps.LatLng(parseFloat($("#to").val().split(
				',')[0]), parseFloat($("#to").val().split(',')[1]));
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
			$.each(data,function(k, l) {
				if (k == 0) {
					pathIds = l.departure.locationID
							+ ","
							+ l.destination.locationID;
					pathGPSs += l.departure.gps + "_"
							+ l.destination.gps.replace(" ","");
					pathLocations += l.departure.locationName
							+ ","
							+ l.destination.locationName;
					$("#departureName").val(l.departure.locationName);
					$("#destinationName").val(
							l.destination.locationName);
					$("#departureId").val(l.departure.locationID);
				} else {
					pathIds += ","
							+ l.destination.locationID;
					pathGPSs += "_" + l.destination.gps;
					pathLocations += ","
							+ l.destination.locationName;
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
			drawPolylines();
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
					myLocation();
				},
				error : function(xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
					alert(thrownError);
				}
			});
		}

function removeTheNextDestination(){
	var tripIds = $("#tripIds").val().split(",");
	var tripGPSs = $("#tripGPSs").val().split("_");
	var tripLocations = $("#tripLocations").val().split(",");
	$("#tripIds").val($("#tripIds").val().replace(tripIds[0]+",",""));
	$("#tripGPSs").val($("#tripGPSs").val().replace(tripGPSs[0]+"_",""));
	$("#tripLocations").val($("#tripLocations").val().replace(tripLocations[0]+",",""));
	setCookie('TripPathIdsCookie', $("#tripIds").val(), 1);
	setCookie('TripPathGPSCookie', $("#tripGPSs").val(), 1);
	setCookie('TripPathLocationsCookie', $("#tripLocations").val(), 1);
}

function drawPolylines() {
	var tmpPathCoor = [];
	var nextDestGPS = getCookie("TripPathGPSCookie").split("_");
	polylineConstantLength = 0;
	for ( var i = 0; i < nextDestGPS.length; i++) {
		if (i < nextDestGPS.length - 1)
			polylineConstantLength += google.maps.geometry.spherical
				.computeDistanceBetween(new google.maps.LatLng(
						parseFloat(nextDestGPS[i].split(',')[0]),
						parseFloat(nextDestGPS[i].split(',')[1])),
						new google.maps.LatLng(parseFloat(nextDestGPS[i + 1]
								.split(',')[0]), parseFloat(nextDestGPS[i + 1]
								.split(',')[1])));
		tmpPathCoor.push(new google.maps.LatLng(parseFloat(nextDestGPS[i]
				.split(',')[0]), parseFloat(nextDestGPS[i].split(',')[1])));
	}
	var lineSymbol = {
			path : google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
			scale : 4,
			strokeColor : 'yellow'
		};
	if(pathPolylineConstant == null)
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

function updatePolyLine(currentPos) {
	var pointPath = new google.maps.LatLng(parseFloat(currentPos.lat),
			parseFloat(currentPos.lng));
	var tmpPathCoor = [];
	var nextDestGPS = getCookie("TripPathGPSCookie").split("_");
	var nextPosition = new google.maps.LatLng(parseFloat(nextDestGPS[0]
			.split(',')[0]), parseFloat(nextDestGPS[0].split(',')[1]));
	var nextDestName = getCookie("TripPathLocationsCookie").split(",")[0];
	tmpPathCoor.push(pointPath);
	tmpPathCoor.push(nextPosition);
	distanceToNextPosition = google.maps.geometry.spherical
			.computeDistanceBetween(pointPath, nextPosition);
	if(distanceToNextPosition <= 5){
		removeTheNextDestination();
	}
	distanceToDestination = polylineConstantLength + distanceToNextPosition;
//	$("#distanceToDef").html(
//			nextDestName + " " + getDistanceLeft(distanceToNextPosition));
	var lineSymbol = {
		path : google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
		scale : 4,
		strokeColor : 'yellow'
	};
	if (pathPolylineTrack == null){
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
			map: map
		});
//		pathPolylineTrack.setMap(map);
		paths.push(pathPolylineTrack);
		animateCircle(pathPolylineTrack);
	} else
		pathPolylineTrack.setPath(tmpPathCoor);
	$("#distanceDef").html(getDistanceLeft(distanceToDestination) + " to ");
}

var successTrackingHandler = function(position) {
//	for ( var i = 0; i < paths.length; i++) {
//		paths[i].setMap(null);
//	}
	var currentPos = {
		lat : position.coords.latitude,
		lng : position.coords.longitude
	};
	$("#from").val(position.coords.latitude + "," + position.coords.longitude);
	$("#departureName").val("Current Location");
	if (getCookie("TripPathGPSCookie").length > 5)
		updatePolyLine(currentPos);
	if (marker == null) {
		marker = new google.maps.Marker({
			map : map,
			icon : 'images/icons/target.png',
		});
		marker.addListener('click', function() {
			map.setZoom(17);
			map.setCenter(this.getPosition());
			myLocation();
		});
	}
	marker.setPosition(currentPos);
	map.panTo(currentPos);
//	map.setCenter(currentPos);
};

function myLocation() {
	clearTimeout(walkingTimer);
	walkToDestination();
//	map.setZoom(17);
}

function walkToDestination() {
	if(walkingWatchID!= null)
		navigator.geolocation.clearWatch(walkingWatchID);
	if (navigator.geolocation) {
		walkingWatchID = navigator.geolocation.watchPosition(successTrackingHandler, errorHandler, {
					enableHighAccuracy : true,
					maximumAge : 0
				});
	} else {
		handleLocationError(false, infoWindow, map.getCenter());
	}
	walkingTimer = setTimeout(walkToDestination, 500);
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
	pathPolylineTrack = null;
	pathPolylineConstant = null;
	clearTimeout(walkingTimer);
	clearTimeout(speedTimer);
	if(walkingWatchID!= null)
		navigator.geolocation.clearWatch(walkingWatchID);
	if (speedWatchID != null)
		navigator.geolocation.clearWatch(speedWatchID);
	setCookie('TripIdCookie', "", 1);
	setCookie('TripPathIdsCookie', "", 1);
	setCookie('TripPathGPSCookie', "", 1);
	setCookie('TripPathLocationsCookie', "", 1);
	$("#from").val("");
	$("#departureId").val("");
	$("#to").val("");
	$("#destinationId").val("");
	$("#to").val("");
	$("#tripIds").val("");
	$("#tripGPSs").val("");
	$("#tripLocations").val("");
	if (markerDest != null)
		markerDest.setMap(null);
	$("#tripId").val("");
	$("#destinationPresentation").css("display", "none");
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

var errorHandler = function(errorObj) {
	alert(errorObj.code + ": " + errorObj.message);

};

function initiMap() {
	map = new google.maps.Map(document.getElementById('map_canvas'), {
		center : {
			lat : -34.009211,
			lng : 25.669051
		},
		zoom : 14,
		fullscreenControl : true,
		streetViewControl : false
	});
	infoWindow = new google.maps.InfoWindow;
	myLocation();
	input = document.getElementById('to');
	map.controls[google.maps.ControlPosition.BOTTOM_LEFT].push(document
			.getElementById('searchFields'));
	map.controls[google.maps.ControlPosition.LEFT_TOP].push(document
			.getElementById('destinationPresentation'));
	map.controls[google.maps.ControlPosition.TOP_CENTER].push(document
					.getElementById('navigationInfo'));
			
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
	infoWindow.setPosition(pos);
	infoWindow
			.setContent(browserHasGeolocation ? 'Error: The Geolocation service failed.'
					: 'Error: Your browser doesn\'t support geolocation.');
	infoWindow.open(map);
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
						if (value && value.length >= 1) {
							$ul
									.html("<li><div class='ui-loader'><span class='ui-icon ui-icon-loading'></span></div></li>");
							$ul.listview("refresh");
							$
									.ajax(
											{
												url : "REST/GetLocationWS/SearchForALocation?userName=NMMU" +
																"&locationName="
														+ value,
												dataType : "json",
												crossDomain : true,
												async: true,
												cache: true
											})
									.then(function(response) {
										$.each(response,
														function(i, val) {
															html += "<li id='"
																	+ val.locationID + "_" + val.gps 
																	+ "' onclick='selectDestination(this)'>"
																	+ val.locationType.locationType + " " + val.locationName
																	+ "</li>";
															$ul.html(html);
															$ul.listview("refresh");
															$ul.trigger("updatelayout");															
															}
														);

											});
						}
						
					});
 $("#autocompleteDestination").css("width",
 $("#destinationName").css("width")).trigger("create");
}

function selectDestination(destination){
	 $("#destinationId").val($(destination).attr("id").split("_")[0]);
	 $("#destinationName").val($(destination).html());
	 $("#to").val($(destination).attr("id").split("_")[1].replace(" ",""));
	 $("#autocompleteDestination").css("display", "none");
	 var destPoint = new google.maps.LatLng(parseFloat($("#to").val()
		.split(',')[0]), parseFloat($("#to").val().split(',')[1]));
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

$(document).ready(
		function() {
			$("#map_canvas").css("min-width",
					parseInt($("#mainBodyContents").css("width")));
			$("#map_canvas").height(
					parseInt($(window).height()) - ($(".jqm-header").height())
							- 27 - $(".ui-navbar").height());
		});

function animateCircle(line) {
	var count = 0;
	window.setInterval(function() {
		count = (count + 1) % 200;
		var icons = line.get('icons');
		icons[0].offset = (count / 2) + '%';
		line.set('icons', icons);
	}, 50);
}

function startSpeedoMeter(){
	 if (speedWatchID != null)
		navigator.geolocation.clearWatch(speedWatchID);
	if (navigator.geolocation) {
		speedWatchID = navigator.geolocation.watchPosition(successSpeedHandler,
				errorHandler, {
					enableHighAccuracy : true,
					maximumAge : 0
				});
	} else {
		handleLocationError(false, infoWindow, map.getCenter());
	}
	speedTimer = setTimeout(startSpeedoMeter, 50);
}

var successSpeedHandler = function(position) {
	heading = position.coords.heading;
	speed = position.coords.speed * 3.6;
	speed = Math.round(speed);
	if (speed != null && speed >= 0)
		$("#speedDef").html(speed + " Km/h");
//	else
//		$("#speedDef").html("");
};