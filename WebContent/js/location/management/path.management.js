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

function refreshMap(locationTypeId, gpsStr) {
	var gps = {
		lat : parseFloat(gpsStr.split(",")[0]),
		lng : parseFloat(gpsStr.split(",")[1])
	};
	var icon = 'images/map-markers/';
	if (locationTypeId == "1") {
		icon += 'marker-blue.png';
	} else if (locationTypeId == "2") {
		icon += 'marker-green.png';
		map.setCenter(gps);
		map.setZoom(7);
	} else if (locationTypeId == "3") {
		icon += 'building.png';
		map.setCenter(gps);
		map.setZoom(15);
	} else if (locationTypeId == "4") {
		icon += 'marker-pink.png';
		map.setCenter(gps);
		map.setZoom(19);
	} else if (locationTypeId == "5") {
		icon += 'road.png';
		map.setCenter(gps);
		map.setZoom(15);
	} else
		icon += 'marker-yellow.png';
	return icon;
}

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
	var myStyle = [ {
		featureType : "administrative",
		elementType : "labels",
		stylers : [ {
			visibility : "on"
		} ]
	}, {
		featureType : "poi",
		elementType : "labels",
		stylers : [ {
			visibility : "off"
		} ]
	}, {
		featureType : "water",
		elementType : "labels",
		stylers : [ {
			visibility : "on"
		} ]
	}, {
		featureType : "landscape.man_made",
		elementType : "geometry",
		stylers : [ {
			color : "#f7f1df"
		} ]
	}, {
		featureType : "landscape.natural",
		elementType : "geometry",
		stylers : [ {
			color : "#d0e3b4"
		} ]
	}, {
		featureType : "landscape.natural.terrain",
		elementType : "geometry",
		stylers : [ {
			visibility : "off"
		} ]
	}, {
		featureType : "poi.business",
		elementType : "all",
		stylers : [ {
			visibility : "off"
		} ]
	}, {
		featureType : "poi.medical",
		elementType : "geometry",
		stylers : [ {
			color : "#fbd3da"
		} ]
	}, {
		featureType : "poi.park",
		elementType : "geometry",
		stylers : [ {
			color : "#bde6ab"
		} ]
	}, {
		featureType : "road",
		elementType : "geometry.stroke",
		stylers : [ {
			visibility : "off"
		} ]
	}, {
		featureType : "road.highway",
		elementType : "geometry.fill",
		stylers : [ {
			color : "#ffe15f"
		} ]
	}, {
		featureType : "road.highway",
		elementType : "geometry.stroke",
		stylers : [ {
			color : "#efd151"
		} ]
	}, {
		featureType : "road.arterial",
		elementType : "geometry.fill",
		stylers : [ {
			color : "#ffffff"
		} ]
	}, {
		featureType : "road.local",
		elementType : "geometry.fill",
		stylers : [ {
			color : "black"
		} ]
	}, {
		featureType : "water",
		elementType : "geometry",
		stylers : [ {
			color : "#a2daf2"
		} ]
	} ];
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
		streetViewControl : false,
		scrollwheel : true,
		gestureHandling : 'greedy'
	});
	map.mapTypes.set('mystyle', new google.maps.StyledMapType(myStyle, {
		name : 'My Style'
	}));
	map.setMapTypeId('mystyle');
	map.setCenter(myLatLng);
	map.controls[google.maps.ControlPosition.BOTTOM_LEFT].push(document
			.getElementById('searchFields'));
	map.controls[google.maps.ControlPosition.LEFT_TOP].push(document
			.getElementById('createType'));
	map.controls[google.maps.ControlPosition.TOP_CENTER].push(document
			.getElementById('locationTypeFields'));
	map.controls[google.maps.ControlPosition.TOP_CENTER].push(document
			.getElementById('topToolBox'));
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
		} else {
			addAPath(null, lat + "," + lng);
		}
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
	if (!exist || $("#locationTypeId").val("3")
			|| $("#locationTypeId").val("5")) {
		$(".locationTypeNavBar option").each(
				function() {
					if ($(this).val() == $(field).attr("id").split("_")[2]) {
						$("#locationTypeId").val($(this).val());
						$("#locationTypeDefinition").val(
								$(this).html().replace(" ", ""));
					}
				});
		$("#parentLocationId").val($(field).attr("id").split("_")[0]);
		// $("#locationTypeId").val($(field).attr("id").split("_")[2]);
		if ($("#locationTypeId").val() == 3) {
			$("#infoListView").html(
					"<li id='buildingAdd'> Adding Building on </li>"
							+ "<li id='" + $("#locationTypeId").val() + "_"
							+ $(field).attr("id").split("_")[0]
							+ "' onclick='changeTheLocation(this);'>["
							+ $("#locationTypeDefinition").val() + "] "
							+ $(field).html() + "</li>");
		} else {
			$("#infoListView").html(
					"<li id='intersectionAdd'> Adding Intersection on </li>"
							+ "<li id='" + $("#locationTypeId").val() + "_"
							+ $(field).attr("id").split("_")[0]
							+ "' onclick='changeTheLocation(this);'>["
							+ $("#locationTypeDefinition").val() + "] "
							+ $(field).html() + "</li>");
		}

		$("#infoListView").listview();
		 getMyChild($(field).attr("id").split("_")[2]);
		$("#infoListView").listview();
		$("#infoListView").listview("refresh");
	}
	// getLocationSearchPanel();
	getAllMarkers();
	setLocationTypeCreate();

}

function createMyType(selectOpt) {
	$("#locationTypeId").val($(selectOpt).val());
	if ($(selectOpt).html().indexOf("Area") > -1)
		$("#parentLocationId").val(360);
	else
		$("#parentLocationId").val(0);
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
