function setMapOnAllPolylines(value) {
	for ( var i = 0; i < paths.length; i++) {
		paths[i].setMap(value);
	}
	for ( var i = 0; i < pathPolylines.length; i++) {
		pathPolylines[i].setMap(value);
	}
}

var tmpModifiedPathPolygon;
function changePathWith(slider) {
	if ($("#pathId").val() == 0 || $("#pathId").val().length <= 0)
		return;
	var pathRouteTMP;
	var index = -1;
	for ( var i = 0; i < pathPolylines.length; i++) {
		if (pathPolylines[i].id == $("#pathId").val()) {
			pathRouteTMP = pathPolylines[i].getPath();
			index = i;
		}
	}
	var pathCoorPolygon = [];
	for ( var i = 0; i < pathRouteTMP.getArray().length; i++) {
		pathCoorPolygon.push([ parseFloat(pathRouteTMP.getArray()[i].lng()),
				parseFloat(pathRouteTMP.getArray()[i].lat()) ]);
	}
	if (tmpModifiedPathPolygon != null) {
		tmpModifiedPathPolygon.setPath(measurePolygonForAPath(pathCoorPolygon,
				$(slider).val()));
	} else
		tmpModifiedPathPolygon = new google.maps.Polygon({
			paths : measurePolygonForAPath(pathCoorPolygon, $(slider).val()),
			map : map,
			strokeColor : "#027B2C",
			strokeWeight : 2,
			fillColor : "#081B2C",
			zIndex : 10
		});
}

function measurePolygonForAPath(coorPoly, width) {
	var distance = parseFloat(width) / 222240, geoInput = {
		type : "LineString",
		coordinates : coorPoly
	};
	var geoReader = new jsts.io.GeoJSONReader(), geoWriter = new jsts.io.GeoJSONWriter();
	var geometry = geoReader.read(geoInput).buffer(distance);
	var polygon = geoWriter.write(geometry);
	var oLanLng = [];
	var oCoordinates;
	oCoordinates = polygon.coordinates[0];
	for ( var i = 0; i < oCoordinates.length; i++) {
		var oItem;
		oItem = oCoordinates[i];
		oLanLng.push(new google.maps.LatLng(oItem[1], oItem[0]));
	}
	return oLanLng;
}

var tmpIntersectionMarker = undefined;
var pathSelected = false;
function drawApath(l) {
	var pathCoor = [];
	var pathCoorPolygon = [];
	pathCoorPolygon.push([ parseFloat(l.departure.gps.split(',')[1]),
			parseFloat(l.departure.gps.split(',')[0]) ]);
	pathCoor.push(getGoogleMapPosition(l.departure.gps));
	if (l.pathRoute != null && l.pathRoute.length > 0) {
		var tm = l.pathRoute.split("_");
		for ( var i = 0; i < tm.length; i++) {
			pathCoorPolygon.push([ parseFloat(tm[i].split(',')[1]),
					parseFloat(tm[i].split(',')[0]) ]);
			pathCoor.push(getGoogleMapPosition(tm[i]));
		}
	}
	pathCoorPolygon.push([ parseFloat(l.destination.gps.split(',')[1]),
			parseFloat(l.destination.gps.split(',')[0]) ]);
	pathCoor.push(getGoogleMapPosition(l.destination.gps));
	var polygon = new google.maps.Polygon({
		paths : measurePolygonForAPath(pathCoorPolygon, l.width),
		strokeColor : "#081B2C",
		strokeWeight : 2,
		fillColor : "#081B2C",
		customInfo : l.width + ";" + l.pathType,
		zIndex : 10
	});

	var pathPolyline = new google.maps.Polyline({
		path : pathCoor,
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
			hidePathInfo();
			pathSelected = false;
		} else {
			var lat = event.latLng.lat();
			var lng = event.latLng.lng();
			openPathEditPanel();
			if ($('#destination').val().length <= 0
					&& $('#departure').val().length > 0) {
				createAPointOnAnExistingPath(l, {
					x : parseFloat(lat),
					y : parseFloat(lng)
				}, pathPolyline);
//				createAPointOnAnExistingPath(l, lat + "," + lng, pathPolyline);
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
	pathPolylines.push(pathPolyline);
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
	pathDrawingCircle.setRadius(parseFloat($("#pathWidth").val()) / 2);
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
