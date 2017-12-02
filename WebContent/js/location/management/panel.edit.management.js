var locationTypeJSONData;
var arrAreas = [ 'South_369_2', 'North_371_2' ];
var arrLocationTypesTest = [ 'Client_0_1', 'Area_1_2', 'Building_2_3',
		'Level_3_4', 'Outdoor Intersection_2_5', 'Staircase_4_6', 'Room_4_7',
		'Elevator_4_8', 'Indoor Intersection_4_9', 'Entrance_4_10' ];

function getAllLocationTypes() {
	var url = "REST/GetLocationWS/GetAllLocationTypes";
	$.ajax({
		url : url,
		cache : false,
		async : true,
		success : function(data) {
			setCookie('TripPathIdsCookie', JSON.stringify(data), 1);
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
			alert("getAllLocationTypes");
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
	if (ltype != null)
		$("#locationTypeId").val($(ltype).attr("value"));
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
		icon += 'marker-green.png';
	} else
		icon += 'marker-yellow.png';
	return icon;
}

function openPanel() {
	if ($("#locationEditPanel").hasClass("ui-panel-open")) {
		$("#openLocationEditMenu").attr("href", "#locationEditPanel");
	} else {
		$("#openLocationEditMenu").attr("href", "#locationEditPanel");
	}

	if ($("#pathEditPanel").hasClass("ui-panel-open")) {
		$("#openLocationEditMenu").attr("href", "#pathEditPanel");
	} else {
		$("#openLocationEditMenu").attr("href", "#pathEditPanel");
	}
}

function locationEditPanelOpen() {
//	if ($("#locationEditPanel").hasClass("ui-panel-open")) {
//		$("#openLocationEditMenu").attr("href", "#locationEditPanel");
//	} else {
//		$("#openLocationEditMenu").attr("href", "#locationEditPanel");
//	}
//
//	if ($("#pathEditPanel").hasClass("ui-panel-open")) {
//		$("#openLocationEditMenu").attr("href", "#pathEditPanel");
//	} else {
//		$("#openLocationEditMenu").attr("href", "#pathEditPanel");
//	}
	pathEditPanelClose();
	$('#locationEditPanel').panel("open");
	$("#pathTypePopup").fadeOut();
}

function locationEditPanelClose() {
	$('#locationEditPanel').panel("close");
}

function pathEditPanelOpen() {
	locationEditPanelClose();
	$('#pathEditPanel').panel("open");
}

function pathEditPanelClose() {
	$('#pathEditPanel').panel("close");
	$("#pathTypePopup").fadeOut();
}


function closePanel() {
	if ($("#locationEditPanel").hasClass("ui-panel-open")) {
		$("#closeLocationEditMenu").trigger("click");
	}
	if ($("#pathEditPanel").hasClass("ui-panel-open")) {
		$("#closeLocationEditMenu").trigger("click");
	}
}