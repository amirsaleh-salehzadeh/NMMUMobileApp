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
				$('#insertAMarker').popup('close');
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
	var url = "REST/GetLocationWS/SaveUpdateLocation?address=&plan=&parentId="
			+ $("#parentLocationId").val() + "&locationName="
			+ $("#markerName").val() + "&coordinate="
			+ $("#markerCoordinate").val() + "&locationType="
			+ $("#locationTypeId").val() + "&locationId="
			+ $("#markerId").val() + "&userName=NMMU" + "&description="
			+ $("#locationDescription").val() + "&boundary="
			+ $("#boundary").val() + "&icon=" + $("#icon").val();
	$.ajax({
		url : url,
		cache : false,
		async : true,
		beforeSend : function() {
			ShowLoadingScreen(loadingContent);
		},
		success : function(data) {
			addMarker(data);
			$("#markerId").val(data.locationID);
		},
		complete : function() {
			HideLoadingScreen();
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
			alert("saveMarker");
		},
	});
	if (!$('#insertAMarker').parent().hasClass('ui-popup-hidden')) {
		$('#insertAMarker').popup('close');
		$('#insertAMarker').popup("destroy");
		return -1;
	}
}

function getAllMarkers() {
	var url = "REST/GetLocationWS/GetAllLocationsForUser?parentLocationId=0&locationTypeId=3,5&userName=NMMU";
	setMapOnAllMarkers(null);
	$.ajax({
		url : url,
		cache : false,
		async : true,
		beforeSend : function() {
			ShowLoadingScreen(loadingContent);
		},
		success : function(data) {
			$.each(data, function(k, l) {
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

function addMarker(l) {
	var pos = {
		lat : parseFloat(l.gps.split(",")[0]),
		lng : parseFloat(l.gps.split(",")[1])
	};
	marker = new google.maps.Marker({
		map : map,
		icon : refreshMap(l.locationType.locationTypeId, l.gps),
		animation : google.maps.Animation.DROP,
		draggable : true,
		title : l.locationName
	});
	marker.id = l.locationID;
	google.maps.event.addListener(marker, 'click', function(point) {
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			addAMarker(l, l.gps);
		} else {
			addAPath(l, l.gps);
		}
	});
	marker.addListener('dragend', function(point) {
		if (confirm("Are you sure you want to move the marker?")) {
			$("#markerCoordinate").val(
					point.latLng.lat() + "," + point.latLng.lng());
			$("#markerId").val(l.locationID);
			$("#parentLocationId").val(l.parentId);
			$("#markerName").val(l.locationName);
			$("#locationTypeId").val(l.locationType.locationTypeId);
			$("#locationDescription").val(l.description);
			setLocationTypeCreate();

			saveMarker();
		} else {
			this.setPosition(pos);
		}
		getAllPaths();
	});
	marker.setPosition(pos);
	markers.push(marker);
}

function setMapOnAllMarkers(map) {
	for ( var i = 0; i < markers.length; i++) {
		markers[i].setMap(map);
	}
}

function openMarkerPopup(edit) {
	if (!edit
			&& (parseInt($("#locationTypeId").val()) <= 1 || $(
					"#parentLocationId").val() == "0")) {
		alert("Please select the marker type (at the top menu) and parent location (at the right side menu) first.");
		return;
	}
	$('#insertAMarker').popup().trigger('create');
	$('#insertAMarker').popup('open').trigger('create');
}

function addAMarker(location, gps) {
	gps = gps.replace(" ", "");
	var edit = true;
	if (location == null) {
		edit = false;
		$("#markerId").val("");
		$("#markerName").val("");
		$("#markerCoordinate").val(gps);
	} else {
		$("#markerId").val(location.locationID);
		$("#markerName").val(location.locationName);
		$("#markerCoordinate").val(gps);
		$("#markerLabel").html(location.locationType.locationType);
		$("#locationDescription").val(location.description);
		$("#locationTypeId").val(location.locationType.locationTypeId);
	}
	openMarkerPopup(edit);
}

function selectALocationTypeToAdd(locationTypeId) {
	$("#locationTypeId").val(locationTypeId);
	if (locationTypeId == 3) {
		$("#locationTypeToAdd").html("Adding Building on");
	}
	if (locationTypeId == 5) {
		$("#locationTypeToAdd").html("Adding Intersection on");
	}
}