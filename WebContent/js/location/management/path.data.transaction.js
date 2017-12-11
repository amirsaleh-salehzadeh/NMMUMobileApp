var movingLine, pathPolylineConstant, lastOne, overlay, pathDrawingCircle;
var pathWidthScale = 0;

function getAllPaths(newPaths, refreshPaths) {
	overlay = new google.maps.OverlayView();
	overlay.draw = function() {
	};
	overlay.setMap(map);
	$("input[name='radio-choice']").each(function(){
		$(this).checkboxradio('disable');
	});
	setMapOnAllMarkers(null);
	setMapOnAllPathMarkers(map);
	if (!refreshPaths && paths.length > 0) {
		setMapOnAllPolylines(map);
//		$("input[name='radio-choice']").checkboxradio('enable');
		$("input[name='radio-choice']").each(function(){
			$(this).checkboxradio('enable');
		});
		return;
	}
	setMapOnAllPolylines(null);
	path = [];
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
//			$("input[name='radio-choice']").checkboxradio('enable');
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
			alert("getAllPaths");
//			$("input[name='radio-choice']").checkboxradio('enable');
		}
	});
	$("input[name='radio-choice']").each(function(){
		$(this).checkboxradio('enable');
	});}

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
				var i = paths.indexOf($("#pathId").val());
				paths[i].setMap(null);
				paths.splice(i, 1);
				toast("remove successful");
				cancelADrawnPath();
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
function addAPath(location) {
	if (location == null) {
		alert("A path can only be drawn between two locations");
		return;
	}
	if ($("#departure").val() == "") {
		mapDrawingClickCounter = 1;
		$("#departure").val(location.locationName);
		$("#departureId").val(location.locationID);
		$("#departureGPS").val(location.gps);
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
		openPathTypePopup();
	}
}
