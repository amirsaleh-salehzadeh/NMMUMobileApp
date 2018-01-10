var movingLine, pathPolylineConstant, lastOne, overlay;
var pathWidthScale = 0;

function getAllPaths(refreshPaths) {
	overlay = new google.maps.OverlayView();
	overlay.draw = function() {
	};
	overlay.setMap(map);
	$("input[name='radio-choice']").each(function() {
		$(this).checkboxradio('disable');
	});
	console.log(pathMarkers.length);
	setMapOnAllMarkers(null);
	setMapOnAllPathMarkers(map);
	if (!refreshPaths && paths.length > 0) {
		setMapOnAllPolylines(map);
		// $("input[name='radio-choice']").checkboxradio('enable');
		$("input[name='radio-choice']").each(function() {
			$(this).checkboxradio('enable');
		});
		return;
	}
	setMapOnAllPolylines(null);
	path = [];
	pathCreateNewPolygons = [];
	pathPolylines = [];
	var url = "REST/GetPathWS/GetPathsForUserAndParent?userName=NMMU&parentId="
			+ $("#parentLocationId").val();
	$
			.ajax({
				url : url,
				cache : true,
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
					// $("input[name='radio-choice']").checkboxradio('enable');
					setMapOnAllPolylines(map);
				},
				error : function(xhr, ajaxOptions, thrownError) {
					popErrorMessage("An error occured while fetching the paths from the server. "
							+ thrownError);
					// alert("getAllPaths");
					// $("input[name='radio-choice']").checkboxradio('enable');
				}
			});
	$("input[name='radio-choice']").each(function() {
		$(this).checkboxradio('enable');
	});
}

// SAVE THE PATH BETWEEN A DESTINATION AND DEPARTURE WHICH CONTAINS MANY POINTS
function saveThePath() {
	if ($("#pathTypeIds").val().length <= 0
			|| $("#destinationId").val().length <= 0
			|| $("#departureId").val().length <= 0) {
		alert("Select Path Type");
		return;
	}
//	alert($("#pathTypeIds").val());
//	return;
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
			for ( var i = 0; i < paths.length; i++) {
				if (paths[i].id == data.pathId) {
					paths[i].setMap(null);
					paths.splice(i, 1);
					pathCreateNewPolygons[i].setMap(null);
					pathCreateNewPolygons.splice(i, 1);
				}
			}
			drawApath(data);
			toast("The path saved successfully");
		},
		complete : function() {
			HideLoadingScreen();
			if (tmpModifiedPathPolygon != null) {
				tmpModifiedPathPolygon.setMap(null);
				tmpModifiedPathPolygon = null;
			}
			hidePathInfo();
		},
		error : function(xhr, ajaxOptions, thrownError) {
			popErrorMessage("An error occured while saving the path. "
					+ thrownError);
		}
	});
	hidePathInfo();
}

// REMOVE A PATH
function removePath() {
	if ($("#pathId").val().length <= 0) {
		alert("please select a path");
		return;
	}
	if ($("#pathId").val().length <= 0) {
		alert("please select a path");
		return;
	}
	$("#popupConfirmation_confirmBTN").attr("onclick", "removePathFn()");
	showPopupConfirmation('Are you sure you want to remove this path?');
}

var removePathFn = function() {
	var url = "REST/GetPathWS/RemoveAPath?pathId=" + $("#pathId").val();
	$.ajax({
		url : url,
		cache : false,
		async : true,
		beforeSend : function() {
			ShowLoadingScreen("Removing the path");
		},
		success : function(data) {
			for ( var int = 0; int < paths.length; int++) {
				if ($("#pathId").val() == paths[int].id)
					i = int;
			}
			paths[i].setMap(null);
			pathCreateNewPolygons[i].setMap(null);
			paths.splice(i, 1);
			pathCreateNewPolygons.splice(i, 1);
			toast("remove successful");
			hidePathInfo();
		},
		complete : function() {
			HideLoadingScreen();
		},
		error : function(xhr, ajaxOptions, thrownError) {
			popErrorMessage("An error occured while removing the path. "
					+ thrownError);
		}
	});
}

var mapDrawingClickCounter;
function addAPath(entranceIntersection) {
	if (entranceIntersection == null) {
		alert("A path can only be drawn between two locations");
		return;
	}
	if (!newPathInProgress)
		return;
	if ($("#departureId").val() == "") {
		mapDrawingClickCounter = 1;
		$("#departure").val(entranceIntersection.description);
		$("#departureId").val(entranceIntersection.entranceId);
		$("#departureGPS").val(entranceIntersection.gps);
		lastOne = getGoogleMapPosition(entranceIntersection.gps);
		google.maps.event.clearInstanceListeners(map);
		google.maps.event.addListener(map, "mousemove", function(event) {
			updateMovingLine(event);
		});
		google.maps.event.addListener(map, "click", function(event) {
			addAPathInnerConnection(event);
		});
		return;
	} else if ($("#destinationId").val() == "") {
		$("#destination").val(entranceIntersection.description);
		$("#destinationId").val(entranceIntersection.entranceId);
		$("#destinationGPS").val(entranceIntersection.gps);
		google.maps.event.clearInstanceListeners(map);
		if (movingLine != undefined) {
			movingLine.setMap(null);
			movingLine = undefined;
		}
		updateConstantLine();
		$(".pathTypeIcon").each(function() {
			if ($(this).hasClass("pathTypeIconSelected")) {
				$(this).removeClass("pathTypeIconSelected");
			}
			$(this).trigger("create");
		});
		$("#mainBodyContents").trigger('create');
		$("#actionBarMessage").html("Place set the path types");
		$("#actionBarNextButton").attr("onclick", "createNew(1)").trigger(
				"create");
		$("#actionBarBackButton").attr("onclick", "createNew(0)");
		$("#actionBarNextButton").removeClass("disabledBTN").trigger("create");
		$("#actionBarBackButton").removeClass("disabledBTN").trigger("create");
	}
}
