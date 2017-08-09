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
						+ "' onclick='selectDestination(this, \"" + l.locationName
						+ "\")' data-icon='false'>"
						+ '<a href="#" class="resultsListViewContent">';
				var src = "images/map-markers/building.png";
				if (l.icon != null)
					src = l.icon;
				str += '<img src="' + src + '" class="listViewIcons"><h2>'
						+ l.locationName + '</h2><p>';
				var desc = "&nbsp;";
				if(l.description != null)
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

var childData;
function getMyChild(select) {
	if (childData == null)
		childData = locationTypeJSONData;
	else if (childData.children == null)
		return;
	var listAdd = "";
	$.each(childData.children, function(k, l) {
		listAdd = '<div data-role="collapsible" data-filtertext="'
				+ l.locationType + '">';
		listAdd += '<h3>' + l.locationType + '</h3>';
		listAdd += '<ul data-role="listview" data-inset="false" id="'
				+ l.locationTypeId + '" class="locationTypes"></ul></div>';
	});

	// $("#autocompleteDestination").listview("refresh");
	// } else
	$.each(childData.children, function(k, l) {
		childData = l;
		getMyChild(l.locationTypeId);
	});
}

function selectDestination(destination, content) {
	$("#destinationId").val($(destination).attr("id").split("_")[0]);
	$("#destinationName").html(content);
	$(".spinnerLoading").css('display', 'none');
	// $("#locationInf").html($(destination).html());
	$("#locationInf").html(content);
	$("#locationInfoDiv").css('display', 'block');
	$("#locationInfoDiv").animate({
		bottom : "0"
	}, 1500);
	$("#zoomSettings").animate({
		bottom : $("#locationInfoDiv").height()
	}, 1500);
	$("#to").val($(destination).attr("id").split("_")[1].replace(" ", ""));
	var destPoint = getGoogleMapPosition($("#to").val());
	if (markerDest != null)
		markerDest.setMap(null);
	markerDest = new google.maps.Marker({
		position : destPoint,
		map : map,
		icon : 'images/icons/finish.png'
	});
	markerDest.addListener('click', function() {
		// infowindowDestination.open(map, markerDest);
		selectDestination(destination);
	});

	map.panTo(markerDest.getPosition());
	$('#popupSearchResult').popup('close');
	$('#map_canvas').toggleClass('off');
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
		cache : true,
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
					selectDestination();
				});
				markerTMP.setMap(map);
				markers.push(markerTMP);
			});
		},
		error : function(xhr, ajaxOptions, thrownError) {
			errorMessagePopupOpen(thrownError);
		}
	});

}