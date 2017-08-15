function addPolygon () {
	$("#insertAMarker").css("z-index", "-1");
}	
function drawPolygons () // this draws static polygon on map, this function is used in path.navigation.js but its commented out under function initimap
{
	//map = new google.maps.Map(document.getElementById('map_canvas'), { });
	// Define the LatLng coordinates for the polygon's path.
	  var testCoords = [
	    {lat: -34.008559, lng: 25.668914},
	    {lat: -34.008552, lng: 25.669260},
	    {lat: -34.008672, lng: 25.669276},
	    {lat: -34.008794, lng: 25.669281},
	    {lat: -34.008791, lng: 25.668887},
	    {lat: -34.008607, lng: 25.668893},
	    {lat: -34.008559, lng: 25.668914}
	  ];

	  // Construct the polygon.
	  var testPolygon = new google.maps.Polygon({
	    paths: testCoords,
	    strokeColor: '#FF0000',
	   // strokeOpacity: 0.8,
	    strokeWeight: 2,
	    fillColor: '#FF0000',
	   // fillOpacity: 0.35
	  });
	  testPolygon.setMap(map);
}

var drawingManager;
var selectedShape;
//var colors = ['#1E90FF', '#FF1493', '#32CD32', '#FF8C00', '#4B0082'];
var colors =['#1E90FF', '#FF1493', '#32CD32', '#FF8C00', '#4B0082','#FFFFFF', '#C0C0C0', '#808080', '#000000', '#FF0000','#800000','#FFFF00','#808000','#00FF00','#008000','#00FFFF','#008080','#0000FF','#000080','#FF00FF','#800080'];
var selectedColor;
var colorButtons = {};

function clearSelection () {
    if (selectedShape) {
        if (selectedShape.type !== 'marker') {
            selectedShape.setEditable(false);
        }
        
        selectedShape = null;
    }
}

function setSelection (shape) {
    if (shape.type !== 'marker') {
        clearSelection();
        shape.setEditable(true);
        selectColor(shape.get('fillColor') || shape.get('strokeColor'));
    }
    
    selectedShape = shape;
}

function deleteSelectedShape () {
	var c = confirm("Are you sure you want to delete this polygon?");
    if (c==true) {
        selectedShape.setMap(null);
        }
        else{
        }
}

function selectColor (color) {
    selectedColor = color;
    for (var i = 0; i < colors.length; ++i) {
        var currColor = colors[i];
        colorButtons[currColor].style.border = currColor == color ? '2px solid #789' : '2px solid #fff';
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

function setSelectedShapeColor (color) {
    if (selectedShape) {
        if (selectedShape.type == google.maps.drawing.OverlayType.POLYLINE) {
            selectedShape.set('strokeColor', color);
        } else {
            selectedShape.set('fillColor', color);
        }
    }
}

function makeColorButton (color) {
    var button = document.createElement('span');
    button.className = 'color-button';
    button.style.backgroundColor = color;
    google.maps.event.addDomListener(button, 'click', function () {
        selectColor(color);
        setSelectedShapeColor(color);
    });

    return button;
}

function buildColorPalette () {
    var colorPalette = document.getElementById('color-palette');
    for (var i = 0; i < colors.length; ++i) {
        var currColor = colors[i];
        var colorButton = makeColorButton(currColor);
        colorPalette.appendChild(colorButton);
        colorButtons[currColor] = colorButton;
    }
    selectColor(colors[0]);
}

function getPolygonCoords(newShape) {
	var len = newShape.getPath().getLength();
    var htmlStr = "";
    for (var i = 0 ; i < len ; i++) {
         htmlStr = htmlStr + newShape.getPath().getAt(i).lat() + "," + newShape.getPath().getAt(i).lng();
         if (i !== len-1)
         { htmlStr = htmlStr + "_";}
     }
    //alert("The co-ordinates are: " + htmlStr);
    return htmlStr;
}  