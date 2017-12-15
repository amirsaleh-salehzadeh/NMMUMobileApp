var locationTypeJSONData;
var arrAreas = [ 'South_369_2', 'North_371_2' ];
var arrLocationTypesTest = [ 'Client_0_1', 'Area_1_2', 'Building_2_3',
		'Level_3_4', 'Outdoor Intersection_2_5', 'Staircase_4_6', 'Room_4_7',
		'Elevator_4_8', 'Indoor Intersection_4_9', 'Entrance_4_10' ];

function getAllLocationTypes() {
	var url = "REST/GetLocationWS/GetAllLocationTypes";
	$
			.ajax({
				url : url,
				cache : false,
				async : true,
				success : function(data) {
					setCookie('TripPathIdsCookie', JSON.stringify(data), 1);
				},
				error : function(xhr, ajaxOptions, thrownError) {
					// alert(xhr.status);
					// alert(thrownError);
					// alert("getAllLocationTypes");
					popErrorMessage("An error occured while fetching the location types from the server. "
							+ thrownError);
				}
			});
}

function getLocationTypeDropDown(obj) {
	if (obj == null)
		obj = JSON.parse(getCookie('TripPathIdsCookie'));
	var locationData = "";
	$(obj)
			.each(
					function(k, l) {
						if (l.parent.locationTypeId == $(
								"#parentLocationTypeId").val()) {
							locationData += '<a href="#" type="radio" onClick="selectThisLocationType(this)" class="locationTypeSelecIcons" name="locationType" value="'
									+ l.locationTypeId
									+ '" id="locationTypeId'
									+ l.locationTypeId
									+ '"><img title= "'
									+ l.locationType
									+ '" src="'
									+ getLocationTypeImage(l.locationTypeId)
									+ '" width="48px" height="48px" /></a>';
						} else
							obj = l;
					});
	if (locationData.length > 0) {
		$("#locationType").html(locationData);
		$("#locationType").controlgroup("refresh").trigger("create");
		$("#locationType").controlgroup("option", "type", "horizontal");
	}
	if (obj.children != null)
		getLocationTypeDropDown(obj.children);
	else
		return;
}

function getParentLocationTypeId(obj, id) {
	if (obj == null)
		obj = JSON.parse(getCookie('TripPathIdsCookie'));
	$(obj).each(function(k, l) {
		if (l.locationTypeId == id) {
			$("#parentLocationTypeId").val(l.parent.locationTypeId);
			$("#locationTypeId").val(l.locationTypeId);
			// return;
		} else
			obj = l;
	});
	if (obj.children != null)
		getParentLocationTypeId(obj.children, id);
	else
		return;
}

function getLocationTypeName(obj, id) {
	if (obj == null)
		obj = JSON.parse(getCookie('TripPathIdsCookie'));
	$(obj).each(
			function(k, l) {
				if (l.locationTypeId == id) {
					$("#locationTypeLabel").html(l.locationType);
					$("#locationTypeLabelFooter").val(l.locationType);
					$("#modeSelection_locationText").html(
							l.locationType.toUpperCase()).trigger("create");
					return;
				} else
					obj = l;
			});
	if (obj.children != null)
		getLocationTypeName(obj.children, id);
	else
		return "";
}

function selectThisLocationType(ltype) {
	if (ltype != null) {
		$("#locationTypeId").val($(ltype).attr("value"));
	}
	$(".locationTypeSelecIcons").each(
			function() {
				if ($(this).hasClass("locationTypeSelecIconSelected"))
					$(this).removeClass("locationTypeSelecIconSelected");
				if ($(this).attr("value") == $("#locationTypeId").val()
						|| $("#locationTypeId").val() == "0"
						|| $("#locationTypeId").val() == $(
								"#parentLocationTypeId").val()) {
					$(this).addClass("locationTypeSelecIconSelected").trigger(
							"create");
					$("#locationTypeId").val($(this).attr("value"));
				}
			});
	getLocationTypeName(null, $("#locationTypeId").val());
}

function getLocationTypeImage(locationTypeId) {
	var icon = 'images/map-markers/';
	if (locationTypeId == "1") {
		icon += 'marker-blue.png';
	} else if (locationTypeId == "11") {
		icon += 'door.png';
	} else if (locationTypeId == "2") {
		icon += 'area.png';
	} else if (locationTypeId == "3") {
		icon += 'building.png';
	} else if (locationTypeId == "4") {
		icon += 'marker-pink.png';
	} else if (locationTypeId == "5") {
		icon = 'images/icons/path.png';
	} else
		icon = 'images/icons/pathType/stairs.png';
	return icon;
}

function locationEditPanelOpen(title, info) {
	// $(".SaveCancelBTNPanel").css(
	// "top",
	// parseInt(parseInt($(".jqm-header").height())
	// + parseInt($("#locPathModeRadiobtn").height()) + 3))
	// .trigger("create");
	// $(".SaveCancelBTNPanel").css(
	// "left",
	// parseInt(parseInt($(window).width()) / 2
	// - +parseInt($(".SaveCancelBTNPanel").width()) / 2))
	// .trigger("create");
	$("#locationInfo").html('');
	$("#locationEditMenuTitle").html(title + " (" + info + ")");
	$("#locationInfo").prepend(title);
	$("#locationDescriptionLabel").html(info);// +":"
	$('#locationEditMenu').popup("option", {
		x : event.pageX,
		y : event.pageY
	});
	$("#locationEditMenu").popup("open").trigger("create");
}

function openALocation() {
	$("#locationEditMenu").popup("close");
	$("#parentLocationId").val($("#markerId").val());
	getAllMarkers($("#markerId").val(), true);
}

function openLocationTypePopup() {
	selectThisLocationType(null);
	$('#editLocationTypePopup').popup("option", {
		x : event.pageX,
		y : event.pageY
	});
	$("#mainBodyContents").trigger('create');
	$("#locationEditMenu").on("popupafterclose", function() {
		setTimeout(function() {
			$("#editLocationTypePopup").trigger('create').popup('open');
		}, 100);
	});
	$("#locationEditMenu").popup("close");
	$("#mainBodyContents").trigger('create');
}

function openLocationInfoPopup() {
	$('#editLocationInfoPopup').popup("option", {
		x : event.pageX,
		y : event.pageY
	});
	// $("#mainBodyContents").trigger('create');
	$("#locationEditMenu").on("popupafterclose", function() {
		setTimeout(function() {
			$("#editLocationInfoPopup").trigger('create').popup('open');
		}, 100);
	});
	$("#locationEditMenu").popup("close");
	// $("#mainBodyContents").trigger('create');
}

function closeAMenuPopup() {
	$('.menuItemPopupClass').popup('close');
	$("#locationEditMenu").unbind("popupafterclose");
	$("#pathEditMenu").unbind("popupafterclose");
	if (tmpCreateNewlocation != null) {
		tmpCreateNewlocation.setMap(null);
		tmpCreateNewlocation = null;
	}
	if (selectedShape != null) {
		selectedShape.setMap(null);
		selectedShape = null;
	}
	map.setOptions({
		draggableCursor : 'crosshair'
	});
	$("#actionBar").css("display", "none");
	// hideMainBoundary();
	// unselectBoundary();
}

function openIconPopup() {
	$('#editIconPopup').popup("option", {
		x : event.pageX,
		y : event.pageY
	});
	$("#locationEditMenu").on("popupafterclose", function() {
		setTimeout(function() {
			$("#editIconPopup").popup('open').trigger('create');
		}, 100);
	}).trigger('create');
	$("#mainBodyContents").trigger('create');
	$("#locationEditMenu").popup("close");
}

// function showMainBoundary() {
// setMapOnAllPolygons(null);
// var i = 0;
// for ( var int = 0; int < polygons.length; int++) {
// if (polygons[int].id == $("#markerId").val())
// i = int;
// }
// if (i > 0)
// polygons[i].setMap(map);
// $("#locationEditMenu").popup("close");
// $("#editBoundaryPopup").css("left",($("#map_canvas").width()/2)-($("#editBoundaryPopup").width()/2));
// $("#editBoundaryPopup").css("display", "block");
// }
//
// function hideMainBoundary() {
// setMapOnAllPolygons(map);
// $("#locationEditMenu").popup("close");
// $("#editBoundaryPopup").css("display", "none");
// }

function openEditBoundaryPopup() {
	$('#editBoundaryPopup').popup("option", {
		x : event.pageX,
		y : event.pageY
	});
	$("#locationSaveCancelPanel").css("display", "inline-block").trigger(
			"create");
	$("#locationSaveCancelPanel").css(
			"top",
			parseInt(parseInt($(".jqm-header").height())
					+ parseInt($("#locPathModeRadiobtn").height()) + 3))
			.trigger("create");
	$("#locationSaveCancelPanel").css(
			"left",
			parseInt(parseInt($(window).width() / 2)
					- parseInt($("#locationSaveCancelPanel").width() / 2)))
			.trigger("create");
	$("#locationEditMenu").on("popupafterclose", function() {
		setTimeout(function() {
			$("#editBoundaryPopup").trigger('create').popup('open');
		}, 100);
	});
	$("#locationEditMenu").popup("close");
}

function showLocationInfo() {
	$("#locationEditMenu").popup("close");
	$("#locationInfoFooter").css("display", "inline-block").trigger("create");
	// $("#locationSaveCancelPanel").css("display",
	// "inline-block").trigger("create");
	hidePathInfo();
	// $("#locationSaveCancelPanel").css(
	// "top",
	// parseInt(parseInt($(".jqm-header").height())
	// + parseInt($("#locPathModeRadiobtn")
	// .height()) + 3));
}

function hideLocationInfo() {
	$("#locationInfoFooter").css("display", "none");
	for ( var i = 0; i < polygons.length; i++) {
		polygons[i].setEditable(false);
		polygons[i].setMap(map);
	}
	selectedShape = null;
	// $("#locationSaveCancelPanel").css("display", "none");
}

function pathEditPanelOpen(title) {
	$("#pathEditMenuTitle").html(title);
	$('#pathEditMenu').popup("option", {
		x : event.pageX,
		y : event.pageY
	});
	$("#pathEditMenu").popup("open").trigger("create");
}

function showPathInfo() {
	$("#pathEditMenu").popup("close");
	$("#pathInfoFooter").css("display", "inline-block").trigger("create");
	hideLocationInfo();
}

function hidePathInfo() {
	$("#pathInfoFooter").css("display", "none");
}

function openPathInfoPopup() {
	$('#editPathInfoPopup').popup("option", {
		x : event.pageX,
		y : event.pageY
	});
	$("#mainBodyContents").trigger('create');
	$("#pathEditMenu").on("popupafterclose", function() {
		setTimeout(function() {
			$("#editPathInfoPopup").trigger('create').popup('open');
		}, 100);
	});
	$("#pathEditMenu").popup("close");
	$("#mainBodyContents").trigger('create');
}

function openPathTypePopup() {
	$(".pathTypeIcon").each(function() {
		if ($(this).hasClass("pathTypeIconSelected")) {
			$(this).removeClass("pathTypeIconSelected");
		}
		$(this).trigger("create");
	});
	$('#editPathTypePopup').popup("option", {
		x : event.pageX,
		y : event.pageY
	});
	$("#mainBodyContents").trigger('create');
	$("#pathEditMenu").on("popupafterclose", function() {
		setTimeout(function() {
			$("#editPathTypePopup").trigger('create').popup('open');
		}, 100);
	});
	$("#pathEditMenu").popup("close");
	$("#mainBodyContents").trigger('create');
}

function openSearchPanel() {
	getLocationTypeList();
	$("#locationSearchPanel").panel("open");
}

function getLocationTypeList() {
	$("#resultsListViewContentDiv").empty();
	var url = "REST/GetLocationWS/SearchForALocation?clientName=NMMU&locationType=Building&locationName=";
	$.ajax({
		url : url,
		cache : true,
		async : true,
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
					list_items += desc + ", " + l.locationName
							+ " Campus</p></a></li>";
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
			errorMessagePopupOpen(ajaxOptions + ": " + thrownError);
		}
	});
}

function searchFieldDivClearBTN() {
	$("#searchField").val("");
	$("#resultsListView").listview("refresh");
}