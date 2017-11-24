function getAllPaths() {
	for ( var i = 0; i < paths.length; i++) {
			paths[i].setMap(null);
	}
	var url = "REST/GetRouteWS/GetRoutesForUserAndParent?userName=NMMU&parentId="
			+ $("#parentLocationId").val();
	$.ajax({
		url : url,
		cache : false,
		async : true,
		beforeSend : function() {
			ShowLoadingScreen("Fetching paths");
		},
		success : function(data) {
			if (paths != null)
				for ( var i = 0; i < paths.length; i++) {
					paths[i].setMap(null);
				}
			$.each(data, function(k, l) {
				addAPathToMap(l);
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

function addAPathToMap(l) {
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
	if (l.pathType.pathTypeId == "1")
		color = '#ffb400';
	if (l.pathType.pathTypeId == "2")
		color = '#0ec605';
	if (l.pathType.pathTypeId == "3")
		color = '#3359fc';
	if (l.pathType.pathTypeId == "4")
		color = '#000000';
	if (l.pathType.pathTypeId == "5")
		color = '#ffffff';
	if (l.pathType.pathTypeId == "6")
		color = '#fc33f0';
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
	var url = "REST/GetLocationWS/SavePath?fLocationId="
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
			addAPathToMap(data);
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
function updateMovingLine(event) {
	var pointPath = event.latLng;
	var tmpPathCoor = [];
	tmpPathCoor.push(pointPath);
	tmpPathCoor.push(lastOne);
	var lineSymbol = {
		path : 'M 0,-1 0,1',
		strokeOpacity : 1,
		scale : 4
	};
	if (movingLine == null) {
		movingLine = new google.maps.Polyline({
			path : tmpPathCoor,
			icons : [ {
				icon : lineSymbol,
				offset : '0',
				repeat : '20px'
			} ],
			strokeColor : 'blue',
			strokeOpacity : 0,
			map : map
		});
		google.maps.event.addListener(movingLine, "click", function(event) {
			addAPathInnerConnection(event);
		});
		paths.push(movingLine);
	} else
		movingLine.setPath(tmpPathCoor);

	movingLine.setMap(null);
	movingLine.setMap(map);
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
			strokeColor : 'black',
			strokeOpacity : 1.0,
			strokeWeight : 2
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
}

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
		google.maps.event.addListener(map, "mousemove", function(event) {
			updateMovingLine(event);
		});
		google.maps.event.addListener(map, "click", function(event) {
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
		// $("#pathLatLng").val($("#pathLatLng").val() + "_" + location.gps);
		openPathCreationPopup();
	}
}