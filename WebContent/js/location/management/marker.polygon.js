var minZoomLevel;
function createDrawingManager() {
	var polyOptions = {
		strokeWeight : 2,
		fillOpacity : 0.45,
		editable : true,
		draggable : false
	};
	// Creates a drawing manager attached to the map that allows the user to
	// draw
	// markers, lines, and shapes.
	drawingManager = new google.maps.drawing.DrawingManager({
		drawingMode : google.maps.drawing.OverlayType.POLYGON,
		drawingControl : false,
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
						newShape.type = e.type;
						$("#boundary").val(getPolygonCoords(newShape));
						// alert("Test1");
						google.maps.event.addListener(newShape, "mouseup",
								function(event) {
									$("#boundary").val(
											getPolygonCoords(newShape));
									// alert("test2");
								});
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
												setBoundarySelection(newShape);
											});
							setBoundarySelection(newShape);
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
						} else {
							setBoundaryFillColour(getFillColourValue);
							setBoundaryBorderColour(getBorderColourValue);
						}
					});

	// Clear the current selection when the drawing mode is changed, or when the
	// map is clicked.
	google.maps.event.addListener(drawingManager, 'drawingmode_changed',
			clearBoundarySelection);
	google.maps.event.addListener(map, 'click', clearBoundarySelection);
	// Disables drawing mode on startup so you have to click on toolbar first to
	// draw shapes and create the colour palette
	drawingManager.setDrawingMode(null);
	// buildColorPalette();
}

var longpress = false;
var start;
var boundarySelected = false;
function drawPolygons(location) {
	var arrayBoundary = getArrayBoundary(location.boundary).split("_");
	var CoordinatesArray = new Array();
	for ( var i = 0; i < arrayBoundary.length; i++) {
		var LatAndLng = arrayBoundary[i].split(",");
		var Lat = LatAndLng[0];
		var Lng = LatAndLng[1];
		var LatLng = new google.maps.LatLng(Lat, Lng);
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
		if (longpress) {
			$("#parentLocationId").val(location.locationID);
			getAllMarkers(location.locationID + "", true);
			// restricting map when working in an area
			minZoomLevel = 16;
			map.setZoom(minZoomLevel);
			// Limit the zoom level
			google.maps.event.addListener(map, 'zoom_changed', function() {
				if (map.getZoom() < minZoomLevel)
					map.setZoom(minZoomLevel);
			});

		} else {
			if (boundarySelected) { // boundary selected
				if (DRAWPolygon == selectedShape) {
					clearBoundarySelection();
				} else { // previous boundary selected but now selecting new
							// boundary
					setBoundarySelection(DRAWPolygon);
					addAMarker(location, location.gps);
				}
			} else { // boundary not selected
				setBoundarySelection(DRAWPolygon);
				addAMarker(location, location.gps);
			}
		}
		$('#editBoundary').on('click', function() {
			editPolygon(DRAWPolygon);
		});
	});

	google.maps.event.addListener(DRAWPolygon, 'mousedown', function(event) {
		start = new Date().getTime();
	});
	google.maps.event.addListener(DRAWPolygon, 'mouseup', function(event) {
		end = new Date().getTime();
		longpress = (end - start < 500) ? false : true;
	});
	polygons.push(DRAWPolygon);
}

function getArrayBoundary(boundary) {
	var locationWithColourArray = boundary.split(";");
	var arrayBoundary = locationWithColourArray[0];
	return arrayBoundary;
}

function getBoundaryColour(boundary) {
	if (boundary.length <= 1)
		return;
	var locationWithColourArray = boundary.split(";");
	if (locationWithColourArray.length <= 1)
		return "";
	var boundaryColour = locationWithColourArray[1].split(",");
	return boundaryColour;
}

function deletePolygon() {
	alert("This feature is disabled");
	// var id = $("#markerId").val();
	// for ( var i = 0; i < polygons.length; i++) {
	// if (polygons[i].id == id) {
	// polygons[i].setMap(null);
	// polygons.splice(i, 1);
	// return;
	// }
	// }
}

function setMapOnAllPolygons(map) {
	for ( var i = 0; i < polygons.length; i++) {
		polygons[i].setMap(map);
	}
}

var drawingManager;
var selectedShape;
// var colors = [ '#1E90FF', '#FF1493', '#32CD32', '#FF8C00', '#4B0082',
// '#FFFFFF', '#C0C0C0', '#808080', '#000000', '#FF0000', '#800000',
// '#FFFF00', '#808000', '#00FF00', '#008000', '#00FFFF', '#008080',
// '#0000FF', '#000080', '#FF00FF', '#800080' ];
// var selectedColor;
// var colorButtons = {};

function setDrawingMode() {
	drawingManager.setDrawingMode(google.maps.drawing.OverlayType.POLYGON);
}

function removeDrawingMode() {
	drawingManager.setDrawingMode(null);
}

function clearBoundarySelection() {
	if (selectedShape) {
		if (selectedShape.type !== 'marker') {
			selectedShape.setEditable(false);
		}

		selectedShape = null;
	}
	$("#tempBoundaryColors").val("");
	$("#boundary").val("");
	boundarySelected = false;
}

function unselectBoundary() {
	if (selectedShape) {
		if (selectedShape.type !== 'marker') {
			selectedShape.setEditable(false);
		}

		selectedShape = null;
	}
	boundarySelected = false;
}

function setBoundarySelection(shape) {
	if (shape.type !== 'marker') {
		clearBoundarySelection();
		// shape.setEditable(true);
		// selectColor(shape.get('fillColor') || shape.get('strokeColor'));
	}

	selectedShape = shape;
	boundarySelected = true;
}

function editPolygon(shape) {
	if (shape.type !== 'marker') {
		unselectBoundary();
		shape.setEditable(true);
	}

	selectedShape = shape;
	boundarySelected = true;
}

function deleteSelectedShape() {
	var c = confirm("Are you sure you want to delete this polygon?");
	if (c == true) {
		selectedShape.setMap(null);
		$("#boundary").val("");
	} else {
	}
}

// function selectColor(color) {
// selectedColor = color;
// for ( var i = 0; i < colors.length; ++i) {
// var currColor = colors[i];
// colorButtons[currColor].style.border = '2px solid #fff';
// }
//
// // Retrieves the current options from the drawing manager and replaces the
// // stroke or fill color as appropriate.
// var polylineOptions = drawingManager.get('polylineOptions');
// polylineOptions.strokeColor = color;
// drawingManager.set('polylineOptions', polylineOptions);
//
// var rectangleOptions = drawingManager.get('rectangleOptions');
// rectangleOptions.fillColor = color;
// drawingManager.set('rectangleOptions', rectangleOptions);
//
// var circleOptions = drawingManager.get('circleOptions');
// circleOptions.fillColor = color;
// drawingManager.set('circleOptions', circleOptions);
//
// var polygonOptions = drawingManager.get('polygonOptions');
// polygonOptions.fillColor = color;
// drawingManager.set('polygonOptions', polygonOptions);
// }
//
// function setSelectedShapeColor(color) {
// if (selectedShape) {
// if (selectedShape.type == google.maps.drawing.OverlayType.POLYLINE) {
// selectedShape.set('strokeColor', color);
// } else {
// selectedShape.set('fillColor', color);
// }
// }
// }
//
// function makeColorButton(color) {
// var button = document.createElement('span');
// button.className = 'color-button';
// button.style.backgroundColor = color;
// google.maps.event.addDomListener(button, 'click', function() {
// selectColor(color);
// setSelectedShapeColor(color);
// });
//
// return button;
// }
//
// function buildColorPalette() {
// var colorPalette = document.getElementById('color-palette');
// for ( var i = 0; i < colors.length; ++i) {
// var currColor = colors[i];
// var colorButton = makeColorButton(currColor);
// colorPalette.appendChild(colorButton);
// colorButtons[currColor] = colorButton;
// }
// selectColor(colors[0]);
// }

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
			updateFillColourValue(hex);
			if (selectedShape) {
				setBoundaryFillColour('#' + hex);
			}
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
			updateBorderColourValue(hex);
			if (selectedShape) {
				setBoundaryBorderColour('#' + hex);
			}
		}
	});
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
	return FillColour;
}

function getBorderColourValue() {
	var boundaryColour = $("#tempBoundaryColors").val().split(",");
	var BorderColour = boundaryColour[1];
	return BorderColour;
}