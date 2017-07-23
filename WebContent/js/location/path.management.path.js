function getAllPaths() {
	var url = "REST/GetLocationWS/GetAllPathsForUser?userName=NMMU";
	for ( var i = 0; i < paths.length; i++) {
		paths[i].setMap(null);
	}
	$.ajax({
		url : url,
		cache : false,
		success : function(data) {
			$.each(data, function(k, l) {
				var pathCoor = [];
				pathCoor.push(new google.maps.LatLng(parseFloat(l.departure.gps
						.split(',')[0]),
						parseFloat(l.departure.gps.split(',')[1])));
				pathCoor.push(new google.maps.LatLng(
						parseFloat(l.destination.gps.split(',')[0]),
						parseFloat(l.destination.gps.split(',')[1])));
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
					strokeWeight : 6
				});
				pathPolyline.addListener('click', function() {
					removePath(l.pathId);
				});
				pathPolyline.setMap(map);
				paths.push(pathPolyline);
			});
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});
}

function savePath() {
	var locationLatLngs = $("#pathLatLng").val().split(",");
	for ( var i = 1; i < locationLatLngs.length; i++) {
		var des, dep;
		dep = $("#departureId").val();
		des = $("#destinationId").val();
		$("#markerName").val("Intersection");
		$("#markerCoordinate").val(locationLatLngs[i]);
		$("#locationTypeId").val(5);
		$("#markerId").val(0);
		saveMarker();
		$("#departureId").val(locationIds[i]);
		$("#destinationId").val(locationIds[i + 1]);
		var url = "REST/GetLocationWS/SavePath?fLocationId="
				+ $("#departureId").val() + "&tLocationId="
				+ $("#destinationId").val() + "&pathType="
				+ $("#pathType").val();
		$.ajax({
			url : url,
			cache : false,
			async : true,
			success : function(data) {
				$("#departure").val("");
				$("#departureId").val("");
				$("#destination").val("");
				$("#destinationId").val("");
				$('#insertAPath').popup('close');
			},
			error : function(xhr, ajaxOptions, thrownError) {
				alert(xhr.status);
				alert(thrownError);
			}
		});
	}
	getAllPaths();
}

function removePath(id) {
	if (confirm('Are you sure you want to remove this path?')) {
		var url = "REST/GetLocationWS/RemoveAPath?pathId=" + id;
		$.ajax({
			url : url,
			cache : false,
			success : function(data) {
				if (data.errorMSG != null) {
					alert(data.errorMSG);
					return;
				}
				getAllPaths();
			},
			error : function(xhr, ajaxOptions, thrownError) {
				alert(xhr.status);
				alert(thrownError);
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
	$("#pathLatLng").val($("#pathLatLng").val() + "_" + lat + "," + lng);
	updateConstantLine();
	$("#locationTypeId").val(5);
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

var constantLine, movingLine, pathPolylineConstant, lastOne;
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
	polylineConstantLength = 0;
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
			strokeColor : 'green',
			strokeOpacity : 1.0,
			strokeWeight : 3
		});
	else
		pathPolylineConstant.setPath(tmpPathCoor);
	pathPolylineConstant.setMap(map);
	paths.push(pathPolylineConstant);
}

function cancelAPath() {
	for ( var i = 0; i < tmpPathCoor.length; i++) {
		tmpPathCoor[i].setMap(null);
	}
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
		google.maps.event.clearInstanceListeners(map);
		$("#pathLatLng").val(location.gps);
		updateConstantLine();
		google.maps.event.addListener(map, "mousemove", function(event) {
			updateMovingLine(event);
		});
		google.maps.event.addListener(map, "click", function(event) {
			addAPathInnerConnection(event);
		});
		return;
	} else if ($("#destination").val() == "") {
		$("#destination").val(location.locationName);
		$("#destinationId").val(location.locationID);
		google.maps.event.clearInstanceListeners(map);
		var lastUnnecessaryMarkerGPS = $("#pathLatLng").val().split("_")[$(
				"#pathLatLng").val().split("_").length];
		$("#pathLatLng").val(
				$("#pathLatLng").val().replace("_" + lastUnnecessaryMarkerGPS,
						""));
		// $("#markerId").val(lastUnnecessaryMarkerId);
		// var url = "REST/GetLocationWS/RemoveALocation?locationId="
		// + $("#markerId").val();
		// $.ajax({
		// url : url,
		// cache : false,
		// async : true,
		// success : function(data) {
		// $('#insertAMarker').popup('close');
		// if (data.errorMSG != null) {
		// alert(data.errorMSG);
		// return;
		// }
		// getAllMarkers();
		// },
		// error : function(xhr, ajaxOptions, thrownError) {
		// alert(xhr.status);
		// alert(thrownError);
		// }
		// });
		$("#pathLatLng").val($("#pathLatLng").val() + "_" + location.gps);
		openPathCreationPopup();
	}
}