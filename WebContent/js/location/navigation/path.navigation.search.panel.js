var locationTypeJSONData;
var markers = [];
function getLocationTypePanel() {
	var url = "REST/GetLocationWS/SearchForALocation?userName=NMMU&locationType=Building&locationName=";
	$.ajax({
		url : url,
		cache : true,
		async : false,
		success : function(data) {
			// $.each(data, function(p, z) {
			$.each(data.childrenENT, function(k, l) {
				var children = l.childrenENT;
				var col = $("<div/>", {
					"data-role" : "collapsible",
					"data-collapsed" : true,
					"class" : "parentCollapsibleLV",
					"data-icon" : false
				});
				var title = $("<h3/>", {
					text : l.locationName + " Campus"
				}).appendTo(col);
				var list_items = '';
				$.each(children, function(x, y) {
					list_items += "<li id='" + y.locationID + "_" + y.gps + "_"
							+ y.locationType.locationType
							+ "' onclick='selectDestination(this, \""
							+ y.locationType.locationType + " "
							+ y.locationName + "\")' data-icon='false'>"
							+ "<a href='#' class='resultsListViewContent'>";
					var src = "images/map-markers/building.png";
					if (y.icon != null)
						src = y.icon;
					list_items += "<img src='" + src
							+ "' class='listViewIcons'><h2>"
							+ y.locationType.locationType + " "
							+ y.locationName + "</h2><p>";
					var desc = "&nbsp;";
					if (y.description != null)
						desc = y.description;
					list_items += desc + "</p></a></li>";
				});
				var list = $("<ul/>", {
					"data-role" : "listview",
					"id" : "listview" + l.locationID,
					// "data-inset" : true,
					"data-input" : "#searchField",
					"data-filter" : true,
					"data-icon" : false
				});
				$(list).append(list_items);
				$(list).appendTo(col).trigger("create");
				$("#resultsListViewContentDiv").append(col).collapsibleset()
						.trigger("create");
			});
		},
		error : function(xhr, ajaxOptions, thrownError) {
			errorMessagePopupOpen(thrownError);
		}
	});
}

function selectDestination(destination, content) {
	var departure = false;
	if ($("#destinationDefVal").html().indexOf("ROM") != -1)
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
		bounds.extend(markerDest.getPosition());
		bounds.extend(markerDepart.getPosition());
		map.fitBounds(bounds);
		getThePath();
	} else {
		$("#destinationName").html(content);
		$(".spinnerLoading").css('display', 'none');
		$("#locationInf").html($(destination).html()).trigger("create");
		$("#locationInf a").removeClass("resultsListViewContent");
		$("#locationInf a img").removeClass("listViewIcons");
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
		map.setZoom(18);
		blurFalse();
		showBottomPanel();
		// getDirectionFromCurrentLocation();
	}
	$('#popupSearchResult').popup('close');
}

function getDirectionFromCurrentLocation() {
	$("#departureId").val("");
	$("#departureDescriptionInput").val("Current Location");
	findMyLocation();
	$('#popupSearchResult').popup('close');
	blurFalse();
	$("#locationInf").html('');
	do {
		$(".spinnerLoading").css('display', 'block');
	} while ($("#from").val().length < 2);
	getThePath();
}

function clearSearchBTN() {
	$("#destinationName").html("Find a Place");
	if ($("#locationInfoDiv").css('display') != 'none')
		hideBottomPanel();
	if (markerDest != null)
		markerDest.setMap(null);
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
