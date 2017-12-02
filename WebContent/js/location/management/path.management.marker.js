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
				alert(xhr.status);
				alert(thrownError);
				alert("getAllMarkers");
			}
		});
}

function deleteMarker(id) {
	for ( var i = 0; i < markers.length; i++) {
		if (markers[i].id == id) {
			markers[i].setMap(null);
			markers.splice(i, 1);
			return;
		}
	}
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
	// $("#locationTypeId").val($("#locationType").val());
	var url = "REST/GetLocationWS/SaveUpdateLocation";
	$("#boundary").val(
			$("#boundary").val() + ";" + $("#tempBoundaryColors").val()); // boundary
																			// mow
																			// has
																			// boundary
																			// plus
																			// colours
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
			coordinate : $("#markerCoordinate").val(),
			locationTypeId : $("#locationTypeId").val(),
			locationId : $("#markerId").val(),
			description : $("#locationDescription").val(),
			address : "",
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
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
			alert(ajaxOptions);
			HideLoadingScreen();
			alert("saveMarker");
		},
	});
}

var str = "";
function getAllMarkers(parentId) {
	$("#closeLocationEditMenu").trigger("click");
	var url = "REST/GetLocationWS/GetAllLocationsForUser?parentLocationId="
			+ parentId + "&locationTypeId=&userName=NMMU";
	setMapOnAllMarkers(null);
	setMapOnAllpoligons(null);
	$.ajax({
		url : url,
		cache : false,
		async : true,
		beforeSend : function() {
			ShowLoadingScreen("Fetching locations");
		},
		success : function(data) {
			str = "";
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
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
			alert("getAllMarkers");
		}
	});
}

function getMarkerInfo(location) {
	do {
		if (location.parent.parentId > 0) {
			str = "<li onclick='getAllMarkers(\"" + location.parent.locationID
					+ "\",)'> > " + location.parent.locationName + " "
					+ location.parent.locationType.locationType + "</li>" + str;
		} else
			str = "<li onclick='getAllMarkers(\"" + location.parent.locationID
					+ "\")'>" + location.parent.locationName + "</li>" + str;
		location = location.parent;
	} while (location.parent != null);
	$("#infoListView").html(str).trigger("create").listview("refresh");
}

function addMarker(l) {
	if (l.boundary != null && l.boundary.length > 2) {
		drawPolygons(l);
	}
	if (l.locationType.locationTypeId != 5)
		marker = new google.maps.Marker({
			map : map,
			icon : refreshMap(l.locationType.locationTypeId, l.gps, "normal"),
			hovericon : refreshMap(l.locationType.locationTypeId, l.gps,
					"hover"),
			originalicon : refreshMap(l.locationType.locationTypeId, l.gps,
					"normal"),
			animation : google.maps.Animation.DROP,
			draggable : true,
			labelContent : l.locationName + " " + l.locationType.locationType,
			labelAnchor : new google.maps.Point(30, 20),
			labelClass : "labels", // the CSS class for the label
			labelStyle : {
				opacity : 1.0
			},
			label : l.locationName,
			zIndex : 40
		});
	else
		marker = new google.maps.Marker({
			map : map,
			icon : refreshMap(l.locationType.locationTypeId, l.gps, "normal"),
			hovericon : refreshMap(l.locationType.locationTypeId, l.gps,
					"hover"),
			originalicon : refreshMap(l.locationType.locationTypeId, l.gps,
					"normal"),
			animation : google.maps.Animation.DROP,
			draggable : true,
			labelContent : l.locationName + " " + l.locationType.locationType,
			labelAnchor : new google.maps.Point(30, 20),
			labelClass : "labels", // the CSS class for the label
			labelStyle : {
				opacity : 1.0
			},
			title : l.locationName,
			zIndex : 40
		});
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
	google.maps.event.addListener(marker, 'click', function(point) {
		$("#locationTypeId").val(l.locationType.locationTypeId);
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			addAMarker(l, l.gps);
		} else {
			addAPath(l, l.gps);
		}
	});
	marker.addListener('dragend', function(point) {
		$("#locationTypeId").val(l.locationType.locationTypeId);
		if (confirm("Are you sure you want to move the marker?")) {
			$("#markerCoordinate").val(
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
	markers.push(marker);
}

function setMapOnAllMarkers(map) {
	for ( var i = 0; i < markers.length; i++) {
		markers[i].setMap(map);
	}
}

function addAMarker(location, gps) {
	$("#upload").val("");
	$("#main-cropper").empty();
	// $("#iconCropDiv").empty();
	if (location == null) {
		gps = gps.replace(" ", "");
		$("#markerId").val("");
		$("#markerName").val("");
		$("#markerCoordinate").val(gps);
		$("#locationDescription").val("");
		$("#openLocationEditMenu")
				.html(
						"<img width='24' height='24' src='images/icons/add.png' class=''>NEW")
				.trigger("create");
	} else {

		$("#markerName").val(location.locationName);
		$("#markerCoordinate").val(location.gps);
		$("#boundary").val(getArrayBoundary(location.boundary));
		$("#tempBoundaryColors").val(getBoundaryColour(location.boundary));
		$("#markerId").val(location.locationID);
		$("#croppedIcon").attr("src", location.icon);
		$("#icon").val(location.icon);
		var icn = location.icon;
		if (icn != null && icn.length > 5)
			$("#editIconIcon").attr("src", location.icon);
		else
			$("#editIconIcon").attr("src", "images/icons/image.png");
		$("#parentLocationId").val(location.parentId);
		$("#locationDescription").val(location.description);
		$("#locationTypeId").val(location.locationType.locationTypeId);
		$("#openLocationEditMenu")
				.html(
						"<img width='24' height='24' src='images/icons/edit.png' class=''>EDIT")
				.trigger("create");
	}
	showHideSettingsMenu();
}
