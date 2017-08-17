var locationTypeJSONData;
var markers = [];
function getLocationTypePanel() {
	var url = "REST/GetLocationWS/SearchForALocation?userName=NMMU"
			+ "&locationType=Building&locationName=";
	$.ajax({
		url : url,
		cache : true,
		async : true,
		success : function(data) {
			var str = '';
			$.each(data, function(k, l) {
				str += "<li id='" + l.locationID + "_" + l.gps + "_"
						+ l.locationType.locationType
						+ "' onclick='selectDestination(this, \""
						+ l.locationType.locationType + " " + l.locationName
						+ "\")' data-icon='false'>"
						+ '<a href="#" class="resultsListViewContent">';
				var src = "images/map-markers/building.png";
				if (l.icon != null)
					src = l.icon;
				str += '<img src="' + src + '" class="listViewIcons"><h2>'
						+ l.locationType.locationType + " " + l.locationName
						+ '</h2><p>';
				var desc = "&nbsp;";
				if (l.description != null)
					desc = l.description;
				str += desc + '</p></a></li>';
			});
			$("ul#resultsListView").html(str);
			$("ul#resultsListView").listview();
			$("ul#resultsListView").listview('refresh').trigger('create');
		},
		error : function(xhr, ajaxOptions, thrownError) {
			errorMessagePopupOpen(thrownError);
		}
	});

}
function selectDestination(destination, content) {
	if ($("#destinationNameHeader").length > 0)
		if ($("#destinationNameHeader").html() == "To " + content) {
			$("#popupSearchResult")
					.popup(
							{
								afterclose : function(event, ui) {
									errorMessagePopupOpen(content
											+ " has been already selected as the Departure");
									$("#popupSearchResult").popup({
										afterclose : function(event, ui) {
										}
									});
								}
							});
			blurFalse();
			$('#popupSearchResult').popup('close');
			$("#popupErrorMessage").popup({
				afterclose : function(event, ui) {
					searchResultPopupOpen('From?');
					$("#popupErrorMessage").popup({
						afterclose : function(event, ui) {
						}
					});
				}
			});
			return;
		}
	var departure = false;
	if ($("#searchPopupHeader").html().indexOf("rom") > 0)
		departure = true;
	var bounds = new google.maps.LatLngBounds();
	if (departure) {
		$("#from")
				.val($(destination).attr("id").split("_")[1].replace(" ", ""));
		$("#departureId").val($(destination).attr("id").split("_")[0]);
		$("#departureDescriptionInput").val(content);
		var departPoint = getGoogleMapPosition($("#from").val());
		if (markerDepart != null)
			markerDepart.setMap(null);
		markerDepart = new google.maps.Marker({
			position : departPoint,
			map : map,
			icon : 'images/map-markers/marker-green.png'
		});
		// markerDepart.addListener('click', function() {
		// selectDestination(destination);
		// });
		// initiateNavigation();
		bounds.extend(markerDest.getPosition());
		bounds.extend(markerDepart.getPosition());
		map.fitBounds(bounds);
		getThePath();
	} else {
		$("#destinationName").html(content);
		$(".spinnerLoading").css('display', 'none');
		$("#locationInf").html($(destination).html()).trigger("create");
		$("#locationInf a").removeClass("resultsListViewContent");
		// $("#locationInf a").addClass("bottomPanelLocationContent");
		$("#locationInf a img").removeClass("listViewIcons");
		// $("#locationInf a img").addClass("bottomPanelLocationIcon");
		// $("#locationInf a p").removeClass("listViewIcons");
		// $("#locationInf a p").addClass("bottomPanelLocationIcon");
		// $("#locationInf a h2").removeClass("listViewIcons");
		// $("#locationInf a h2").addClass("bottomPanelLocationIcon");
		showBottomPanel();
		$("#to").val($(destination).attr("id").split("_")[1].replace(" ", ""));
		$("#destinationId").val($(destination).attr("id").split("_")[0]);
		var destPoint = getGoogleMapPosition($("#to").val());
		if (markerDest != null)
			markerDest.setMap(null);
		markerDest = new google.maps.Marker({
			position : destPoint,
			map : map,
			icon : 'images/map-markers/marker-orange.png'
		});
		markerDest.addListener('click', function() {
			selectDestination(destination);
		});
		map.panTo(markerDest.getPosition());
		blurFalse();
	}
	$('#popupSearchResult').popup('close');
}

function getDirectionFromCurrentLocation() {
	$("#departureId").val("");
	$("#departureDescriptionInput").val("Current Location");
	findMyLocation();
	// showBottomPanel();
	// blurFalse();
	$("#locationInf").html('');
	do {
		$(".spinnerLoading").css('display', 'block');
	} while ($("#from").val().length < 2);
	// $(".spinnerLoading").css('display', 'none');
	// hideBottomPanel();
	getThePath();
}

function clearSearchBTN() {
	$("#destinationName").html("Find a Place");
	if ($("#locationInfoDiv").css('display') != 'none')
		hideBottomPanel();
}

function searchFieldDivClearBTN() {
	$("#searchField").val("");
	$("#resultsListView").listview("refresh");
}
function blurTrue() {
	if (!($('#map_canvas').hasClass('off'))) {
		$('#map_canvas').toggleClass('off');
	}
}
function blurFalse() {
	if ($('#map_canvas').hasClass('off')) {
		$('#map_canvas').toggleClass('off');
	}
}
