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
var tmpIntersectionMarker = undefined;
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
	if (pathWidthScale <= 10)
		pathWidthScale = 5;
	if (pathWidthScale >= 27)
		pathWidthScale = 27;
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
	pathPolyline.addListener('click', function(event) {
		var lat = event.latLng.lat();
		var lng = event.latLng.lng();
		if ($('#destination').val().length <= 0
				&& $('#departure').val().length > 0) {
			createAPointOnAnExistingPath(l, lat + "," + lng, this);
		} else {
			selectAPath(l);
		}
	});
	pathPolyline.addListener('mousemove', function(event) {
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
			// var gps = event.latLng.lat() + ","
			// + parseFloat(event.latLng.lng());
			if (tmpIntersectionMarker == undefined)
				tmpIntersectionMarker = new google.maps.Marker({
					map : map,
					icon : {
						path : google.maps.SymbolPath.CIRCLE,
						scale : 10,
						color : 'green'
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
						createAPointOnAnExistingPath(l, {
							x : parseFloat(lat),
							y : parseFloat(lng)
						}, this);
					});
		}
	});
	pathPolyline.addListener('mouseout', function(event) {
		if (tmpIntersectionMarker != undefined) {
			tmpIntersectionMarker.setMap(null);
			tmpIntersectionMarker = null;
		}
	});
	pathPolyline.setMap(map);
	paths.push(pathPolyline);
}

var intmpIntersectionMarker;
function createAPointOnAnExistingPath(path, destinationGPS) {
	var line = path.pathRoute.split("_");
	var pointsInLine = [];
	$(line).each(function(k, l) {
		var point = {
			x : parseFloat(l.split(",")[0]),
			y : parseFloat(l.split(",")[1])
		};
		pointsInLine.push(point);
	});
	var intersectionpoint = getClosestPointOnLines(destinationGPS, pointsInLine);
	alert('i ' + intersectionpoint.i + ' fTo ' + intersectionpoint.fTo
			+ ' fFrom ' + intersectionpoint.fFrom);

	var intersection = {
		lat : intersectionpoint.x,
		lng : intersectionpoint.y
	};
	if (intmpIntersectionMarker == null)
		intmpIntersectionMarker = new google.maps.Marker({
			map : map,
			icon : {
				path : google.maps.SymbolPath.CIRCLE,
				scale : 10,
				strokeColor : 'red'
			},
			labelStyle : {
				opacity : 1.0
			},
			position : intersection,
			title : "Create New Intersetion"
		});
	else
		intmpIntersectionMarker.setPosition(intersection);
	if (!confirm("create intersation?")) {
		intmpIntersectionMarker.setMap(null);
		intmpIntersectionMarker = null;
		return;
	}
	alert(1);
	return;
	var url = "REST/GetPathWS/SavePathConnectToAnExistingPath?fLocationId="
			+ $("#departureId").val() + "&tLocationGPS=" + destinationGPS
			+ "&pathType=" + $("#pathTypeIds").val() + "&pathRoute="
			+ $("#pathLatLng").val() + "&width=" + $("#pathWidth").val()
			+ "&pathName=" + $("#pathName").val() + "&description="
			+ $("#pathDescription").val() + "&destinationPathId=" + path.pathId;

	$.ajax({
		url : url,
		cache : false,
		async : true,
		beforeSend : function() {
			ShowLoadingScreen("Saving the path");
		},
		success : function(data) {
			$.each(data, function(k, l) {
				drawApath(l);
			});
			// $("#departureId").val($("#destinationId").val());
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

$(document).keyup(function(e) {
	if (e.keyCode == 27) {
		cancelADrawnPath();
	}
});

var tmpPathCoor;
function updateMovingLine(event) {
	var pointPath = event.latLng;
	pathDrawingCircle.setCenter(pointPath);
//	if (tmpPathCoor == null)
		tmpPathCoor = [];
//	else
//		for ( var int = 0; int < tmpPathCoor.length; int++) {
//			tmpPathCoor[int].setMap(null);
//			tmpPathCoor[int] = null;
//		}
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
		paths.push(movingLine);
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

// DRAW A TEMPORARY PATH WITH JOINTS
var pathMarkers = [];
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

function getClosestPointOnLines(pXy, aXys) {

	var fTo, minDist, fFrom, x, y, i, dist;

	if (aXys.length > 1) {
		for ( var n = 1; n < aXys.length; n++) {
			if (aXys[n].x != aXys[n - 1].x) {
				var a = (aXys[n].y - aXys[n - 1].y)
						/ (aXys[n].x - aXys[n - 1].x);
				var b = aXys[n].y - a * aXys[n].x;
				dist = Math.abs(a * pXy.x + b - pXy.y) / Math.sqrt(a * a + 1);
			} else
				dist = Math.abs(pXy.x - aXys[n].x)
			var rl2 = Math.pow(aXys[n].y - aXys[n - 1].y, 2)
					+ Math.pow(aXys[n].x - aXys[n - 1].x, 2);
			var ln2 = Math.pow(aXys[n].y - pXy.y, 2)
					+ Math.pow(aXys[n].x - pXy.x, 2);
			var lnm12 = Math.pow(aXys[n - 1].y - pXy.y, 2)
					+ Math.pow(aXys[n - 1].x - pXy.x, 2);
			var dist2 = Math.pow(dist, 2);
			var calcrl2 = ln2 - dist2 + lnm12 - dist2;
			if (calcrl2 > rl2)
				dist = Math.sqrt(Math.min(ln2, lnm12));
			if ((minDist == null) || (minDist > dist)) {
				if (calcrl2 > rl2) {
					if (lnm12 < ln2) {
						fTo = 0;
						fFrom = 1;
					} else {
						fFrom = 0;
						fTo = 1;
					}
				} else {
					fTo = ((Math.sqrt(lnm12 - dist2)) / Math.sqrt(rl2));
					fFrom = ((Math.sqrt(ln2 - dist2)) / Math.sqrt(rl2));
				}
				minDist = dist;
				i = n;
			}
		}
		var dx = aXys[i - 1].x - aXys[i].x;
		var dy = aXys[i - 1].y - aXys[i].y;
		x = aXys[i - 1].x - (dx * fTo);
		y = aXys[i - 1].y - (dy * fTo);
	}

	return {
		'x' : x,
		'y' : y,
		'i' : i,
		'fTo' : fTo,
		'fFrom' : fFrom
	};
}