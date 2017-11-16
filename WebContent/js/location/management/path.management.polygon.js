  	function addPolygon () {
		$('#insertAMarker').popup('close');
	}	
	function drawPolygons (coordinates)
	{
		  var array = coordinates.split("_");
		  var CoordinatesArray = new Array();
		  for(var i=0; i <= array.length-1; i++){
			  var string = array[i];
			  var pos = string.indexOf(",");
			  var length = string.length;
			  var Lat = string.slice(0,pos);
			  var Lng = string.slice(pos+1,length);
			  var LatLng = new google.maps.LatLng(Lat,Lng);
			  CoordinatesArray.push(LatLng);
		  };
		  
		  // drawPolygons($("#boundary").val());
		                   
		  // Construct the polygon.
		  var DRAWPolygon = new google.maps.Polygon({
		    paths: CoordinatesArray,
		    strokeColor: '#1E90FF',
//		    strokeOpacity: 0.8,
		    strokeWeight: 2,
		    fillColor: '#1E90FF',
//		    fillOpacity: 0.35,
//		    editable: true
		  });
		  DRAWPolygon.setMap(map);
		  google.maps.event.addListener(DRAWPolygon, 'click', function() {
	            setSelection(DRAWPolygon);
	        });
	}

	var drawingManager;
	var selectedShape;
	var colors =['#1E90FF', '#FF1493', '#32CD32', '#FF8C00', '#4B0082','#FFFFFF', '#C0C0C0', '#808080', '#000000', '#FF0000','#800000','#FFFF00','#808000','#00FF00','#008000','#00FFFF','#008080','#0000FF','#000080','#FF00FF','#800080'];
	var selectedColor;
	var colorButtons = {};

	function setDrawingMode() {
		drawingManager.setDrawingMode(google.maps.drawing.OverlayType.POLYGON);
	}

	function removeDrawingMode () {
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

	function setSelection (shape) {
	    if (shape.type !== 'marker') {
	        clearSelection();
	        shape.setEditable(true);
	        selectColor(shape.get('fillColor') || shape.get('strokeColor'));
	    }
	    
	    selectedShape = shape;
//	    alert(shape.getPath().getArray());
//	    alert(selectedShape.getPath().getArray());
//	    google.maps.event.addListener(selectedShape, "mouseup", function(event){
//	    	//$("#boundary").val(overlay.getPath().getArray());
//	    	alert(selectedShape.getPath().getArray());
//	    });
//	    google.maps.event.addListener(shape, "mouseup", function(event){
//	    	//$("#boundary").val(overlay.getPath().getArray());
//	    	alert(shape.getPath().getArray());
//	    });
	    
//	    var Lat = shape.getPath().getAt(0).lat();
//	    var Lng = shape.getPath().getAt(0).lng(); 
//	    showBoundaryEdit(shape,Lat,Lng);
	}

	function deleteSelectedShape () {
		var c = confirm("Are you sure you want to delete this polygon?");
	    if (c==true) {
	        selectedShape.setMap(null);
	        $("#boundary").val("");
	        }
	        else{
	        }
	}

	function selectColor (color) {
	    selectedColor = color;
	    for (var i = 0; i < colors.length; ++i) {
	        var currColor = colors[i];
//	        colorButtons[currColor].style.border = currColor == color ? '2px solid #789' : '2px solid #fff';
//	        colorButtons[currColor].style.border = currColor == color ? '2px solid #fff' : '2px solid #333';
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

	function getPolygonCoords(shape) {
		var len = shape.getPath().getLength();
	    var coordinates = "";
	    for (var i = 0 ; i < len ; i++) {
	    	coordinates = coordinates + shape.getPath().getAt(i).lat() + "," + shape.getPath().getAt(i).lng();
	         if (i !== len-1)
	         { coordinates = coordinates + "_";}
	     }
	    return coordinates;
	}  

	function showBoundaryEdit(shape,Lat,Lng) {
	    // Since this polygon has only one path, we can call getPath() to return the
	    // MVCArray of LatLngs.
	    var vertices = shape.getPath();

	    var contentString = '<div id="InfoWindow"><b>This boundary belongs to the following building</b><br>' + $("#markerName").val() + '<br>';

	    // Iterate over the vertices.
	    for (var i =0; i < vertices.getLength(); i++) {
	      var xy = vertices.getAt(i);
	      contentString += '<br>' + 'Coordinate ' + i + ':<br>' + xy.lat() + ',' +
	          xy.lng();
	    }
	    
//	    var div = document.createElement("div");
//	    div.innerHTML = contentString;
//	    div.appendChild(); 
	    
	    contentString = contentString + '<div id="color-palette"></div><br><button id="delete-button">Delete Selected Shape</button></div>';
	    
	    // Replace the info window's content and position.
	    var infoWindow = new google.maps.InfoWindow;
	    infoWindow.setContent(contentString);
	    var LatLng = new google.maps.LatLng(Lat,Lng);
	    infoWindow.setPosition(LatLng);
	    infoWindow.open(map);
	  }