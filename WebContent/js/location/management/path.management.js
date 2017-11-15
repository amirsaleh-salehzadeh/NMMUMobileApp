var map, marker, infoWindow;
var markers = [];
var paths = [];
function toast(msg) {
	$(
			"<div class='ui-loader ui-overlay-shadow ui-body-e ui-corner-all'><h3>"
					+ msg + "</h3></div>").css({
		display : "block",
		opacity : 0.90,
		position : "fixed",
		padding : "7px",
		"text-align" : "center",
		width : "270px",
		left : ($(window).width() - 284) / 2,
		top : $(window).height() / 2
	}).appendTo($.mobile.pageContainer).delay(1500).fadeOut(400, function() {
		$(this).remove();
	});
}

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
		// map.setZoom(7);
	} else if (locationTypeId == "3") {
		icon += 'building.png';
		map.setCenter(gps);
		// map.setZoom(15);
	} else if (locationTypeId == "4") {
		icon += 'marker-pink.png';
		map.setCenter(gps);
		// map.setZoom(19);
	} else if (locationTypeId == "5") {
//		icon += 'crossroad48.png';
		icon = {
			path : google.maps.SymbolPath.CIRCLE,
			scale : 2
		};
		map.setCenter(gps);
		// map.setZoom(15);
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
	// getLocationTypePanel();
	getPathTypePanel();
	getAllMarkers("360","2");
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
			.getElementById('topToolBox'));
	// map.controls[google.maps.ControlPosition.TOP_CENTER].push(document
	// .getElementById('topToolBox'));
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

	map.setOptions({
		draggableCursor : 'corsshair'
	});

	var polyOptions = {
		strokeWeight : 0,
		fillOpacity : 0.45,
		editable : true,
		draggable : false
	};
	// Creates a drawing manager attached to the map that allows the user to
	// draw
	// markers, lines, and shapes.
	drawingManager = new google.maps.drawing.DrawingManager({
		drawingMode : google.maps.drawing.OverlayType.POLYGON,
		drawingControl : true,
		drawingControlOptions : {
			style : google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
			position : google.maps.ControlPosition.TOP_CENTER,
			// drawingModes: ['marker', 'circle', 'polygon', 'polyline',
			// 'rectangle']
			drawingModes : [ 'polygon' ]
		},
		markerOptions : {
			draggable : false
		},
		polylineOptions : {
			editable : true,
			draggable : false
		},
		rectangleOptions : polyOptions,
		circleOptions : polyOptions,
		polygonOptions : polyOptions,
		map : map
	});

	google.maps.event
			.addListener(
					drawingManager,
					'overlaycomplete',
					function(e) {
						var newShape = e.overlay;
						$("#boundary").val(getPolygonCoords(newShape));
						$('#insertAMarker').popup('open');
						newShape.type = e.type;
						if (e.type !== google.maps.drawing.OverlayType.MARKER) {
							drawingManager.setDrawingMode(null);
							google.maps.event
									.addListener(
											newShape,
											'click',
											function(e) {
												if (e.vertex !== undefined) {
													if (newShape.type === google.maps.drawing.OverlayType.POLYGON) {
														var path = newShape
																.getPaths()
																.getAt(e.path);
														path.removeAt(e.vertex);
														if (path.length < 3) {
															newShape
																	.setMap(null);
														}
													}
													if (newShape.type === google.maps.drawing.OverlayType.POLYLINE) {
														var path = newShape
																.getPath();
														path.removeAt(e.vertex);
														if (path.length < 2) {
															newShape
																	.setMap(null);
														}
													}
												}
												setSelection(newShape);
												showArrays(newShape, e.latLng);
											});
							setSelection(newShape);
						} else {
							google.maps.event.addListener(newShape, 'click',
									function(e) {
										setSelection(newShape);
									});
							setSelection(newShape);
						}
					});

	// Clear the current selection when the drawing mode is changed, or when the
	// map is clicked.
	google.maps.event.addListener(drawingManager, 'drawingmode_changed',
			clearSelection);
	google.maps.event.addListener(map, 'click', clearSelection);
	google.maps.event.addDomListener(document.getElementById('delete-button'),
			'click', deleteSelectedShape);
	// Disables drawing mode on startup so you have to click on toolbar first to
	// draw shapes and create the colour palette
	drawingManager.setDrawingMode(null);
	buildColorPalette();

}

function selectActionType() {
	if ($('[name="optionType"] :radio:checked').val() == "marker") {
		$("#topToolBox").css("display", "block");
		$("#locationTypeListViewDiv").css("display", "block");
		$("#pathTypeListViewDiv").css("display", "none");
		map.setOptions({
			draggableCursor : 'corsshair'
		});
	} else {
		$("#topToolBox").css("display", "none");
		$("#locationTypeListViewDiv").css("display", "none");
		$("#pathTypeListViewDiv").css("display", "block");
		map.setOptions({
			draggableCursor : "url('images/map-markers/road.png'), auto"
		});
	}
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

function setLocationTypeCreate() {
	$(".locationTypeNavBar option").each(function() {
		if ($(this).val() == $("#locationTypeId").val()) {
			$("#locationTypeDefinition").val($(this).html().replace(" ", ""));
			$("#createType").html($(this).html().replace(" ", ""));
		}
	});
	google.maps.event.trigger(map, 'resize');
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
			alert("getPathTypePanel");
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
			getLocationSearchPanel();
			getDecendentList();
		});
function ShowLoadingScreen(loadingContent) {
	if (loadingContent == null) {
		loadingContent = "Please Wait";
	}
	$("#loadingOverlay").css("display", "block");
	$("#loadingContent").css("display", "block");
	$(".markerLoading").css('display', 'block').trigger("create");
	$("#loadingContent").html("Loading. . ." + "</br>" + loadingContent);
}
function HideLoadingScreen() {

	$("#loadingOverlay").css("display", "none");
	$(".markerLoading").css('display', 'none');
	$("#loadingContent").css("display", "none");
}