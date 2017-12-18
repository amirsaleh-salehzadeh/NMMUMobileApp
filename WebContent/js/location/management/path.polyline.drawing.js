function setMapOnAllPolylines(map) {
	for ( var i = 0; i < paths.length; i++) {
		paths[i].setMap(map);
	}
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
			if (pathWidthScale <= 10)
				pathWidthScale = 5;
			if (pathWidthScale >= 27)
				pathWidthScale = 27;
			paths[i].setOptions({
				strokeWeight : pathWidthScale
			});
			paths[i].setMap(null);
			paths[i].setMap(map);
		}
}

var tmpIntersectionMarker = undefined;
var pathSelected = false;
function drawApath(l) {
	var pathCoor = [];
	var pathCoorPolygon = [];
//	pathCoor.push(new google.maps.LatLng(
//			parseFloat(l.departure.gps.split(',')[0]),
//			parseFloat(l.departure.gps.split(',')[1])));
	pathCoorPolygon.push([ parseFloat(l.departure.gps.split(',')[1]),
			parseFloat(l.departure.gps.split(',')[0]) ]);
	if (l.pathRoute != null && l.pathRoute.length > 0) {
		var tm = l.pathRoute.split("_");
		if (tm.length == 1) {
//			pathCoor.push(new google.maps.LatLng(
//					parseFloat(tm[0].split(',')[0]), parseFloat(tm[0]
//							.split(',')[1])));
			pathCoorPolygon.push([ parseFloat(tm[0].split(',')[1]),
					parseFloat(tm[0].split(',')[0]) ]);
		}
		for ( var i = 0; i < tm.length; i++) {
//			pathCoor.push(new google.maps.LatLng(
//					parseFloat(tm[i].split(',')[0]), parseFloat(tm[i]
//							.split(',')[1])));
			pathCoorPolygon.push([ parseFloat(tm[i].split(',')[1]),
			   					parseFloat(tm[i].split(',')[0]) ]);
		}
	}
//	pathCoor.push(new google.maps.LatLng(parseFloat(l.destination.gps
//			.split(',')[0]), parseFloat(l.destination.gps.split(',')[1])));
	pathCoorPolygon.push([ parseFloat(l.destination.gps
			.split(',')[1]), parseFloat(l.destination.gps.split(',')[0]) ]);
//	var tmpCircle = new google.maps.Circle({
//		strokeColor : '#00FF00',
//		strokeOpacity : 0.3,
//		strokeWeight : 2,
//		fillColor : '#00FF00',
//		fillOpacity : 0,
//		center : map.getCenter(),
//		map : map,
//		radius : parseFloat(l.width) / 2
//	});

//	if (overlay.getProjection() != undefined) {
//		var point1 = overlay.getProjection().fromLatLngToDivPixel(
//				tmpCircle.getBounds().getNorthEast());
//		var point2 = overlay.getProjection().fromLatLngToDivPixel(
//				tmpCircle.getBounds().getCenter());
//		pathWidthScale = Math.round(Math.sqrt(Math.pow(point1.x - point2.x, 2)
//				+ Math.pow(point1.y - point2.y, 2))) * 2;
//	}
//	tmpCircle.setMap(null);
//	if (pathWidthScale <= 10)
//		pathWidthScale = 5;
//	if (pathWidthScale >= 27)
//		pathWidthScale = 27;

	var distance = parseFloat(l.width) / 222240, // Roughly 10km
	geoInput = {
		type : "LineString",
		coordinates : pathCoorPolygon
	};
	var geoReader = new jsts.io.GeoJSONReader(), geoWriter = new jsts.io.GeoJSONWriter();
	var geometry = geoReader.read(geoInput).buffer(distance);
	var polygon = geoWriter.write(geometry);

	var oLanLng = [];
	var oCoordinates;
	oCoordinates = polygon.coordinates[0];
	for (i = 0; i < oCoordinates.length; i++) {
		var oItem;
		oItem = oCoordinates[i];
		oLanLng.push(new google.maps.LatLng(oItem[1], oItem[0]));
	}

	var polygon = new google.maps.Polygon({
		paths : oLanLng,
		map : map,
		strokeColor : "#081B2C",
		strokeWeight : 2,
		fillColor : "#081B2C",
		customInfo : l.width + ";" + l.pathType,
		zIndex : 10
	});

	var pathPolyline = new google.maps.Polyline({
		path : pathCoor,
		geodesic : true,
		strokeColor : '#081B2C',
		strokeOpacity : 0.6,
		strokeWeight : pathWidthScale,
		customInfo : l.width + ";" + l.pathType,
		zIndex : 10
	});
	pathPolyline.id = l.pathId;
	polygon.id = l.pathId;
	polygon.addListener('click', function(event) {
		if (pathSelected) {
			if (paths != null) {
				for ( var i = 0; i < paths.length; i++) {
					if (paths[i] != null) {
						paths[i].setOptions({
							strokeColor : '#081B2C'
						});
						paths[i].setMap(null);
						paths[i].setMap(map);
					}
				}
			}
			pathSelected = false;
		} else {
			var lat = event.latLng.lat();
			var lng = event.latLng.lng();
			pathEditPanelOpen(l.pathName);
			if ($('#destination').val().length <= 0
					&& $('#departure').val().length > 0) {
				createAPointOnAnExistingPath(l, lat + "," + lng, pathPolyline);
			} else {
				selectAPath(l);
			}
			pathSelected = true;
		}
	});
	polygon.addListener('mousemove', function(event) {
		if (tmpIntersectionMarker != undefined) {
			tmpIntersectionMarker.setMap(null);
			tmpIntersectionMarker = null;
		}
		if ($('#destination').val().length <= 0
				&& $('#departure').val().length > 0) {
			updateMovingLine(event);
			var lat = event.latLng.lat();
			var lng = event.latLng.lng();
			var pos = {
				lat : parseFloat(lat),
				lng : parseFloat(lng)
			};
			if (tmpIntersectionMarker == undefined)
				tmpIntersectionMarker = new google.maps.Marker({
					map : map,
					icon : {
						path : google.maps.SymbolPath.CIRCLE,
						scale : 10,
						color : 'green',
						fillOpacity : 1
					},
					labelStyle : {
						opacity : 1.0
					},
					position : pos,
					title : "Create New Intersetion"
				});
			else
				tmpIntersectionMarker.setPosition(pos);
			google.maps.event.addListener(tmpIntersectionMarker, "click",
					function(event) {
						openPathTypePopup();
						createAPointOnAnExistingPath(l, {
							x : parseFloat(lat),
							y : parseFloat(lng)
						}, pathPolyline);
					});
		}
	});
	polygon.addListener('mouseout', function(event) {
		if (tmpIntersectionMarker != undefined) {
			tmpIntersectionMarker.setMap(null);
			tmpIntersectionMarker = null;
		}
	});
	polygon.setMap(map);
	paths.push(polygon);
}

$(document).keyup(function(e) {
	if (e.keyCode == 27) {
		cancelADrawnPath();
	} else if (e.keyCode == 46) {
		removePath();
	}
});

function updateMovingLine(event) {
	var pointPath = event.latLng;
	pathDrawingCircle.setCenter(pointPath);
	var tmpPathCoor = [];
	tmpPathCoor.push(lastOne);
	tmpPathCoor.push(pointPath);
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
	if (pathWidthScale >= 27)
		pathWidthScale = 27;
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
	} else
		movingLine.setPath(tmpPathCoor);
	movingLine.setOptions({
		strokeWeight : pathWidthScale,
		zIndex : 8
	});
	movingLine.setMap(null);
	movingLine.setMap(map);
	pathDrawingCircle.setMap(null);
	pathDrawingCircle.setMap(map);
	var km = movingLine.inKm();
	if (pathPolylineConstant != null)
		km += pathPolylineConstant.inKm();
	km = km * 1000;
	$("#pathLength").html(getTheLength(km));
}

function updateConstantLine() {
	var nextDestGPS = $("#pathLatLng").val().split("_");
	polylineConstantLength = 0;
	var tmpPathCoor = [];
	tmpPathCoor.push(getGoogleMapPosition($("#departureGPS").val()));
	for ( var i = 0; i < nextDestGPS.length; i++) {
		tmpPathCoor.push(getGoogleMapPosition(nextDestGPS[i]));
		lastOne = getGoogleMapPosition(nextDestGPS[i]);
	}
	if ($("#destinationGPS").val().length > 0)
		tmpPathCoor.push(getGoogleMapPosition($("#destinationGPS").val()));
	if (tmpPathCoor.length <= 1)
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
	// paths.push(pathPolylineConstant);
}

function cancelADrawnPath() {
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
	$("#departureGPS").val("");
	$("#locationId").val("");
	$("#pathId").val("");
	$("#pathLatLng").val("");
	if (pathDrawingCircle != null)
		pathDrawingCircle.setMap(null);
}

// DRAW A TEMPORARY PATH WITH JOINTS
function addAPathInnerConnection(event) {
	var lat = event.latLng.lat();
	var lng = event.latLng.lng();
	if ($("#pathLatLng").val().length > 1)
		$("#pathLatLng").val($("#pathLatLng").val() + "_" + lat + "," + lng);
	else
		$("#pathLatLng").val(lat + "," + lng);
	updateConstantLine();
	var bounds = new google.maps.LatLngBounds();
	bounds.extend(marker.getPosition());
	mapDrawingClickCounter++;
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
