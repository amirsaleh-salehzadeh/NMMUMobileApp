function removeMarker() {
	var url = "REST/GetLocationWS/RemoveALocation?locationId="
			+ $("#markerId").val();
	if (confirm('Are you sure you want to remove this location?'))
		$.ajax({
			url : url,
			cache : false,
			success : function(data) {
				$('#insertAMarker').popup('close');
				if (data.errorMSG != null) {
					alert(data.errorMSG);
					return;
				}
				getAllMarkers();
			},
			error : function(xhr, ajaxOptions, thrownError) {
				alert(xhr.status);
				alert(thrownError);
			}
		});
}

function saveMarker() {
	if ($("#markerName").val() == "") {
		alert("Please select a name for the location");
		return;
	}
	var url = "REST/GetLocationWS/SaveUpdateLocation?parentId="
			+ $("#parentLocationId").val() + "&locationName="
			+ $("#markerName").val() + "&coordinate="
			+ $("#markerCoordinate").val() + "&locationType="
			+ $("#locationTypeId").val() + "&locationId="
			+ $("#markerId").val() + "&userName=NMMU"
			+ "&boundary=" + $("#boundary").val();
	$.ajax({
		url : url,
		cache : false,
		async : false,
		success : function(data) {
			marker = new google.maps.Marker({
				position : {
					lat : parseFloat(data.gps.split(",")[0]),
					lng : parseFloat(data.gps.split(",")[1])
				},
				map : map,
				icon : refreshMap(data.locationType.locationTypeId, data.gps),
				title : data.locationName
			});
			var bounds = new google.maps.LatLngBounds();
			bounds.extend(marker.getPosition());
			marker.addListener('click', function() {
				if ($('[name="optionType"] :radio:checked').val() == "marker") {
					addAMarker(data, data.gps);
				} else {
					addAPath(data, data.gps);
				}
			});
			markers.push(marker);
			$("#markerId").val(data.locationID);
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});
	if (!$('#insertAMarker').parent().hasClass('ui-popup-hidden')) {
		$('#insertAMarker').popup('close');
		$('#insertAMarker').popup("destroy");
		return (-1);
	}
	;
}

function getAllMarkers() {
	 var url = "REST/GetLocationWS/GetAllLocationsForUser?parentLocationId="
	 + $("#parentLocationId").val() + "&locationTypeId=2,3,5&userName=NMMU";
//	var url = "REST/GetLocationWS/GetAllLocationsForUser?parentLocationId="
//			+ $("#parentLocationId").val() + "&userName=NMMU";
	for ( var i = 0; i < markers.length; i++) {
		markers[i].setMap(null);
	}
	$.ajax({
		url : url,
		cache : false,
		async : true,
		success : function(data) {
			var str = "";
			$
					.each(
							data,
							function(k, l) {
								if (parseInt(l.locationType.locationTypeId) >= parseInt($(
										"#locationTypeId").val()))
									str += '<a href="#" id="'
											+ l.locationID
											+ "_"
											+ l.gps
											+ "_"
											+ l.locationType.locationTypeId
											+ '" data-mini="true" onclick="selectParent(this)" class="ui-btn parentLocationList">'
											+ l.locationName + '</a>';
								var pos = {
									lat : parseFloat(l.gps.split(",")[0]),
									lng : parseFloat(l.gps.split(",")[1])
								};
								marker = new google.maps.Marker(
										{
											map : map,
											icon : refreshMap(
													l.locationType.locationTypeId,
													l.gps),
											animation : google.maps.Animation.DROP,
											draggable : true,
											title : l.locationName

										});
								google.maps.event
										.addListener(
												marker,
												'click',
												function(point) {

													if ($(
															'[name="optionType"] :radio:checked')
															.val() == "marker") {
														addAMarker(l,
																l.gps);
													} else {
														addAPath(l,
																l.gps);
													}
//													map.setCenter(pos);
//													map.setZoom(17);
												});
								marker
										.addListener(
												'dragend',
												function(point) {
													if (confirm("Are you sure you want to move the marker?")) {
														$(
																"#markerCoordinate")
																.val(
																		point.latLng
																				.lat()
																				+ ","
																				+ point.latLng
																						.lng());
														$("#markerId")
																.val(
																		l.locationID);
														$(
																"#parentLocationId")
																.val(
																		l.parentId);
														$("#markerName")
																.val(
																		l.locationName);
														$(
																"#locationTypeId")
																.val(
																		l.locationType.locationTypeId);
														setLocationTypeCreate();
														saveMarker();
													} else {
														this
																.setPosition(pos);
													}
													getAllPaths();
												});
								marker.setPosition(pos);
								markers.push(marker);
							});
			$('#parentLocationListView').html(str);
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});
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
		$("#markerLabel").html();
	} else {
		$("#markerId").val(location.locationID);
		$("#markerName").val(location.locationName);
		$("#markerCoordinate").val(gps);
		$("#markerLabel").html(location.locationType.locationType);
	}
	openMarkerPopup(edit);
}