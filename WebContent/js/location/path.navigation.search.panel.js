var locationTypeJSONData;
var markers = [];
function getLocationTypePanel() {
	if (markers != undefined)
		for ( var i = 0; i < markers.length; i++) {
			markers[i].setMap(null);
		}
	var url = "REST/GetLocationWS/GetAllLocationTypes";
	$
			.ajax({
				url : url,
				cache : true,
				async : true,
				success : function(data) {
					locationTypeJSONData = data;
					var listAdd = '<li data-role="collapsible" data-mini="true" data-collapsed="false" data-iconpos="right" data-inset="true">';
					listAdd += '<h2>' + data.locationType + '</h2>';
					listAdd += '<ul data-role="listview" id="'
							+ data.locationTypeId
							+ '" class="locationTypes" data-filter="true" data-filter-reveal="true" data-input="#destinationName"></ul></li>';
					$("#autocompleteDestination").append(listAdd);
					$("#autocompleteDestination").listview();
					$("#autocompleteDestination").listview("refresh");
					$("#" + data.locationTypeId).listview();
					$("#" + data.locationTypeId).listview("refresh");
					getMyChild(data.locationTypeId);
					$('li[data-role=collapsible]').collapsible();
					url = "REST/GetLocationWS/SearchForALocation?userName=NMMU"
							+ "&locationType=Campus&locationName=";
					$
							.ajax({
								url : url,
								cache : true,
								async : true,
								success : function(data) {
									$
											.each(
													data,
													function(k, l) {
														var markerTMP = new google.maps.Marker(
																{
																	position : {
																		lat : parseFloat(l.gps
																				.split(",")[0]),
																		lng : parseFloat(l.gps
																				.split(",")[1])
																	},
																	icon : 'images/map-markers/marker-green.png',
																	title : l.locationName
																});
														markerTMP.setMap(map);
														google.maps.event
																.addListener(
																		markerTMP,
																		'click',
																		function() {
																			getCampusMarkers(l.locationID);
																		});
														markers.push(markerTMP);
														var str = "";
														str += "<li id='"
																+ l.locationID
																+ "_"
																+ l.gps
																+ "' onclick='getCampusMarkers("
																+ l.locationID
																+ ")'>"
																+ l.locationName
																+ "</li>";

														$(
																"#"
																		+ l.locationType.locationTypeId)
																.append(str);
														$(
																"#"
																		+ l.locationType.locationTypeId)
																.listview();
														$(
																"#"
																		+ l.locationType.locationTypeId)
																.listview(
																		"refresh");
														$(
																"#autocompleteDestination")
																.listview(
																		"refresh");
													});

								},
								error : function(xhr, ajaxOptions, thrownError) {
									alert(xhr.status);
									alert(thrownError);
								}
							});

					url = "REST/GetLocationWS/SearchForALocation?userName=NMMU"
							+ "&locationType=Building&locationName=";
					$
							.ajax({
								url : url,
								cache : true,
								async : true,
								success : function(data) {
									$
											.each(
													data,
													function(k, l) {

														var str = "";
														str += "<li id='"
																+ l.locationID
																+ "_"
																+ l.gps
																+ "' onclick='selectDestination(this)'>"
																+ l.locationName
																+ "</li>";

														$(
																"#"
																		+ l.locationType.locationTypeId)
																.append(str);
														$(
																"#"
																		+ l.locationType.locationTypeId)
																.listview();
														$(
																"#"
																		+ l.locationType.locationTypeId)
																.listview(
																		"refresh");
														$(
																"#autocompleteDestination")
																.listview(
																		"refresh");
													});

								},
								error : function(xhr, ajaxOptions, thrownError) {
									alert(xhr.status);
									alert(thrownError);
								}
							});

					$("div#searchBarDiv").on("swipe", openCloseSearch);
				}
			});

}

var childData;
function getMyChild(select) {
	if (childData == null)
		childData = locationTypeJSONData;
	else if (childData.children == null)
		return;
	var listAdd = "";
	$
			.each(
					childData.children,
					function(k, l) {
						listAdd += '<li data-role="collapsible" data-mini="true" data-collapsed="false" data-iconpos="right" data-inset="true" >';
						listAdd += '<h2>' + l.locationType + '</h2>';
						listAdd += '<ul data-role="listview" data-filter-reveal="true" id="'
								+ l.locationTypeId
								+ '" class="locationTypes" data-filter="true" data-input="#destinationName"></ul></li>';
					});

	$("#autocompleteDestination").append(listAdd);
	$("#autocompleteDestination").listview("refresh");
	// } else
	$.each(childData.children, function(k, l) {
		console.log(l.locationTypeId);
		childData = l;
		getMyChild(l.locationTypeId);
	});
}

function selectDestination(destination) {
	$("#destinationId").val($(destination).attr("id").split("_")[0]);
	$("#destinationName").val($(destination).html());
	$("#to").val($(destination).attr("id").split("_")[1].replace(" ", ""));
	var destPoint = getGoogleMapPosition($("#to").val());
	if (markerDest != null)
		markerDest.setMap(null);
	markerDest = new google.maps.Marker({
		position : destPoint,
		map : map,
		icon : 'images/icons/finish.png'
	});
	 var content = '<div id="iw-container">' +
     '<div class="iw-content">' +
       '<button class="navbtn" id="start" onclick="initiateNavigation()">Direct me</button>'+
     '</div>' +
   '</div>';
	var infowindowDestination = new google.maps.InfoWindow({
		content : content,
	    maxWidth: 111
	});
	infowindowDestination.open(map, markerDest);
	var bounds = new google.maps.LatLngBounds();
	bounds.extend(markerDest.getPosition());
	bounds.extend(marker.getPosition());
	map.fitBounds(bounds);
	// initiateNavigation();
	// openCloseSearch();
	$("#autocompleteContainer").hide();
}

$("#destinationName").keyup(
		function() {
			$("#autocompleteContainer").show();
			if ($(this).val() == '') {
				$("ul:jqmData(role='listview')").children().addClass(
						'ui-screen-hidden');
			}
		});

function getCampusMarkers(locationId) {
	var url = "REST/GetLocationWS/GetAllLocationsForUser?parentLocationId="
			+ locationId + "&userName=NMMU";
	for ( var i = 0; i < markers.length; i++) {
		markers[i].setMap(null);
	}
	$.ajax({
		url : url,
		cache : false,
		async : true,
		success : function(data) {

			$.each(data, function(k, l) {
				var markerTMP = new google.maps.Marker({
					position : {
						lat : parseFloat(l.gps.split(",")[0]),
						lng : parseFloat(l.gps.split(",")[1])
					},
					icon : 'images/map-markers/building.png',
					title : l.locationName
				});
				google.maps.event.addListener(markerTMP, 'click', function() {
					selectDestination(this.markerTMP);
				});
				markerTMP.setMap(map);
				markers.push(markerTMP);
			});
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});

}