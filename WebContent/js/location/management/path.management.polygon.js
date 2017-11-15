function addPolygon() {
	$('#insertAMarker').popup('close');
}

// this draws static polygon on map, this function is used in path.navigation.js
// but its commented out under function initimap
function drawPolygons(coordinates, location) {
	var array = coordinates.split("_");
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
	});
	google.maps.event.addListener(DRAWPolygon, 'click', function(event) {
		$("#markerId").val(location.locationID);
		$("#markerName").val(location.locationName);
		$("#markerCoordinate").val(location.gps);
		$("#croppedIcon").attr("src", location.icon);
		$("#icon").val(location.icon);
		$("#parentLocationId").val(location.parentId);
		$("#markerLabel").html(location.locationType.locationType);
		$("#locationDescription").val(location.description);
		$("#locationTypeId").val(location.locationType.locationTypeId);
	});
	DRAWPolygon.setMap(map);
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
	} else {
	}
}

function selectColor(color) {
	selectedColor = color;
	for ( var i = 0; i < colors.length; ++i) {
		var currColor = colors[i];
		colorButtons[currColor].style.border = currColor == color ? '2px solid #789'
				: '2px solid #fff';
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

function getPolygonCoords(newShape) {
	var len = newShape.getPath().getLength();
	var coordinates = "";
	for ( var i = 0; i < len; i++) {
		coordinates = coordinates + newShape.getPath().getAt(i).lat() + ","
				+ newShape.getPath().getAt(i).lng();
		if (i !== len - 1) {
			coordinates = coordinates + "_";
		}
	}
	// alert("The co-ordinates are: " + coordinates);
	return coordinates;
}

function showArrays(newShape, LatLng) {
	// Since this polygon has only one path, we can call getPath() to return the
	// MVCArray of LatLngs.
	var vertices = newShape.getPath();

	var contentString = '<div id="InfoWindow">'
			+ '<b>Polygon Co-Ordinates</b><br>' + 'Clicked location: <br>'
			+ LatLng.lat() + ',' + LatLng.lng() + '<br>';

	// Iterate over the vertices.
	for ( var i = 0; i < vertices.getLength(); i++) {
		var xy = vertices.getAt(i);
		contentString += '<br>' + 'Coordinate ' + i + ':<br>' + xy.lat() + ','
				+ xy.lng();
	}

	contentString += '</div>';

	// Replace the info window's content and position.
	var infoWindow = new google.maps.InfoWindow;
	infoWindow.setContent(contentString);
	// var LatLng = new google.maps.LatLng(-34.008559,25.668914);
	infoWindow.setPosition(LatLng);

	infoWindow.open(map);
}