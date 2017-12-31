var pathMarkers = [];
var parentAreaPolygon;
function removeMarker() {
	var url = "REST/GetLocationWS/RemoveALocation?locationId="
			+ $("#locationId").val();
	var loadingContent;
	if ($("#locationTypeId").val() == 3) {
		loadingContent = "Removing Building";
	} else {
		loadingContent = "Removing Intersection";
	}
	if (confirm('Are you sure you want to remove this location?'))
		$.ajax({
			url : url,
			cache : false,
			async : true,
			beforeSend : function() {
				ShowLoadingScreen(loadingContent);
			},
			success : function(data) {
				if (data.errorMSG != null) {
					alert(data.errorMSG);
					return;
				}

				var id = $("#locationId").val();
				for ( var i = 0; i < polygons.length; i++) {
					if (polygons[i].id == id) {
						polygons[i].setMap(null);
						polygons.splice(i, 1);
						$('#locationEditMenu').popup('close');
						return;
					}
				}
				deleteMarker(id);
				$(".locationFields").val("");
			},
			complete : function() {
				HideLoadingScreen();
			},
			error : function(xhr, ajaxOptions, thrownError) {
				popErrorMessage("An error occured while removing the marker. "
						+ thrownError);
			}
		});
}

function deleteMarker(id) {
	var i = markers.indexOf(id);
	markers[i].setMap(null);
	markers.splice(i, 1);
	return;
}

function saveLocation() {
	var loadingContent;
	if (selectedShape == null
			&& ($("#locationId").val() != "" || $("#locationId").val() <= 0)) {
		selectedShape.setMap(null);
		selectedShape = null;
	}
	if ($("#locationTypeId").val() == 3) {
		loadingContent = "Saving Building";
	} else {
		loadingContent = "Saving Intersection";
	}
	if ($("#locationName").val() == "") {
		alert("Please select a name for the location");
		return;
	}
	var url = "REST/GetLocationWS/SaveUpdateLocation";
	$("#boundary").val(
			$("#boundary").val() + ";"
					+ (Math.random() * 0xFFFFFF << 0).toString(16) + ","
					+ (Math.random() * 0xFFFFFF << 0).toString(16));
	$("#boundaryColors").val($("#tempBoundaryColors").val());
	$.ajax({
		url : url,
		cache : false,
		async : true,
		dataType : 'text',
		type : 'POST',
		data : {
			icon : $("#icon").val(),
			locationName : $("#locationName").val(),
			parentId : $("#parentLocationId").val(),
			coordinate : $("#locationGPS").val(),
			locationTypeId : $("#locationTypeId").val(),
			locationId : $("#locationId").val(),
			description : $("#locationDescription").val(),
			plan : "",
			boundary : $("#boundary").val(),
			userName : "NMMU"
		},
		beforeSend : function() {
			ShowLoadingScreen(loadingContent);
		},
		success : function(data) {
			data = JSON.parse(data);
			$("#locationId").val(data.locationID);
			addMarker(data);
			toast('Saved Successfully');
			if (selectedShape != null)
				selectedShape.setEditable(false);
		},
		complete : function() {
			HideLoadingScreen();
			closeAMenuPopup();
		},
		error : function(xhr, ajaxOptions, thrownError) {
			popErrorMessage("An error occured while saving the marker. "
					+ thrownError);
		},
	});
}

var str = "";
function getAllMarkers(parentId, refreshMarkers) {
	minZoomLevel = 1;
	$("input[name='radio-choice']").checkboxradio();
	$("input[name='radio-choice']").checkboxradio('disable');
	var url = "REST/GetLocationWS/GetAllLocationsForUser?parentLocationId="
			+ parentId + "&locationTypeId=&userName=NMMU";
	setMapOnAllPolylines(null);
	if (!refreshMarkers) {// && markers.length > 0
		setMapOnAllPathMarkers(null);
		setMapOnAllMarkers(map);
		$("input[name='radio-choice']").checkboxradio('enable');
		return;
	}
	$
			.ajax({
				url : url,
				cache : true,
				async : true,
				beforeSend : function() {
					ShowLoadingScreen("Fetching locations");
					setMapOnAllMarkers(null);
					setMapOnAllPolygons(null);
					for ( var int = 0; int < polygonsEdit.length; int++) {
						polygonsEdit[int].setMap(null);
					}
					if (parentAreaPolygon != null) {
						parentAreaPolygon.setMap(null);
						parentAreaPolygon = null;
					}
				},
				success : function(data) {
					str = "";
					markers = [];
					polygons = [];
					// pathMarkers = [];
					paths = [];
					pathPolylines = [];
					polygonsEdit = [];
					$.each(data, createMarkersOnMap);
					setMapOnAllPathMarkers(null);
					setMapOnAllMarkers(map);
					setMapOnAllPolygons(map);
				},
				complete : function() {
					HideLoadingScreen();
					$("input[name='radio-choice']").checkboxradio('enable');
				},
				error : function(xhr, ajaxOptions, thrownError) {
					$("input[name='radio-choice']").checkboxradio('enable');
					popErrorMessage("An error occured while fetching the markers from the server. "
							+ thrownError);
				}
			});
}

function createMarkersOnMap(k, l) {
	if (k == 0) {
		getMarkerInfo(l);
		if (l.parent.boundary != null && l.parent.boundary.length > 3) {
			var bnd = l.parent.boundary.split(";")[0].split("_");
			var coordinatesArray = [];
			for ( var i = 0; i < bnd.length; i++) {
				coordinatesArray.push(getGoogleMapPosition(bnd[i]));
			}
			coordinatesArray.push(getGoogleMapPosition(bnd[0]));
			parentAreaPolygon = new google.maps.Polyline({
				path : coordinatesArray,
				strokeColor : "#FF0000",
				strokeOpacity : 1,
				strokeWeight : 1,
				zIndex : 1,
				map : map

			});
		}
		getParentLocationTypeId(null, l.locationType.locationTypeId);
		getLocationTypeDropDown(null);
	}
	addMarker(l);
}

function getMarkerInfo(location) {
	do {
		if (location.parent.parentId > 0) {
			str += "<li onclick='getAllMarkers(\"" + location.parent.locationID
					+ "\", true)'>&nbsp;> " + location.parent.locationName
					+ " " + location.parent.locationType.locationType + "</li>"
					+ str;
		} else
			str = "<li onclick='getAllMarkers(\"" + location.parent.locationID
					+ "\", true)'>" + location.parent.locationName + "</li>"
					+ str;
		location = location.parent;
	} while (location.parent != null);
	$("#infoListView").html(str).trigger("create").listview("refresh");
}

function addMarker(l) {
	if (l.entrances != null && l.entrances.length > 0)
		for ( var int = 0; int < l.entrances.length; int++) {
			addEntrance(l.entrances[int]);
		}
	marker = new google.maps.Marker({
		icon : refreshMap(l.locationType.locationTypeId, l.gps, "normal"),
		hovericon : refreshMap(l.locationType.locationTypeId, l.gps, "hover"),
		originalicon : refreshMap(l.locationType.locationTypeId, l.gps,
				"normal"),
		draggable : true,
		zIndex : 666,
		map : map
	});
	if (l.locationType.locationTypeId != 5)
		marker.setTitle(l.locationName + " " + l.locationType.locationType);
	google.maps.event.addListener(marker, "mouseover", function() {
		this.setIcon(this.hovericon);
	});
	google.maps.event.addListener(marker, "mouseout", function() {
		this.setIcon(this.originalicon);
	});
	var pos = {
		lat : parseFloat(l.gps.split(",")[0]),
		lng : parseFloat(l.gps.split(",")[1])
	};

	marker.id = l.locationID;
	marker.setPosition(pos);
	if (l.boundary != null && l.boundary.length > 13) {
		drawPolygons(l);
		marker.setVisible(false);
	} else
		marker.setMap(map);
	marker.addListener('dragend', function(point) {
		$("#locationGPS").val(point.latLng.lat() + "," + point.latLng.lng());
		if (confirm("Are you sure you want to move the property?"))
			saveLocation();
		else
			return;
	});
	// if (l.locationType.locationTypeId != 5) {// ||
	// l.locationType.locationTypeId
	// != 3
	google.maps.event.addListener(marker, 'click', function(point) {
		$("#locationTypeId").val(l.locationType.locationTypeId);
		hideLocationInfo();
		showLocationInfo();
		setInputsForLocation(l, l.gps);
		locationEditPanelOpen(l.locationName, l.locationType.locationType);
	});
	marker.setMap(null);
	if (markers.indexOf(marker) <= 0)
		markers.push(marker);
	// }
}

function saveEntrance() {
	var url = "REST/GetLocationWS/CreateTFCEntrance?entranceId="
			+ $("#locationId").val() + "&username=NMMU&parentId="
			+ $("#parentLocationId").val()
			+ "&locationName=Entrance&coordinate=" + $("#locationGPS").val();
	$.ajax({
		url : url,
		cache : false,
		async : true,
		beforeSend : function() {
			ShowLoadingScreen("Saving Entrance");
		},
		success : function(data) {
			google.maps.event.clearInstanceListeners(map);
			closeAMenuPopup();
			$('#locationSaveCancelPanel').css('display', 'none');
			hideLocationInfo();
			addEntrance(data);
			toast('Saved Successfully');
		},
		complete : function() {
			HideLoadingScreen();
			closeAMenuPopup();
		},
		error : function(xhr, ajaxOptions, thrownError) {
			popErrorMessage("An error occured while saving the marker. "
					+ thrownError);
		},
	});
}

function addEntrance(l) {
	$("#locationGPS").val("");
	var intersectionEntrance = 5;
	if (l.entranceIntersection)
		intersectionEntrance = 11;
	var entrance = new google.maps.Marker({
		icon : refreshMap(intersectionEntrance, l.gps, "normal"),
		hovericon : refreshMap(intersectionEntrance, l.gps, "hover"),
		originalicon : refreshMap(intersectionEntrance, l.gps, "normal"),
		draggable : true,
		zIndex : 666,
		map : map
	});
	google.maps.event.addListener(entrance, "mouseover", function() {
		this.setIcon(this.hovericon);
	});
	google.maps.event.addListener(entrance, "mouseout", function() {
		this.setIcon(this.originalicon);
	});
	var pos = {
		lat : parseFloat(l.gps.split(",")[0]),
		lng : parseFloat(l.gps.split(",")[1])
	};
	entrance.id = l.entranceId;
	entrance.addListener('dragend', function(point) {
		var parentPolygon = null;
		for ( var i = 0; i < polygons.length; i++) {
			if (polygons[i].id == l.parentId)
				parentPolygon = polygons[i];
		}
		var oldPoint = {
			x : parseFloat(point.latLng.lat()),
			y : parseFloat(point.latLng.lng())
		};
		pointsInLine = [];
		$(parentPolygon.getPath().getArray()).each(function(k, l) {
			var point = {
				x : parseFloat(l.lat()),
				y : parseFloat(l.lng())
			};
			pointsInLine.push(point);
		});
		pointsInLine.push({
			x : parseFloat(parentPolygon.getPath().getArray()[0].lat()),
			y : parseFloat(parentPolygon.getPath().getArray()[0].lng())
		});
		var intersectionpoint = getClosestPointOnLines(oldPoint, pointsInLine);
		this.setPosition({
			lat : parseFloat(intersectionpoint.x),
			lng : parseFloat(intersectionpoint.y)
		});
		setTimeout(function() {
			if (confirm("Are you sure you want to move the marker?")) {
				$("#locationGPS").val(
						intersectionpoint.x + "," + intersectionpoint.y);
				$("#locationId").val(l.entranceId);
				$("#locationName").val(l.description);
				$("#parentLocationId").val(l.parentId);
				saveEntrance();
			} else {
				entrance.setPosition({
					lat : parseFloat(l.gps.split(",")[0]),
					lng : parseFloat(l.gps.split(",")[1])
				});
			}
			;
		}, 200);

	});
	entrance.setPosition(pos);
	google.maps.event.addListener(entrance, 'click', function(point) {
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			hideLocationInfo();
			showLocationInfo();
			locationEditPanelOpen(l.description, "Entrance");
		} else {
			addAPath(l);
		}
	});
	if (!pathMarkers.indexOf(entrance) <= 0) {
		pathMarkers.push(entrance);
	}
	if (!markers.indexOf(entrance) <= 0 && l.entranceIntersection) {
		markers.push(entrance);
	}

}

function setMapOnAllMarkers(value) {
	for ( var i = 0; i < markers.length; i++) {
		markers[i].setMap(value);
	}
}

function setMapOnAllPathMarkers(value) {
	for ( var i = 0; i < pathMarkers.length; i++) {
		pathMarkers[i].setMap(value);
	}
}

function setInputsForLocation(location, gps) {
	$("#upload").val("");
	$("#main-cropper").empty();
	google.maps.event.clearInstanceListeners(map);
	$("#locationName").val(location.locationName);
	$("#locationGPS").val(location.gps);
	if (location.boundary != null && location.boundary.length > 13)
		$("#boundary").val(getArrayBoundary(location.boundary));
	if (location.boundary == null) {
		$("#tempBoundaryColors").val("1E90FF,1E90FF");
		$("#boundaryColors").val("1E90FF,1E90FF");
	} else {
		$("#tempBoundaryColors").val(getBoundaryColour(location.boundary));
		$("#boundaryColors").val(getBoundaryColour(location.boundary));
	}
	$("#locationId").val(location.locationID);
	$("#croppedIcon").attr("src", location.icon);
	$("#icon").val(location.icon);
	$("#locationLabel").val(location.locationName);
	$("#locationInfoDescriptionLabel").val(location.description);
	$("#locationDescription").val(location.description);
	$("#locationThumbnail").val(location.icon);
	$("#locationTypeLabel").val(location.locationType.locationType);
	$("#locationBoundary").html(location.boundary);
	var icn = location.icon;
	if (icn != null && icn.length > 5)
		$("#editIconIcon").attr("src", location.icon);
	else
		$("#editIconIcon").attr("src", "images/icons/image.png");
	$("#parentLocationId").val(location.parentId);
	$("#locationTypeId").val(location.locationType.locationTypeId);
}

function showMarkerLabel(text, posX, posY, isPresentUnderneath) {
	$("#googleMapMarkerLabel").html(text);
	$('#googleMapMarkerLabel').css("display", "block");
	$('#googleMapMarkerLabel').css("position", "absolute").trigger("create");
	if (isPresentUnderneath) {
		$('#googleMapMarkerLabel').css("top", posY + 25 + 'px');
		if (posX - $("#googleMapMarkerLabel").width() < 0) {
			$('#googleMapMarkerLabel').css("left", '4px');
		} else if (posX + $("#googleMapMarkerLabel").width() > $(window)
				.width()) {
			// $('#googleMapMarkerLabel').css("right", '3px');
			$('#googleMapMarkerLabel').css(
					"left",
					$(window).width() - $("#googleMapMarkerLabel").width() - 22
							+ 'px');
		} else
			$('#googleMapMarkerLabel').css("left",
					posX - ($("#googleMapMarkerLabel").width() / 2) + 'px');
	} else {
		if (posY < $(window).height() / 2) {
			$('#googleMapMarkerLabel').css("top", posY + 66 + 'px');
		} else {
			$('#googleMapMarkerLabel').css("top", posY - 66 + 'px');
		}
		if (posX - ($("#googleMapMarkerLabel").width() / 2) < 0) {
			$('#googleMapMarkerLabel').css("left", '4px');
		} else if ($(window).width() - posX < $("#googleMapMarkerLabel")
				.width()) {
			// $('#googleMapMarkerLabel').css("right", '0px');
			$('#googleMapMarkerLabel').css(
					"left",
					$(window).width() - $("#googleMapMarkerLabel").width() - 22
							+ 'px');
		} else
			$('#googleMapMarkerLabel').css("left",
					posX - ($("#googleMapMarkerLabel").width() / 2) + 'px');
	}
	$('#googleMapMarkerLabel').trigger("create");
}

function clearMarkerLabel() {
	$('#googleMapMarkerLabel').css("display", "none");
}
