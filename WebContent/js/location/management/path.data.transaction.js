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


// SAVE THE PATH BETWEEN A DESTINATION AND DEPARTURE WHICH CONTAINS MANY POINTS
function saveThePath() {
	if ($("#pathTypeIds").val().length <= 0) {
		alert("Select Path Type");
		return;
	}
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

// REMOVE A PATH
function removePath() {
	if ($("#pathId").val().length <= 0) {
		alert("please select a path");
		return;
	}
	if (confirm('Are you sure you want to remove this path?')) {
		var url = "REST/GetPathWS/RemoveAPath?pathId=" + $("#pathId").val();
		$.ajax({
			url : url,
			cache : false,
			async : true,
			beforeSend : function() {
				ShowLoadingScreen("Removing the path");
			},
			success : function(data) {
				for ( var i = 0; i < paths.length; i++) {
					if (paths[i].id == $("#pathId").val()) {
						paths[i].setMap(null);
						paths[i] = null;
					}
				}
				toast("remove successful");
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
		$("#departureGPS").val(location.gps);
//		$("#pathLatLng").val($("#departureGPS").val());
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
//		$("#pathLatLng").val(location.gps);
		return;
	} else if ($("#destinationId").val() == "") {
		$("#destination").val(location.locationName);
		$("#destinationId").val(location.locationID);
		google.maps.event.clearInstanceListeners(map);
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

