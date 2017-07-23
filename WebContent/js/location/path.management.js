var map, marker, infoWindow;
var markers = [];
var paths = [];

function printBarcode(id, name) {
	if (id == "") {
		alert("The location does not exist yet. Please save the location first");
		return;
	}
	window.open("pages/location/barcodePrint.jsp?locationId=" + id);
}


function refreshMap(location) {
	var gps = {
		lat : parseFloat(location.gps.split(",")[0]),
		lng : parseFloat(location.gps.split(",")[1])
	};
	var icon = 'images/map-markers/';
	if (location.locationType.locationTypeId == "1") {
		icon += 'marker-blue.png';
	} else if (location.locationType.locationTypeId == "2") {
		icon += 'marker-green.png';
		map.setCenter(gps);
		map.setZoom(7);
	} else if (location.locationType.locationTypeId == "3") {
		icon += 'building.png';
		map.setCenter(gps);
		map.setZoom(15);
	} else if (location.locationType.locationTypeId == "4") {
		icon += 'marker-pink.png';
		map.setCenter(gps);
		map.setZoom(19);
	} else if (location.locationType.locationTypeId == "5") {
		icon += 'road.png';
		map.setCenter(gps);
		map.setZoom(20);
	} else
		icon += 'marker-yellow.png';
	return icon;
}

//function addToPath(location, gps) {
//	gps = gps.replace(" ", "");
//	if ($('[name="optionType"] :radio:checked').val() == "marker") {
//		var edit = true;
//		if (location == null) {
//			edit = false;
//			$("#markerId").val("");
//			$("#markerName").val("");
//			$("#markerCoordinate").val(gps);
//			$("#markerLabel").html();
//		} else {
//			$("#markerId").val(location.locationID);
//			$("#markerName").val(location.locationName);
//			$("#markerCoordinate").val(gps);
//			$("#markerLabel").html(location.locationType.locationType);
//		}
//		openMarkerPopup(edit);
//	} else {
//		if (location == null) {
//			alert("A path can only be drawn between two locations");
//			return;
//		}
//		if ($("#departure").val() == "") {
//			$("#departure").val(location.locationName);
//			$("#departureId").val(location.locationID);
//			google.maps.event.clearInstanceListeners(map);
//			$("#pathLatLng").val(location.gps);
//			$("#destinationIds").val(location.locationID);
//			google.maps.event.addListener(map, "click", function(event) {
//				addAPathInnerConnection(event);
//			});
//			return;
//		} else if ($("#destination").val() == "") {
//			$("#destination").val(location.locationName);
//			$("#destinationId").val(location.locationID);
//			google.maps.event.clearInstanceListeners(map);
//			var lastUnnecessaryMarkerId = $("#destinationIds").val().split(",")[$(
//					"#destinationIds").val().split("_").length];
//			var lastUnnecessaryMarkerGPS = $("#pathLatLng").val().split("_")[$(
//					"#pathLatLng").val().split("_").length];
//			$("#destinationIds").val(
//					$("#destinationIds").val().replace(
//							"," + lastUnnecessaryMarkerId, ""));
//			$("#pathLatLng").val(
//					$("#pathLatLng").val().replace(
//							"_" + lastUnnecessaryMarkerGPS, ""));
//			$("#markerId").val(lastUnnecessaryMarkerId);
//			var url = "REST/GetLocationWS/RemoveALocation?locationId="
//					+ $("#markerId").val();
//			$.ajax({
//				url : url,
//				cache : false,
//				async : true,
//				success : function(data) {
//					$('#insertAMarker').popup('close');
//					if (data.errorMSG != null) {
//						alert(data.errorMSG);
//						return;
//					}
//					getAllMarkers();
//				},
//				error : function(xhr, ajaxOptions, thrownError) {
//					alert(xhr.status);
//					alert(thrownError);
//				}
//			});
//			$("#pathLatLng").val($("#pathLatLng").val() + "_" + gps);
//			$("#destinationIds").val(
//					$("#destinationIds").val() + "," + location.locationID);
//			openPathCreationPopup();
//		}
//	}
//}

function getGoogleMapPosition(gps) {
	var res = new google.maps.LatLng(parseFloat(gps.split(',')[0]),
			parseFloat(gps.split(',')[1]));
	return res;
}

function animateCircle(line) {
	var count = 0;
	window.setInterval(function() {
		count = (count + 1) % 200;
		var icons = line.get('icons');
		icons[0].offset = (count / 2) + '%';
		line.set('icons', icons);
	}, 50);
}

function openPathCreationPopup() {
	$('#insertAPath').popup().trigger('create');
	$('#insertAPath').popup('open').trigger('create');
}

function initMap() {
	getLocationTypePanel();
	getPathTypePanel();
	getAllPaths();
	var myLatLng = {
		lat : -33.5343803,
		lng : 24.2683424
	};

	map = new google.maps.Map(document.getElementById('map_canvas'), {
		zoom : 7,
		fullscreenControl : true,
		streetViewControl : false
	});

	map.setCenter(myLatLng);
	map.controls[google.maps.ControlPosition.BOTTOM_LEFT].push(document
			.getElementById('searchFields'));
	map.controls[google.maps.ControlPosition.LEFT_TOP].push(document
			.getElementById('createType'));
	map.controls[google.maps.ControlPosition.TOP_CENTER].push(document
			.getElementById('locationTypeFields'));
	map.controls[google.maps.ControlPosition.RIGHT_TOP].push(document
			.getElementById('locationsUnderAType'));
	map.controls[google.maps.ControlPosition.LEFT_TOP].push(document
			.getElementById('infoDiv'));
	google.maps.event.addListener(map, "click", function(event) {
		$("#departure").val("");
		$("#departureId").val("");
		$("#destination").val("");
		$("#destinationId").val("");
		var lat = event.latLng.lat();
		var lng = event.latLng.lng();
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			addAMarker(null, lat + "," + lng);
		} 
//		else {
//			addAPath(null, lat + "," + lng);
//		}
	});
}

function selectActionType() {
	if ($('[name="optionType"] :radio:checked').val() == "marker") {
		$("#locationTypeListViewDiv").css("display", "block");
		$("#pathTypeListViewDiv").css("display", "none");
	} else {
		$("#locationTypeListViewDiv").css("display", "none");
		$("#pathTypeListViewDiv").css("display", "block");
	}
}

var locationTypeJSONData;
function changeTheLocation(li) {
	$("#locationTypeId").val($(li).attr("id").split("_")[0]);
	setLocationTypeCreate();
	$("#parentLocationId").val($(li).attr("id").split("_")[1]);
	var remove = false;
	$("#infoListView li").each(function() {
		if (remove)
			$(this).remove();
		if ($(this).attr("id") == $(li).attr("id"))
			remove = true;
	});
	getAllMarkers();
}

function setLocationTypeCreate() {
	$(".locationTypeNavBar option").each(function() {
		if ($(this).val() == $("#locationTypeId").val()) {
			$("#locationTypeDefinition").val($(this).html().replace(" ", ""));
			$("#createType").html($(this).html().replace(" ", ""));
		}
	});
	google.maps.event.trigger(map, 'resize');
}

function selectParent(field) {
	var exist = false;
	$("#infoListView li").each(function() {
		if ($(this).html().indexOf($(field).html()) !== -1)
			exist = true;
	});
	if (!exist) {
		$(".locationTypeNavBar option").each(
				function() {
					if ($(this).val() == $(field).attr("id").split("_")[2]) {
						$("#locationTypeId").val($(this).val());
						$("#locationTypeDefinition").val(
								$(this).html().replace(" ", ""));
					}
				});
		$("#parentLocationId").val($(field).attr("id").split("_")[0]);
		$("#locationTypeId").val($(field).attr("id").split("_")[2]);
		$("#infoListView").append(
				"<li id='" + $("#locationTypeId").val() + "_"
						+ $(field).attr("id").split("_")[0]
						+ "' onclick='changeTheLocation(this);'>["
						+ $("#locationTypeDefinition").val() + "] "
						+ $(field).html() + "</li>");
		$("#infoListView").listview();
		getMyChild($(field).attr("id").split("_")[2]);
		$("#infoListView").listview();
		$("#infoListView").listview("refresh");
		getAllMarkers();
		setLocationTypeCreate();
	}
}

function createMyType(selectOpt) {
	$("#locationTypeId").val($(selectOpt).val());
	setLocationTypeCreate();
}

function getPathTypePanel() {
	var url = "REST/GetLocationWS/GetAllPathTypes";
	$.ajax({
		url : url,
		cache : false,
		success : function(data) {
			var tmp = "";
			$.each(data, function(k, l) {
				tmp += "<li value='" + l.pathTypeId
						+ "' class='liPathLV'><a href='#'>" + l.pathType
						+ "</a></li>";
			});
			$("ul#pathTypeListView").html(tmp).trigger("create");
			$("ul#pathTypeListView").listview();
			$("ul#pathTypeListView").listview("refresh");
			$("#rightpanel").trigger("updatelayout");
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});
}

$(document).ready(
		function() {
			$("#map_canvas").css("min-width",
					parseInt($("#mainBodyContents").css("width")));
			$("#map_canvas").css(
					"min-height",
					parseInt($(window).height())
							- parseInt($(".jqm-header").css("height")) - 7);

		});
