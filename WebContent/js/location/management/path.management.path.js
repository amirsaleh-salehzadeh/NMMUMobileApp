var movingLine, pathPolylineConstant, lastOne, overlay, pathDrawingCircle;
var pathWidthScale = 0;

function getAllPaths() {
	google.maps.event.addListener(map, 'zoom_changed', function(event) {
		google.maps.event.addListenerOnce(map, 'bounds_changed', function(e) {
			updatePathWeight();
		});
	});
	overlay = new google.maps.OverlayView();
	overlay.draw = function() {
	};
	overlay.setMap(map);
	if (paths != null)
		for ( var i = 0; i < paths.length; i++) {
			paths[i].setMap(null);
		}
	var url = "REST/GetPathWS/GetPathsForUserAndParent?userName=NMMU&parentId="
			+ $("#parentLocationId").val();
	$.ajax({
		url : url,
		cache : false,
		async : true,
		beforeSend : function() {
			ShowLoadingScreen("Fetching paths");
		},
		success : function(data) {
			$.each(data, function(k, l) {
				drawApath(l);
			});
		},
		complete : function() {
			HideLoadingScreen();
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
			alert("getAllPaths");
		}
	});
}

function updatePathWeight() {
	if (paths != null)
		for ( var i = 0; i < paths.length; i++) {
			var tmpCircle = new google.maps.Circle({
				strokeColor : '#00FF00',
				strokeOpacity : 0.3,
				strokeWeight : 1,
				fillOpacity : 0,
				center : map.getCenter(),
				map : map,
				radius : parseFloat(paths[i].customInfo.split(";")[0]) / 2
			});
			var pathWidthScale = 1;
			if (overlay.getProjection() != undefined) {
				var point1 = overlay.getProjection().fromLatLngToDivPixel(
						tmpCircle.getBounds().getNorthEast());
				var point2 = overlay.getProjection().fromLatLngToDivPixel(
						tmpCircle.getBounds().getCenter());
				pathWidthScale = Math.round(Math.sqrt(Math.pow(point1.x
						- point2.x, 2)
						+ Math.pow(point1.y - point2.y, 2))) * 2;
			}
			tmpCircle.setMap(null);
			if (pathWidthScale <= 0)
				pathWidthScale = 1;
			paths[i].setOptions({
				strokeWeight : pathWidthScale
			});
			paths[i].setMap(null);
			paths[i].setMap(map);
		}
}

function setPathTypeButtonIcon() {

	$(".pathTypeIcon").each(function() {
		var pathTypeId = $(this).attr("alt");
		if (pathTypeId == "1")
			$(this).attr("src", "images/icons/pathType/grass.png");
		else if (pathTypeId == "2") {
			$(this).attr("src", "images/icons/pathType/normalSpeed.png");
		} else if (pathTypeId == "3") {
			$(this).attr("src", "images/icons/pathType/stairs.png");
		} else if (pathTypeId == "4")
			$(this).attr("src", "images/icons/pathType/elevator.png");
		else if (pathTypeId == "5")
			$(this).attr("src", "images/icons/pathType/car.png");
		else if (pathTypeId == "6")
			$(this).attr("src", "images/icons/pathType/wheelchair.png");
		else if (pathTypeId == "7")
			$(this).attr("src", "images/icons/pathType/escalator.png");
		else if (pathTypeId == "8")
			$(this).attr("src", "images/icons/pathType/bicycle.png");
		else
			$(this).attr("src", "images/icons/pathType/cursor-pointer.png");
	});
}

function getPathPolyColor(typeId) {
	var color = '#FF0000';
	if (typeId == "1") {
		color = '#ffb400';
	} else if (typeId == "2") {
		color = '#0ec605';
	} else if (typeId == "3")
		color = '#3359fc';
	else if (typeId == "4")
		color = '#000000';
	else if (typeId == "5")
		color = '#ffffff';
	else if (typeId == "6") {
		color = '#fc33f0';
	}
	return color;
}
function drawApath(l) {
	var pathCoor = [];
	pathCoor.push(new google.maps.LatLng(
			parseFloat(l.departure.gps.split(',')[0]),
			parseFloat(l.departure.gps.split(',')[1])));
	if (l.pathRoute != null && l.pathRoute.length > 0) {
		var tm = l.pathRoute.split("_");
		if (tm.length == 1)
			pathCoor.push(new google.maps.LatLng(
					parseFloat(tm[0].split(',')[0]), parseFloat(tm[0]
							.split(',')[1])));
		for ( var i = 0; i < tm.length; i++) {
			pathCoor.push(new google.maps.LatLng(
					parseFloat(tm[i].split(',')[0]), parseFloat(tm[i]
							.split(',')[1])));
		}
	}
	pathCoor.push(new google.maps.LatLng(parseFloat(l.destination.gps
			.split(',')[0]), parseFloat(l.destination.gps.split(',')[1])));
	// var color = getPathPolyColor(l.pathType);
	var tmpCircle = new google.maps.Circle({
		strokeColor : '#00FF00',
		strokeOpacity : 0.3,
		strokeWeight : 2,
		fillColor : '#00FF00',
		fillOpacity : 0,
		center : map.getCenter(),
		map : map,
		radius : parseFloat(l.width) / 2
	});
	if (overlay.getProjection() != undefined) {
		var point1 = overlay.getProjection().fromLatLngToDivPixel(
				tmpCircle.getBounds().getNorthEast());
		var point2 = overlay.getProjection().fromLatLngToDivPixel(
				tmpCircle.getBounds().getCenter());
		pathWidthScale = Math.round(Math.sqrt(Math.pow(point1.x - point2.x, 2)
				+ Math.pow(point1.y - point2.y, 2))) * 2;
	}
	tmpCircle.setMap(null);
	if (pathWidthScale <= 0)
		pathWidthScale = 1;
	// if(pathWidthScale > 33)
	// pathWidthScale = 33;
	var pathPolyline = new google.maps.Polyline({
		path : pathCoor,
		geodesic : true,
		strokeColor : '#081B2C',
		strokeOpacity : 0.6,
		strokeWeight : pathWidthScale,
		customInfo : l.width + ";" + l.pathType
	});
	pathPolyline.id = l.pathId;
	pathPolyline.addListener('click', function() {
		selectAPath(l);
	});
	pathPolyline.setMap(map);
	paths.push(pathPolyline);
}

// SAVE THE PATH BETWEEN A DESTINATION AND DEPARTURE WHICH INCLUDES MANY POINTS
function saveThePath() {
	if ($("#pathTypeIds").val().length <= 0) {
		alert("Select Path Type");
	}
	$('#insertAPath').popup('close');
	saveAPath();
	cancelADrawnPath();
}

// SAVE A PATH BETWEEN TWO POINTS
function saveAPath() {
	var url = "REST/GetPathWS/SavePath?fLocationId=" + $("#departureId").val()
			+ "&tLocationId=" + $("#destinationId").val() + "&pathType="
			+ $("#pathTypeIds").val() + "&pathRoute=" + $("#pathLatLng").val()
			+ "&width=" + $("#pathWidth").val() + "&pathName="
			+ $("#pathName").val() + "&description="
			+ $("#pathDescription").val() + "&pathId=" + $("#pathId").val();

	$.ajax({
		url : url,
		cache : false,
		async : true,
		beforeSend : function() {
			ShowLoadingScreen("Saving the path");
		},
		success : function(data) {
			drawApath(data);
			$("#departureId").val($("#destinationId").val());
		},
		complete : function() {
			HideLoadingScreen();
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
			alert("savePath");
		}
	});
}

// REMOVE A PATH
function removePath() {
	if (confirm('Are you sure you want to remove this path?')) {
		var url = "REST/GetLocationWS/RemoveAPath?pathId=" + $("#pathId").val();
		$.ajax({
			url : url,
			cache : false,
			async : true,
			beforeSend : function() {
				ShowLoadingScreen("Removing the path");
			},
			success : function(data) {
				if (data.errorMSG != null) {
					alert(data.errorMSG);
					return;
				}
				for ( var i = 0; i < paths.length; i++) {
					if (paths[i].id == $("#pathId").val()) {
						paths[i].setMap(null);
						var i = pathTypeIds.indexOf($("#pathId").val());
						if (i != -1) {
							pathTypeIds.splice(i, 1);
						}
					}

				}
			},
			complete : function() {
				HideLoadingScreen();
			},
			error : function(xhr, ajaxOptions, thrownError) {
				alert(xhr.status);
				alert(thrownError);
				alert("removePath");
			}
		});
	} else {
		return;
	}
}

var pathMarkers = [];
function addAPathInnerConnection(event) {
	var lat = event.latLng.lat();
	var lng = event.latLng.lng();
	if ($("#pathLatLng").val().length > 1)
		$("#pathLatLng").val($("#pathLatLng").val() + "_" + lat + "," + lng);
	else
		$("#pathLatLng").val(lat + "," + lng);
	updateConstantLine();

	// var pathMarker = new google.maps.Marker({
	// position : {
	// lat : lat,
	// lng : lng
	// },
	// map : map
	// });
	var bounds = new google.maps.LatLngBounds();
	bounds.extend(marker.getPosition());
	// pathMarkers.push(pathMarker);
	mapDrawingClickCounter++;
}

$(document).keyup(function(e) {
	if (e.keyCode == 27) {
		cancelADrawnPath();
	}
});

function updateMovingLine(event) {
	var pointPath = event.latLng;
	pathDrawingCircle.setCenter(pointPath);
	var tmpPathCoor = [];
	tmpPathCoor.push(pointPath);
	tmpPathCoor.push(lastOne);
	if (overlay.getProjection() != undefined) {
		var point1 = overlay.getProjection().fromLatLngToDivPixel(
				pathDrawingCircle.getBounds().getNorthEast());
		var point2 = overlay.getProjection().fromLatLngToDivPixel(
				pathDrawingCircle.getBounds().getCenter());
		pathWidthScale = Math.round(Math.sqrt(Math.pow(point1.x - point2.x, 2)
				+ Math.pow(point1.y - point2.y, 2))) * 2;
	}
	if (pathWidthScale <= 0)
		pathWidthScale = 1;
	if (pathWidthScale > 33)
		pathWidthScale = 33;
	if (movingLine == null) {
		movingLine = new google.maps.Polyline({
			path : tmpPathCoor,
			strokeColor : '#081B2C',
			strokeOpacity : .66,
			map : map
		});
		google.maps.event.addListener(movingLine, "click", function(event) {
			addAPathInnerConnection(event);
		});
		google.maps.event.addListener(movingLine, "mousemove", function(event) {
			updateMovingLine(event);
		});
		paths.push(movingLine);
	} else
		movingLine.setPath(tmpPathCoor);
	movingLine.setOptions({
		strokeWeight : pathWidthScale
	});
	movingLine.setMap(null);
	movingLine.setMap(map);
	pathDrawingCircle.setMap(null);
	pathDrawingCircle.setMap(map);
	$("#pathLength").html(getTheLength(movingLine.inKm()));
}

var tmpPathCoor = [];
function updateConstantLine() {
	tmpPathCoor = [];
	var nextDestGPS = $("#pathLatLng").val().split("_");
	polylineConstantLength = 0;
	for ( var i = 0; i < nextDestGPS.length; i++) {
		tmpPathCoor.push(getGoogleMapPosition(nextDestGPS[i]));
		lastOne = getGoogleMapPosition(nextDestGPS[i]);
	}
	if ($("#destinationGPS").val().length > 0)
		tmpPathCoor.push(getGoogleMapPosition($("#destinationGPS").val()));
	if (nextDestGPS.length <= 1)
		return;
	if (pathPolylineConstant != undefined)
		pathPolylineConstant.setMap(null);
	if (pathPolylineConstant == null)
		pathPolylineConstant = new google.maps.Polyline({
			path : tmpPathCoor,
			strokeColor : 'grey',
			strokeOpacity : .5,
			strokeWeight : pathWidthScale
		});
	else
		pathPolylineConstant.setPath(tmpPathCoor);
	pathPolylineConstant.setMap(map);
	paths.push(pathPolylineConstant);
}

function cancelADrawnPath() {
	if (pathMarkers != null)
		for ( var int = 0; int < pathMarkers.length; int++) {
			pathMarkers[int].setMap(null);
		}
	google.maps.event.clearInstanceListeners(map);
	if (movingLine != undefined) {
		movingLine.setMap(null);
		movingLine = undefined;
	}
	if (pathPolylineConstant != undefined) {
		pathPolylineConstant.setMap(null);
		pathPolylineConstant = undefined;
	}
	$("#departure").val("");
	$("#departureId").val("");
	$("#destination").val("");
	$("#destinationId").val("");
	$("#destinationGPS").val("");
	$("#markerId").val("");
	$("#pathLatLng").val("");
	if (pathDrawingCircle != null)
		pathDrawingCircle.setMap(null);
}

var mapDrawingClickCounter;
function addAPath(location, gps) {
	gps = gps.replace(" ", "");
	if (location == null) {
		alert("A path can only be drawn between two locations");
		return;
	}
	if ($("#departure").val() == "") {
		mapDrawingClickCounter = 1;
		$("#departure").val(location.locationName);
		$("#departureId").val(location.locationID);
		$("#markerCoordinate").val(location.gps);
		$("#pathLatLng").val($("#markerCoordinate").val());
		lastOne = getGoogleMapPosition(location.gps);
		google.maps.event.clearInstanceListeners(map);
		pathDrawingCircle = new google.maps.Circle({
			strokeColor : '#00FF00',
			strokeOpacity : 0.3,
			strokeWeight : 2,
			fillColor : '#00FF00',
			fillOpacity : 0.35,
			map : map,
			radius : parseFloat($("#pathWidth").val()) / 2
		});
		overlay = new google.maps.OverlayView();
		overlay.draw = function() {
		};
		overlay.setMap(map);
		google.maps.event.addListener(map, "mousemove", function(event) {
			updateMovingLine(event);
		});
		google.maps.event.addListener(pathDrawingCircle, "mousemove", function(
				event) {
			updateMovingLine(event);
		});
		google.maps.event.addListener(map, "click", function(event) {
			addAPathInnerConnection(event);
		});
		google.maps.event.addListener(pathDrawingCircle, "click", function(
				event) {
			addAPathInnerConnection(event);
		});
		$("#pathLatLng").val(location.gps);
		return;
	} else if ($("#destinationId").val() == "") {
		var oldPathLatLng = $("#pathLatLng").val();
		$("#destination").val(location.locationName);
		$("#destinationId").val(location.locationID);
		google.maps.event.clearInstanceListeners(map);
		// var pltlng = oldPathLatLng.split("_");
		// var lastUnnecessaryMarkerGPS = pltlng[pltlng.length];
		// if (pltlng.length > mapDrawingClickCounter)
		// $("#pathLatLng").val(
		// oldPathLatLng.replace(
		// "_" + lastUnnecessaryMarkerGPS, ""));
		$("#destinationGPS").val(location.gps);
		pathDrawingCircle.setMap(null);
		google.maps.event.clearInstanceListeners(map);
		if (movingLine != undefined) {
			movingLine.setMap(null);
			movingLine = undefined;
		}
		updateConstantLine();
	}
}
var pathTypeIds = [];
function selectAPath(path) {
	pathTypeIds = [];
	url = "REST/GetPathWS/SavePath?fLocationId=" + $("#departureId").val()
			+ "&tLocationId=" + $("#destinationId").val() + "&pathType="
			+ $("#pathType").val() + "&pathRoute=" + $("#pathLatLng").val();
	$("#departure").val(path.departure.locationName);
	$("#departureId").val(path.departure.locationID);
	$("#markerCoordinate").val(path.departure.gps);
	$("#pathLatLng").val(path.departure.gps);
	var ptids = path.pathType.split(",");
	$(".pathTypeIcon").each(function() {
		if ($(this).hasClass("pathTypeIconSelected"))
			$(this).removeClass("pathTypeIconSelected");
		$(this).trigger("create");
	});
	$("#pathTypePopup").trigger("create");
	for ( var int = 0; int < ptids.length; int++) {
		selectIcon(ptids[int] + "");
	}
	$("#pathTypeIds").val(path.pathType);
	$("#pathLength").html(getTheLength(path.distance));
	$("#destination").val(path.destination.locationName);
	$("#destinationId").val(path.destination.locationID);
	$("#pathWidth").val(path.width);
	$("#pathId").val(path.pathId);
	$("#pathWidth").slider("refresh");
	$("#pathWidth").trigger("create");
	if (paths != null)
		for ( var i = 0; i < paths.length; i++) {
			if (paths[i].id == path.pathId) {
				paths[i].setOptions({
					strokeColor : 'red'
				});
			} else {
				paths[i].setOptions({
					strokeColor : '#081B2C'
				});
			}
			paths[i].setMap(null);
			paths[i].setMap(map);
		}
}

function selectIcon(id) {
	$(".pathTypeIcon").each(function() {
		var pathTypeId = $(this).attr("alt");
		if (pathTypeId == id) {
			if (!$(this).hasClass("pathTypeIconSelected")) {
				$(this).addClass("pathTypeIconSelected");
				pathTypeIds.push(id);
			} else {
				$(this).removeClass("pathTypeIconSelected");
				var i = pathTypeIds.indexOf(id);
				if (i != -1) {
					pathTypeIds.splice(i, 1);
				}

			}
			$(this).trigger("create");
		}
	});
	$("#pathTypePopup").trigger("create");
	$("#pathTypeIds").val(pathTypeIds.join(","));
}

function getTheLength(distance) {
	var Kilometres = Math.floor(distance / 1000);
	var Metres = Math.round(distance - (Kilometres * 1000));
	var res = "";
	if (Kilometres != 0)
		res = Kilometres + "." + Metres + " (Km) ";
	else
		res = Metres + " (m) ";
	return res;
}