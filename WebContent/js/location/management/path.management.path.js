function getAllPaths() {
	if (paths != null)
		for ( var i = 0; i < paths.length; i++) {
			paths[i].setMap(null);
		}
	var url = "REST/GetPathWS/GetRoutesForUserAndParent?userName=NMMU&parentId="
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

function setPathTypeButtonIcon() {
	
	$(".pathTypeIcon").each(function(){
		var pathTypeId = $(this).attr("alt");
		if(pathTypeId = "1")
			$(this).attr("src","images/icons/pathType/grass.png");
		if (pathTypeId == "1"){
			$(this).attr("src","images/icons/pathType/normalSpeed.png");
		}else if (pathTypeId == "2"){
			$(this).attr("src","images/icons/pathType/wheelchair.png");
		}else if (pathTypeId == "3")
			$(this).attr("src","images/icons/pathType/cursor-pointer.png");
		else if (pathTypeId == "4")
			$(this).attr("src","images/icons/pathType/cursor-pointer.png");
		else if (pathTypeId == "5")
			$(this).attr("src","images/icons/pathType/cursor-pointer.png");
		else (pathTypeId == "6"){
			$(this).attr("src","images/icons/pathType/cursor-pointer.png");
		}
	});
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
	var color = '#FF0000';
	if (l.pathType.pathTypeId == "1"){
		color = '#ffb400';
	}else if (l.pathType.pathTypeId == "2"){
		color = '#0ec605';
	}else if (l.pathType.pathTypeId == "3")
		color = '#3359fc';
	else if (l.pathType.pathTypeId == "4")
		color = '#000000';
	else if (l.pathType.pathTypeId == "5")
		color = '#ffffff';
	else (l.pathType.pathTypeId == "6"){
		color = '#fc33f0';
	}
	var pathWidthStroke = Math.round(parseFloat(l.width)*parseFloat($("#pathWidth").val()));
	var pathPolyline = new google.maps.Polyline({
		path : pathCoor,
		geodesic : true,
		strokeColor : color,
		strokeOpacity : 1.0,
		strokeWeight : 2
	});
	pathPolyline.id = l.pathId;
	pathPolyline.addListener('click', function() {
		removePath(l.pathId);
	});
	pathPolyline.setMap(map);
	paths.push(pathPolyline);
}

// SAVE THE PATH BETWEEN A DESTINATION AND DEPARTURE WHICH INCLUDES MANY POINTS
function saveThePath() {
	$('#insertAPath').popup('close');
	saveAPath();
	cancelADrawnPath();
}

// SAVE A PATH BETWEEN TWO POINTS
function saveAPath() {
	var url = "REST/GetPathWS/SavePath?fLocationId="
			+ $("#departureId").val() + "&tLocationId="
			+ $("#destinationId").val() + "&pathType=" + $("#pathType").val()
			+ "&pathRoute=" + $("#pathLatLng").val();
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
function removePath(id) {
	// var loadingContent = "Removing Path";
	if (confirm('Are you sure you want to remove this path?')) {
		var url = "REST/GetLocationWS/RemoveAPath?pathId=" + id;
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
					if (paths[i].id == id)
						paths[i].setMap(null);
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
	$("#locationTypeId").val(5);////////////////////////////////this line is unnecessary

	var pathMarker = new google.maps.Marker({
		position : {
			lat : lat,
			lng : lng
		},
		map : map,
		icon : 'images/map-markers/road.png'
	});
	var bounds = new google.maps.LatLngBounds();
	bounds.extend(marker.getPosition());
	pathMarkers.push(pathMarker);
}

$(document).keyup(function(e) {
	if (e.keyCode == 27) {
		cancelADrawnPath();
	}
});

var movingLine, pathPolylineConstant, lastOne;
var pathWidthScale = 0;
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
	if(pathWidthScale > 33)
		pathWidthScale = 33;
//	var lineSymbol = {
//		path : 'M 0,-1 0,1',
//		strokeOpacity : 1,
//		strokeWeight: pathWidthScale
//	};

	if (movingLine == null) {
		movingLine = new google.maps.Polyline({
			path : tmpPathCoor,
//			icons : [ {
//				icon : lineSymbol,
//				offset : '0',
//				repeat : '20px'
//			} ],
			strokeColor : 'green',
			strokeOpacity : .66,
//			strokeWeight: pathWidthScale,
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
	$("#pathLength").html(movingLine.inKm());
}

var tmpPathCoor = [];
function updateConstantLine() {
	tmpPathCoor = [];
	var nextDestGPS = $("#pathLatLng").val().split("_");
	if ($("#pathLatLng").val() == "")
		nextDestGPS = $("#markerCoordinate").val();
	polylineConstantLength = 0;
	tmpPathCoor.push(getGoogleMapPosition($("#markerCoordinate").val()));
	for ( var i = 0; i < nextDestGPS.length; i++) {
		tmpPathCoor.push(getGoogleMapPosition(nextDestGPS[i]));
		lastOne = getGoogleMapPosition(nextDestGPS[i]);
	}
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
	$("#markerId").val("");
	$("#pathLatLng").val("");
	pathDrawingCircle.setMap(null);
}

var pathDrawingCircle, overlay;
function addAPath(location, gps) {
	gps = gps.replace(" ", "");
	if (location == null) {
		alert("A path can only be drawn between two locations");
		return;
	}
	if ($("#departure").val() == "") {
		$("#departure").val(location.locationName);
		$("#departureId").val(location.locationID);
		$("#markerCoordinate").val(location.gps);
		lastOne = getGoogleMapPosition(location.gps);
		google.maps.event.clearInstanceListeners(map);
		// $("#pathLatLng").val(location.gps);
		// updateConstantLine();
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
		$("#destination").val(location.locationName);
		$("#destinationId").val(location.locationID);
		google.maps.event.clearInstanceListeners(map);
		var lastUnnecessaryMarkerGPS = $("#pathLatLng").val().split("_")[$(
				"#pathLatLng").val().split("_").length];
		$("#pathLatLng").val(
				$("#pathLatLng").val().replace("_" + lastUnnecessaryMarkerGPS,
						""));
		pathDrawingCircle.setMap(null);
		// $("#pathLatLng").val($("#pathLatLng").val() + "_" + location.gps);
//		openPathCreationPopup();
	}
}