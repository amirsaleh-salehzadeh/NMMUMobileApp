function createDrawingManager(){
	var polyOptions = {
	    strokeWeight: 0,
	    fillOpacity: 0.45,
	    editable: true,
	    draggable: false
	};
	    // Creates a drawing manager attached to the map that allows the user to draw
	    // markers, lines, and shapes.
	drawingManager = new google.maps.drawing.DrawingManager({
	drawingMode: google.maps.drawing.OverlayType.POLYGON,
	drawingControl: false,
	drawingControlOptions: {
	    style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
	    position: google.maps.ControlPosition.TOP_CENTER,
//	    drawingModes: ['marker', 'circle', 'polygon', 'polyline', 'rectangle']
	    drawingModes: ['polygon']
	},
	markerOptions: {
	    draggable: false
	},
	polylineOptions: {
	    editable: true,
	    draggable: false
	},
	rectangleOptions: polyOptions,
	circleOptions: polyOptions,
	polygonOptions: polyOptions,
	map: map
	});
	    
	google.maps.event.addListener(drawingManager, 'overlaycomplete', function (e) {
		var newShape = e.overlay;
	    newShape.type = e.type;
	    //The getPolygonCoords function must be called here, because it is called right after the whole polygon is created
	    //alert(getPolygonCoords(newShape));
	    google.maps.event.addListener(newShape, "mouseup", function(event){
	    	$("#boundary").val(getPolygonCoords(newShape));
//		    alert(newShape.getPath().getArray());
		});
	    $("#boundary").val(getPolygonCoords(newShape));
	    alert("The boundary has been saved.");
	    //$('#insertAMarker').popup('open');
	    if (e.type !== google.maps.drawing.OverlayType.MARKER) {
	        // Switch back to non-drawing mode after drawing a shape.
	    	drawingManager.setDrawingMode(null);
	        // Add an event listener that selects the newly-drawn shape when the user
	        // mouses down on it.
	    	google.maps.event.addListener(newShape, 'click', function (e) {
	    		if (e.vertex !== undefined) {
	    			if (newShape.type === google.maps.drawing.OverlayType.POLYGON) {
	    				var path = newShape.getPaths().getAt(e.path);
	    				path.removeAt(e.vertex);
	    				if (path.length < 3) {
	    					newShape.setMap(null);
	    				}
	                }
	                if (newShape.type === google.maps.drawing.OverlayType.POLYLINE) {
	                	var path = newShape.getPath();
	                    path.removeAt(e.vertex);
	                    if (path.length < 2) {
	                    	newShape.setMap(null);
	                    }
	                }
	            }
	        	setSelection(newShape);
	    	});
	            setSelection(newShape);
	     }
	     else {
	    	 google.maps.event.addListener(newShape, 'click', function (e) {
	    		 setSelection(newShape);
	         });
	         setSelection(newShape);
	     }
	});
	    
	// Clear the current selection when the drawing mode is changed, or when the
	// map is clicked.
	google.maps.event.addListener(drawingManager, 'drawingmode_changed', clearSelection);
	google.maps.event.addListener(map, 'click', clearSelection);
//	google.maps.event.addDomListener(document.getElementById('delete-button'), 'click', deleteSelectedShape);
	//Disables drawing mode on startup so you have to click on toolbar first to draw shapes and create the colour palette
	drawingManager.setDrawingMode(null);
	buildColorPalette();
}

var longpress = false;
var start;
function drawPolygons(location) {
	var array = location.boundary.split("_");
	var CoordinatesArray = new Array();
	for ( var i = 0; i <= array.length - 1; i++) {
		var string = array[i];
		var pos = string.indexOf(",");
		var length = string.length;
		var Lat = string.slice(0, pos);
		var Lng = string.slice(pos + 1, length);
		var LatLng = new google.maps.LatLng(Lat, Lng);
		CoordinatesArray.push(LatLng);
	}
	;
	var DRAWPolygon = new google.maps.Polygon({
		paths : CoordinatesArray,
		strokeColor : '#1E90FF',
		strokeWeight : 2,
		fillColor : '#1E90FF',
		title : location.locationName + " "
				+ location.locationType.locationType
	});
	DRAWPolygon.setMap(map);
	DRAWPolygon.id = location.locationID;
	google.maps.event.addListener(DRAWPolygon, 'click', function(event) {
		if (longpress) {
			$("#parentLocationId").val(location.locationID);
			$("#parentDescriptionToAdd")
					.html(location.locationName + " Campus");
			getAllPaths();
			getAllMarkers(location.locationID + "");
		} else {
			addAMarker(location, location.gps);
		}
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

//function deletePolygon(id) {
//	for ( var i = 0; i < polygons.length; i++) {
//		if (polygons[i].id == id) {
//			polygons[i].setMap(null);
//			polygons.splice(i, 1);
//			return;
//		}
//	}
//}

function deletePolygon() {
	var id = $("#parentLocationId").val();
	for ( var i = 0; i < polygons.length; i++) {
		if (polygons[i].id == id) {
			polygons[i].setMap(null);
			polygons.splice(i, 1);
			return;
		}
	}
}

function setMapOnAllpoligons(map) {
	for ( var i = 0; i < polygons.length; i++) {
		polygons[i].setMap(map);
	}
}

var drawingManager;
var selectedShape;
var colors = [ '#1E90FF', '#FF1493', '#32CD32', '#FF8C00', '#4B0082',
		'#FFFFFF', '#C0C0C0', '#808080', '#000000', '#FF0000', '#800000',
		'#FFFF00', '#808000', '#00FF00', '#008000', '#00FFFF', '#008080',
		'#0000FF', '#000080', '#FF00FF', '#800080' ];
var selectedColor;
var colorButtons = {};

function setDrawingMode() {
	drawingManager.setDrawingMode(google.maps.drawing.OverlayType.POLYGON);
}

function removeDrawingMode() {
	drawingManager.setDrawingMode(null);
}

function clearSelection() {
	if (selectedShape) {
		if (selectedShape.type !== 'marker') {
			selectedShape.setEditable(false);
		}

		selectedShape = null;
	}
}

function setSelection(shape) {
	if (shape.type !== 'marker') {
		clearSelection();
		shape.setEditable(true);
		selectColor(shape.get('fillColor') || shape.get('strokeColor'));
	}

	selectedShape = shape;
}

function deleteSelectedShape() {
	var c = confirm("Are you sure you want to delete this polygon?");
	if (c == true) {
		selectedShape.setMap(null);
		$("#boundary").val("");
	} else {
	}
}

function selectColor(color) {
	selectedColor = color;
	for ( var i = 0; i < colors.length; ++i) {
		var currColor = colors[i];
		colorButtons[currColor].style.border = '2px solid #fff';
	}

	// Retrieves the current options from the drawing manager and replaces the
	// stroke or fill color as appropriate.
	var polylineOptions = drawingManager.get('polylineOptions');
	polylineOptions.strokeColor = color;
	drawingManager.set('polylineOptions', polylineOptions);

	var rectangleOptions = drawingManager.get('rectangleOptions');
	rectangleOptions.fillColor = color;
	drawingManager.set('rectangleOptions', rectangleOptions);

	var circleOptions = drawingManager.get('circleOptions');
	circleOptions.fillColor = color;
	drawingManager.set('circleOptions', circleOptions);

	var polygonOptions = drawingManager.get('polygonOptions');
	polygonOptions.fillColor = color;
	drawingManager.set('polygonOptions', polygonOptions);
}

function setSelectedShapeColor(color) {
	if (selectedShape) {
		if (selectedShape.type == google.maps.drawing.OverlayType.POLYLINE) {
			selectedShape.set('strokeColor', color);
		} else {
			selectedShape.set('fillColor', color);
		}
	}
}

function makeColorButton(color) {
	var button = document.createElement('span');
	button.className = 'color-button';
	button.style.backgroundColor = color;
	google.maps.event.addDomListener(button, 'click', function() {
		selectColor(color);
		setSelectedShapeColor(color);
	});

	return button;
}

function buildColorPalette() {
	var colorPalette = document.getElementById('color-palette');
	for ( var i = 0; i < colors.length; ++i) {
		var currColor = colors[i];
		var colorButton = makeColorButton(currColor);
		colorPalette.appendChild(colorButton);
		colorButtons[currColor] = colorButton;
	}
	selectColor(colors[0]);
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
