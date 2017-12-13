var minZoomLevel;
// var longpress = false;
var start;
// var boundaryEditable = false;
var drawingManager;

function createDrawingManager() {
	var polyOptions = {
		strokeWeight : 2,
		fillOpacity : 0.45,
		editable : true,
		draggable : false
	};
	// Creates a drawing manager attached to the map that allows the user to
	// draw polygons
	drawingManager = new google.maps.drawing.DrawingManager({
		drawingMode : google.maps.drawing.OverlayType.POLYGON,
		drawingControl : false,
		drawingControlOptions : {
			style : google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
			position : google.maps.ControlPosition.TOP_CENTER,
			drawingModes : [ 'polygon' ]
		},
		markerOptions : {
			draggable : true
		},
		polylineOptions : {
			editable : false,
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
						newShape.type = e.type;
						$("#boundary").val(getPolygonCoords(newShape));
						// alert("Test1");
						// google.maps.event.addListener(newShape, "mouseup",
						// function(event) {
						// $("#boundary").val(
						// getPolygonCoords(newShape));
						// // alert("test2");
						// });
						// alert("test1");
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
												editPolygon(newShape);
											});
							// setBoundarySelection(newShape);
						} else {
							google.maps.event.addListener(newShape, 'click',
									function(e) {
										setBoundarySelection(newShape);
									});
							setBoundarySelection(newShape);
						}
						if ($("#tempBoundaryColors").val() == "") {
							setBoundaryFillColour("#1E90FF");
							setBoundaryBorderColour("#1E90FF");
							$("#tempBoundaryColors").val("1E90FF,1E90FF");
						} else {
							setBoundaryFillColour(getFillColourValue);
							setBoundaryBorderColour(getBorderColourValue);
						}
					});

	// Clear the current selection when the drawing mode is changed, or when the
	// map is clicked.
	// google.maps.event.addListener(drawingManager, 'drawingmode_changed',
	// unselectBoundary);

	// Disables drawing mode on startup so you have to click on toolbar first to
	// draw shapes and create the colour palette
	drawingManager.setDrawingMode(null);
}

function drawPolygons(location) {
	var arrayBoundary = getArrayBoundary(location.boundary).split("_");
	var CoordinatesArray = new Array();
	for ( var i = 0; i < arrayBoundary.length; i++) {
		var LatAndLng = arrayBoundary[i].split(",");
		var LatLng = new google.maps.LatLng(LatAndLng[0], LatAndLng[1]);
		CoordinatesArray.push(LatLng);
	}
	var boundaryColour = getBoundaryColour(location.boundary);
	var FillColour;
	var BorderColour;
	if (boundaryColour == "") {
		FillColour = "#1E90FF";
		BorderColour = "#1E90FF";
	} else {
		FillColour = '#' + boundaryColour[0];
		BorderColour = '#' + boundaryColour[1];
	}

	var DRAWPolygon = new google.maps.Polygon({
		paths : CoordinatesArray,
		strokeColor : BorderColour,
		strokeWeight : 2,
		fillColor : FillColour,
		title : location.locationName + " "
				+ location.locationType.locationType
	});
	DRAWPolygon.setMap(map);
	DRAWPolygon.id = location.locationID;
	google.maps.event.addListener(DRAWPolygon, 'click', function(event) {
		// if (longpress) {
		// $("#parentLocationId").val(location.locationID);
		// getAllMarkers(location.locationID + "", true);
		// minZoomLevel = 16;
		// map.setZoom(minZoomLevel);
		// // Limit the zoom level
		// google.maps.event.addListener(map, 'zoom_changed', function() {
		// if (map.getZoom() < minZoomLevel)
		// map.setZoom(minZoomLevel);
		// });
		// } else {
//		for ( var int = 0; int < polygons.length; int++) {
//			if (polygons[int].id != $("#markerId").val())
//				polygons[int].setMap(null);
//		}
		showLocationInfo();
		// if (boundarySelected) { // boundary selected
		// if (DRAWPolygon == selectedShape) {
		// clearBoundarySelection();
		// } else { // previous boundary selected but now selecting new
		// boundary
		setBoundarySelection(this);
		clearMarkerLabel();
		addAMarker(location, location.gps);

		// }
		// } else { // boundary not selected
		// setBoundarySelection(DRAWPolygon);
		// clearMarkerLabel();
		// addAMarker(location, location.gps);
		// }
		// }
		$('#editBoundary').on('click', function() {
			editPolygon(DRAWPolygon);
		});
		$('#boundaryColour').css('background-color', FillColour);
		$('#boundaryColour').css('border-color', BorderColour)
				.trigger("create");
		$('#colorSelectorFill div').css('background-color', FillColour);
		$('#colorSelectorBorder div').css('background-color', BorderColour);
		$('#colorSelectorFill').ColorPickerSetColor(FillColour);
		$('#colorSelectorBorder').ColorPickerSetColor(BorderColour);
	});

	// google.maps.event.addListener(DRAWPolygon, 'mousedown', function(event) {
	// start = new Date().getTime();
	// });
	// google.maps.event.addListener(DRAWPolygon, 'mouseup', function(event) {
	// end = new Date().getTime();
	// longpress = (end - start < 500) ? false : true;
	// // $("#boundary").val(getPolygonCoords(DRAWPolygon));
	// });
	google.maps.event.addListener(DRAWPolygon, 'mousemove', function(event) {
		$("#googleMapMarkerLabel").html(location.locationName);
		$('#googleMapMarkerLabel').css("display", "block");
		$('#googleMapMarkerLabel').css("position", "absolute");
		$('#googleMapMarkerLabel').css("left", event.xa.x + 17 + 'px');
		$('#googleMapMarkerLabel').css("top", event.xa.y + 17 + 'px');
		$('#googleMapMarkerLabel').trigger("create");
	});
	google.maps.event.addListener(DRAWPolygon, 'mouseout', function(event) {
		clearMarkerLabel();
	});
	polygons.push(DRAWPolygon);
}

function undoColourChange() {
	$("#tempBoundaryColors").val($("#boundaryColors").val());
	$('#boundaryColour').css('background-color', getFillColourValue());
	$('#boundaryColour').css('border-color', getBorderColourValue());
	$('#colorSelectorFill div').css('background-color', getFillColourValue());
	$('#colorSelectorBorder div').css('background-color',
			getBorderColourValue());
	$('#colorSelectorFill').ColorPickerSetColor(getFillColourValue());
	$('#colorSelectorBorder').ColorPickerSetColor(getBorderColourValue());
	setBoundaryFillColour(getFillColourValue());
	setBoundaryBorderColour(getBorderColourValue());
}

function getArrayBoundary(boundary) {
	var locationWithColourArray = boundary.split(";");
	var arrayBoundary = locationWithColourArray[0];
	return arrayBoundary;
}

function getBoundaryColour(boundary) {
	var locationWithColourArray = boundary.split(";");
	if (boundary.length <= 1 || locationWithColourArray.length <= 1)
		return "#000000,#FFFFFF";
	var boundaryColour = locationWithColourArray[1].split(",");
	return boundaryColour;
}

function showHideColors() {
	if ($("#boundaryColorFieldset").css("display") == "none") {
		$("#boundaryColorFieldset").css("display", "block");
	} else {
		$("#boundaryColorFieldset").css("display", "none");
	}

}

function deletePolygon() {
	var id = $("#markerId").val();
	for ( var i = 0; i < polygons.length; i++) {
		if (polygons[i].id == id) {
			polygons[i].setMap(null);
			polygons.splice(i, 1);
			$('#locationEditMenu').popup('close');
			return;
		}
	}
	hideMainBoundary();
	// unselectBoundary();
}

function setMapOnAllPolygons(map) {
	for ( var i = 0; i < polygons.length; i++) {
		polygons[i].setMap(map);
	}
}

function startDrawingMode() {
	drawingManager.setDrawingMode(google.maps.drawing.OverlayType.POLYGON);

}

function removeDrawingMode() {
	drawingManager.setDrawingMode(null);
	// boundaryEditable = false;
}

// function clearBoundarySelection() {
// if (selectedShape) {
// if (selectedShape.type !== 'marker') {
// selectedShape.setEditable(false);
// }
//
// selectedShape = null;
// }
// $("#tempBoundaryColors").val("");
// $("#boundary").val("");
// boundarySelected = false;
// }

// function unselectBoundary() {
// if (selectedShape) {
// if (selectedShape.type !== 'marker') {
// selectedShape.setEditable(false);
// }
//
// selectedShape = null;
// }
// boundarySelected = false;
// }

function setBoundarySelection(shape) {
	for ( var i = 0; i < polygons.length; i++) {
		polygons[i].setEditable(false);
	}
	if (shape.type !== 'marker') {
		// clearBoundarySelection();
		shape.setEditable(true);
	}
	selectedShape = shape;
	// boundarySelected = true;
}

function editPolygon(shape) {
	// if (boundaryEditable) {
	// boundaryEditable = false;
	// shape.setEditable(false);
	// } else {
	// boundaryEditable = true;
	for ( var i = 0; i < polygons.length; i++) {
		polygons[i].setEditable(false);
	}
	if (shape.type !== 'marker') {
		// unselectBoundary();
		shape.setEditable(true);
	}
	selectedShape = shape;
	// boundarySelected = true;
	// }
}

function deleteSelectedShape() {
	if (confirm("Are you sure you want to delete this polygon?")) {
		selectedShape.setMap(null);
		$("#boundary").val("");
	}
}

function createColorPicker() {
	$('#colorSelectorFill').ColorPicker({
		color : '#0000ff',
		onShow : function(colpkr) {
			$(colpkr).fadeIn(500);
			return false;
		},
		onHide : function(colpkr) {
			$(colpkr).fadeOut(500);
			return false;
		},
		onChange : function(hsb, hex, rgb) {
			$('#colorSelectorFill div').css('backgroundColor', '#' + hex);
			$('#boundaryColour').css('background-color', '#' + hex);
			updateFillColourValue(hex);
		}
	});
	$('#colorSelectorBorder').ColorPicker({
		color : '#0000ff',
		onShow : function(colpkr) {
			$(colpkr).fadeIn(500);
			return false;
		},
		onHide : function(colpkr) {
			$(colpkr).fadeOut(500);
			return false;
		},
		onChange : function(hsb, hex, rgb) {
			$('#colorSelectorBorder div').css('backgroundColor', '#' + hex);
			$('#boundaryColour').css('border-color', '#' + hex);
			updateBorderColourValue(hex);
		}
	});
}

function applyBoundaryColour() {
	if (selectedShape) {
		setBoundaryFillColour(getFillColourValue());
	}
	if (selectedShape) {
		setBoundaryBorderColour(getBorderColourValue());
	}
}

function getPolygonCoords(shape) {
	var len = shape.getPath().getLength();
	var coordinates = "";
	for ( var i = 0; i < len; i++) {
		coordinates = coordinates + shape.getPath().getAt(i).lat() + ","
				+ shape.getPath().getAt(i).lng();
		if (i !== len - 1) {
			coordinates = coordinates + "_";
		}
	}
	return coordinates;
}

function setBoundaryFillColour(HexFillColour) {
	var polygonOptions = drawingManager.get('polygonOptions');
	polygonOptions.fillColor = HexFillColour;
	drawingManager.set('polygonOptions', polygonOptions);
	selectedShape.set('fillColor', HexFillColour);
}

function setBoundaryBorderColour(HexBorderColour) {
	var polygonOptions = drawingManager.get('polygonOptions');
	polygonOptions.strokeColor = HexBorderColour;
	drawingManager.set('polygonOptions', polygonOptions);
	selectedShape.set('strokeColor', HexBorderColour);
}

function updateFillColourValue(FillColour) {
	var boundaryColour = $("#tempBoundaryColors").val().split(",");
	var BorderColour = boundaryColour[1];
	$("#tempBoundaryColors").val(FillColour + "," + BorderColour);
}

function updateBorderColourValue(BorderColour) {
	var boundaryColour = $("#tempBoundaryColors").val().split(",");
	var FillColour = boundaryColour[0];
	$("#tempBoundaryColors").val(FillColour + "," + BorderColour);
}

function getFillColourValue() {
	var boundaryColour = $("#tempBoundaryColors").val().split(",");
	var FillColour = boundaryColour[0];
	return '#' + FillColour;
}

function getBorderColourValue() {
	var boundaryColour = $("#tempBoundaryColors").val().split(",");
	var BorderColour = boundaryColour[1];
	return '#' + BorderColour;
}