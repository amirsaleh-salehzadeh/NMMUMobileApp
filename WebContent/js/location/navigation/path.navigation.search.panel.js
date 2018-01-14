var locationTypeJSONData;
var markers = [];
function getAllLocations() {
	var url = "REST/GetLocationWS/SearchForALocation?clientName=NMMU&locationType=Building&locationName=";
	$
			.ajax({
				url : url,
				cache : true,
				async : true,
				success : function(data) {
					// $.each(data, function(p, z) {
					$
							.each(
									data.childrenENT,
									function(k, l) {
										var children = l.childrenENT;
										var col = $("<div/>", {
											"data-role" : "collapsible",
											"data-collapsed" : true,
											"class" : "parentCollapsibleLV",
											"data-icon" : false
										});
										$("<h3/>", {
											text : l.locationName + " Campus"
										}).appendTo(col);
										var list_items = '';
										drawPolygons(l);
										$
												.each(
														children,
														function(x, y) {
															list_items += "<li id='"
																	+ y.locationID
																	+ "_"
																	+ y.gps
																	+ "_"
																	+ y.locationType.locationType
																	+ "' onclick='selectDestination(this, \""
																	+ y.locationType.locationType
																	+ " "
																	+ y.locationName
																	+ "\")' data-icon='false'>"
																	+ "<a href='#' class='resultsListViewContent'>";
															var src = "images/icons/map-markers/building.png";
															if (y.icon != null)
																src = y.icon;
															list_items += "<img src='"
																	+ src
																	+ "' class='listViewIcons' style='visibility: hidden;'><h2>"
																	+ y.locationType.locationType
																	+ " "
																	+ y.locationName
																	+ "</h2><p>";
															var desc = "&nbsp;";
															if (y.description != null)
																desc = y.description;
															list_items += desc
																	+ ", "
																	+ l.locationName
																	+ " Campus</p></a></li>";
															drawPolygons(y);
														});
										var list = $("<ul/>", {
											"data-role" : "listview",
											"id" : "listview" + l.locationID,
											"data-input" : "#searchField",
											"data-filter" : true,
											"data-icon" : false
										});
										$(list).append(list_items);
										$(list).appendTo(col).trigger("create");
										$("#resultsListViewContentDiv").append(
												col).collapsibleset().trigger(
												"create");
									});
				},
				error : function(xhr, ajaxOptions, thrownError) {
					errorMessagePopupOpen(ajaxOptions + ": " + thrownError);
				},
				complete : function(xhr, txtStatus) {
					$('#work-in-progress').fadeOut(1000);
				}
			});
}

function selectDestination(destination, content) {
	var departure = false;
	if (($("#departureId").val().length == 0 || $("#departureId").val() == "0")
			&& (($("#destinationId").val().length != 0 && $("#destinaionId")
					.val() != "0")))
		departure = true;
	$('#popupSearchResult').popup('close');
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
			icon : 'images/icons/map-markers/marker-green.png'
		});
		getThePath();
	} else {
		$("#destinationName").html(content);
		$(".spinnerLoading").css('display', 'none');
		$("#locationInf").html($(destination).html()).trigger("create");
		$("#locationInf a").removeClass("resultsListViewContent");
		$("#locationInf a img").removeClass("listViewIcons");
		$("#locationInf a img").css("visibility", "visibile");
		$("#to").val($(destination).attr("id").split("_")[1].replace(" ", ""));
		$("#destinationId").val($(destination).attr("id").split("_")[0]);
		var destPoint = getGoogleMapPosition($("#to").val());
		if (markerDest != null)
			markerDest.setMap(null);
		markerDest = new google.maps.Marker({
			position : destPoint,
			map : map,
			icon : 'images/icons/map-markers/marker-orange.png'
		});
		markerDest.addListener('click', function() {
			selectDestination(destination);
		});
		for ( var int = 0; int < locationPolylines.length; int++) {
			if ($("#destinationId").val() != locationPolylines[int].id) {
				locationPolylines[int].setMap(map);
			} else
				locationPolylines[int].setMap(null);
		}
		for ( var int = 0; int < locationPolygons.length; int++) {
			if ($("#destinationId").val() != locationPolygons[int].id) {
				locationPolygons[int].setMap(null);
			} else {
				locationPolygons[int].setMap(map);
				map.panTo(markerDest.getPosition());
				// var bounds = locationPolygons[int].latLngs;
				var bounds = new google.maps.LatLngBounds();
				for ( var int2 = 0; int2 < locationPolygons[int].getPath().length; int2++) {
					bounds
							.extend(getGoogleMapPosition(locationPolygons[int]
									.getPath().getAt(int2).lat()
									+ ","
									+ locationPolygons[int].getPath().getAt(
											int2).lng()));
				}
				map.panToBounds(bounds);
				map.fitBounds(bounds);
			}
		}
		showBottomPanel();
	}
}

function getDirectionFromCurrentLocation() {
	findMyLocation();
	$("#departureId").val("");
	$("#departureDescriptionInput").val("Current Location");
	$('#popupSearchResult').popup('close');
	$("#locationInf").html('');
	getThePath();
	closePopup();
}

function clearSearchBTN() {
	$("#destinationName").html("Find a Place");
	if ($("#locationInfoDiv").css('display') != 'none')
		hideBottomPanel();
	if (markerDest != null)
		markerDest.setMap(null);
	if (markerDepart != null)
		markerDepart.setMap(null);
	for ( var int = 0; int < locationPolylines.length; int++) {
		locationPolylines[int].setMap(null);
	}
	for ( var int = 0; int < locationPolygons.length; int++) {
		locationPolygons[int].setMap(map);
	}
}

function searchFieldDivClearBTN() {
	$("#searchField").val("");
	$("#resultsListView").listview("refresh");
}
