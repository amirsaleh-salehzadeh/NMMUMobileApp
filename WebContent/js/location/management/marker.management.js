var pathMarkers = [];
function removeMarker() {
	var url = "REST/GetLocationWS/RemoveALocation?locationId="
			+ $("#markerId").val();
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
				deleteMarker($("#markerId").val());
			},
			complete : function() {
				HideLoadingScreen();
			},
			error : function(xhr, ajaxOptions, thrownError) {
				popErrorMessage("An error occured while removing the marker. "+ thrownError);
			}
		});
}

function deleteMarker(id) {
	var i = markers.indexOf(id);
	markers[i].setMap(null);
	markers.splice(i, 1);
	return;
}

function saveMarker() {
	var loadingContent;
	if ($("#locationTypeId").val() == 3) {
		loadingContent = "Saving Building";
	} else {
		loadingContent = "Saving Intersection";
	}
	if ($("#markerName").val() == "") {
		alert("Please select a name for the location");
		return;
	}
	var url = "REST/GetLocationWS/SaveUpdateLocation";
	$("#boundary").val(
			$("#boundary").val() + ";" + $("#tempBoundaryColors").val());
	$("#boundaryColors").val($("#tempBoundaryColors").val());
	$.ajax({
		url : url,
		cache : false,
		async : true,
		dataType : 'text',
		type : 'POST',
		data : {
			icon : $("#icon").val(),
			locationName : $("#markerName").val(),
			parentId : $("#parentLocationId").val(),
			coordinate : $("#locationGPS").val(),
			locationTypeId : $("#locationTypeId").val(),
			locationId : $("#markerId").val(),
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
			$("#markerId").val(data.locationID);
			addMarker(data);
			toast('Saved Successfully');
		},
		complete : function() {
			HideLoadingScreen();
			closeAMenuPopup();
		},
		error : function(xhr, ajaxOptions, thrownError) {
			popErrorMessage("An error occured while saving the marker. "+ thrownError);
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
	if (!refreshMarkers && markers.length > 0) {
		setMapOnAllMarkers(map);
		setMapOnAllPathMarkers(null);
		$("input[name='radio-choice']").checkboxradio('enable');
		return;
	}
	$.ajax({
		url : url,
		cache : false,
		async : true,
		beforeSend : function() {
			ShowLoadingScreen("Fetching locations");
			setMapOnAllMarkers(null);
			setMapOnAllPolygons(null);
			setMapOnAllPathMarkers(null);
		},
		success : function(data) {
			str = "";
			markers = [];
			polygons = [];
			pathMarkers = [];
			paths = [];
			$.each(data,
					function(k, l) {
						if (k == 0) {
							getMarkerInfo(l);
							getParentLocationTypeId(null,
									l.locationType.locationTypeId);
							getLocationTypeDropDown(null);
						}
						addMarker(l);
					});
		},
		complete : function() {
			HideLoadingScreen();
			setMapOnAllPathMarkers(null);
			$("input[name='radio-choice']").checkboxradio('enable');
		},
		error : function(xhr, ajaxOptions, thrownError) {
			$("input[name='radio-choice']").checkboxradio('enable');
			popErrorMessage("An error occured while fetching the markers from the server. "+ thrownError);
		}
	});
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
	if (l.locationType.locationTypeId != 5)
		marker = new google.maps.Marker({
			icon : refreshMap(l.locationType.locationTypeId, l.gps, "normal"),
			hovericon : refreshMap(l.locationType.locationTypeId, l.gps,
					"hover"),
			originalicon : refreshMap(l.locationType.locationTypeId, l.gps,
					"normal"),
			draggable : true,
			title : l.locationName + " " + l.locationType.locationType,
			zIndex : 666
		});
	else
		marker = new google.maps.Marker({
			icon : refreshMap(l.locationType.locationTypeId, l.gps, "normal"),
			hovericon : refreshMap(l.locationType.locationTypeId, l.gps,
					"hover"),
			originalicon : refreshMap(l.locationType.locationTypeId, l.gps,
					"normal"),
			draggable : true,
			zIndex : 666,
		});
	google.maps.event.addListener(marker, "mouseover", function() {
		this.setIcon(this.hovericon);
	});
	google.maps.event.addListener(marker, "mouseout", function() {
		this.setIcon(this.originalicon);
	});
	marker.setLabel(null);
	var pos = {
		lat : parseFloat(l.gps.split(",")[0]),
		lng : parseFloat(l.gps.split(",")[1])
	};

	marker.id = l.locationID;
	google.maps.event.addListener(marker, 'click', function(point) {
		$("#locationTypeId").val(l.locationType.locationTypeId);
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			showLocationInfo();
			addAMarker(l, l.gps);
		} else {
			addAPath(l);
		}
	});
	marker.addListener('dragend', function(point) {
		$("#locationTypeId").val(l.locationType.locationTypeId);
		if (confirm("Are you sure you want to move the marker?")) {
			$("#locationGPS").val(
					point.latLng.lat() + "," + point.latLng.lng());
			$("#markerId").val(l.locationID);
			$("#parentLocationId").val(l.parentId);
			$("#markerName").val(l.locationName);
			$("#locationTypeId").val(l.locationType.locationTypeId);
			$("#locationDescription").val(l.description);
			saveMarker();
		} else {
			this.setPosition(pos);
		}
	});
	marker.setPosition(pos);
	if (l.boundary != null && l.boundary.length > 2) {
		drawPolygons(l);
		marker.setVisible(false);
	} else
		marker.setMap(map);
	if (l.locationType.locationTypeId == 11) {
		markers.push(marker);
		pathMarkers.push(marker);
	} else if (l.locationType.locationTypeId != 5 && l.locationType.locationTypeId != 11)
		markers.push(marker);
	else {
		marker.setMap(null);
		pathMarkers.push(marker);
	}
}

function setMapOnAllMarkers(map) {
	for ( var i = 0; i < markers.length; i++) {
		markers[i].setMap(map);
	}
}

function setMapOnAllPathMarkers(map) {
	for ( var i = 0; i < pathMarkers.length; i++) {
		pathMarkers[i].setMap(map);
	}
}

function addAMarker(location, gps) {
	$("#upload").val("");
	$("#main-cropper").empty();
	// $("#iconCropDiv").empty();
	google.maps.event.clearInstanceListeners(map);
	if (location == null) {
		gps = gps.replace(" ", "");
		$("#markerId").val("");
		$("#markerName").val("");
		$("#locationGPS").val(gps);
		$("#boundary").val("");
		$("#locationDescription").val("");
	} else {
		$("#markerName").val(location.locationName);
		$("#locationGPS").val(location.gps);
		$("#boundary").val(getArrayBoundary(location.boundary));
		if (getBoundaryColour(location.boundary) == "") {
			$("#tempBoundaryColors").val("1E90FF,1E90FF");
			$("#boundaryColors").val("1E90FF,1E90FF");
		} else {
			$("#tempBoundaryColors").val(getBoundaryColour(location.boundary));
			$("#boundaryColors").val(getBoundaryColour(location.boundary));
		}
		$("#markerId").val(location.locationID);
		$("#croppedIcon").attr("src", location.icon);
		$("#icon").val(location.icon);
		$("#locationLabel").val(location.locationName);
		$("#locationInfoDescriptionLabel").val(location.description);
		$("#locationThumbnail").val(location.icon);
		$("#locationTypeLabel").val(location.locationType.locationType);
		$("#locationBoundary").html(location.boundary);
		var icn = location.icon;
		if (icn != null && icn.length > 5)
			$("#editIconIcon").attr("src", location.icon);
		else
			$("#editIconIcon").attr("src", "images/icons/image.png");
		$("#parentLocationId").val(location.parentId);
		$("#locationDescription").val(location.description);
		$("#locationTypeId").val(location.locationType.locationTypeId);
		locationEditPanelOpen(location.locationName,
				location.locationType.locationType);
	}
}
function showMarkerLabel(name) {
	$("#googleMapMarkerLabel").html(name);
	$('#googleMapMarkerLabel').css("display", "block");
	$('#googleMapMarkerLabel').css("position", "absolute");
	$('#googleMapMarkerLabel').css("left", event.pageX + 17 + 'px');
	$('#googleMapMarkerLabel').css("top", event.pageY + 17 + 'px');
	$('#googleMapMarkerLabel').trigger("create");
	// $('#googleMapMarkerLabel').fadeIn();
}
function clearMarkerLabel() {
	$('#googleMapMarkerLabel').css("display", "none");
}
