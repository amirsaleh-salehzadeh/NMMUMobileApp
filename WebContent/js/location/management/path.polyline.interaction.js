var intmpIntersectionMarker;
function createAPointOnAnExistingPath(path, destinationGPS, polyline) {
	if (!confirm("create intersection?")) {
		return;
	}
	if ($("#pathTypeIds").val().length <= 0) {
		alert("Select Path Type");
		return;
	}
	// All points on the polyline
	var pointsInLine = [];
	$(polyline.getPath().getArray()).each(function(k, l) {
		var point = {
			x : parseFloat(l.lat()),
			y : parseFloat(l.lng())
		};
		pointsInLine.push(point);
	});
	var intersectionpoint = getClosestPointOnLines(destinationGPS, pointsInLine);
	var url = "REST/GetPathWS/CreateAPointOnThePath?pathId=" + path.pathId
			+ "&pointGPS=" + destinationGPS.x + "," + destinationGPS.y
			+ "&index=" + intersectionpoint.i;
	var intersectId = 0;
	$.ajax({
		url : url,
		cache : false,
		async : true,
		beforeSend : function() {
			ShowLoadingScreen("Creating an Intersection on the Path");
		},
		success : function(data) {
			$.each(data, function(k, l) {
				drawApath(l);
				if (k == 0)
					intersectId = l.destination.locationID;
			});
			for ( var i = 0; i < paths.length; i++) {
				if (paths[i] != null && paths[i].id == path.pathId) {
					paths[i].setMap(null);
					paths[i] = null;
				}
			}
			toast("Successful");
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
						strokeColor : 'black',
						fillOpacity : 1
					},
					labelStyle : {
						opacity : 1.0
					},
					position : intersection,
					title : "Create New Intersetion"
				});
			else
				intmpIntersectionMarker.setPosition(intersection);
			intmpIntersectionMarker.id = intersectId;
			markers.push(intmpIntersectionMarker);
			if ($("#destinationId").val().length < 1) {
				$("#destination").val("Intersection");
				$("#destinationId").val(intersectId);
				$("#destinationGPS").val(
						destinationGPS.x + "," + destinationGPS.y);
				google.maps.event.clearInstanceListeners(map);
				pathDrawingCircle.setMap(null);
				google.maps.event.clearInstanceListeners(map);
				if (movingLine != undefined) {
					movingLine.setMap(null);
					movingLine = undefined;
				}
				updateConstantLine();
				google.maps.event.clearInstanceListeners(map);
				saveThePath();
			} else {
				var location = {
					locationName : "Intersection",
					locationID : intersectId,
					gps : destinationGPS.x + "," + destinationGPS.y
				};
				addAPath(location);
			}
		},
		complete : function() {
			HideLoadingScreen();
		},
		error : function(xhr, ajaxOptions, thrownError) {
//			alert(xhr.status);
//			alert(thrownError);
//			alert("CreatingIntersection");
			popErrorMessage("An error occured while creating an intersection. "+ thrownError);
		}
	});
}

var pathTypeIds = [];
function selectAPath(path) {
	pathTypeIds = [];
	url = "REST/GetPathWS/SavePath?fLocationId=" + $("#departureId").val()
			+ "&tLocationId=" + $("#destinationId").val() + "&pathType="
			+ $("#pathType").val() + "&pathRoute=" + $("#pathLatLng").val();
	$("#departure").val(path.departure.locationName);
	$("#departureId").val(path.departure.locationID);
	$("#departureGPS").val(path.departure.gps);
	$("#pathLatLng").val(path.pathRoute);
	var ptids = path.pathType.split(",");
	for ( var int = 0; int < ptids.length; int++) {
		selectIcon(ptids[int] + "");
	}
	$("#pathTypeIds").val(path.pathType);
	$("#pathLength").html(getTheLength(path.distance));
	$("#destination").val(path.destination.locationName);
	$("#destinationId").val(path.destination.locationID);
	$("#destinationGPS").val(path.destination.gps);
	$("#pathWidth").val(path.width);
	$("#pathId").val(path.pathId);
	$("#pathWidth").slider("refresh");
	$("#pathWidth").trigger("create");
	if (paths != null)
		for ( var i = 0; i < paths.length; i++) {
			if (paths[i] != null) {
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