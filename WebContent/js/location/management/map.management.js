var map, marker, infoWindow;
var markers = [];
var paths = [];
var polygons = [];
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

function refreshMap(locationTypeId, gpsStr, folderName) {
	var gps = {
		lat : parseFloat(gpsStr.split(",")[0]),
		lng : parseFloat(gpsStr.split(",")[1])
	};
	var icon = 'images/map-markers/'+ folderName + '/';
	if (locationTypeId == "1") {
		icon += 'marker-blue.png';
	} else if (locationTypeId == "11") {
		icon += 'door.png';
	} else if (locationTypeId == "2") {
		icon += 'area.png';
		map.setCenter(gps);
		map.setZoom(15);
	} else if (locationTypeId == "3") {
		icon += 'buildingss.png';
		map.setCenter(gps);
		// map.setZoom(15);
	} else if (locationTypeId == "4") {
		icon += 'marker-pink.png';
		map.setCenter(gps);
		// map.setZoom(19);
	} else if (locationTypeId == "5") {
		// icon += 'crossroad48.png';
		icon = {
			path : google.maps.SymbolPath.CIRCLE,
			scale : 4,
			fillOpacity: 1
		};
		if(folderName.indexOf("hover")!=-1)
			icon = {
				path : google.maps.SymbolPath.CIRCLE,
				scale : 16,
				fillOpacity: 1
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

function initMap() {
	setPathTypeButtonIcon();
	getPathTypePanel();
	getAllMarkers("360");
	$("#parentLocationId").val("360");
	var myLatLng = {
			lat : -33.5343803,
			lng : 24.2683424
	};

	map = new google.maps.Map(document.getElementById('map_canvas'), {
		fullscreenControl : false,
		streetViewControl : false,
		mapTypeControl: false,
		scrollwheel : true,
		disableDoubleClickZoom: true,
		gestureHandling : 'greedy'
//        styles: myStyle
	});
	map.mapTypes.set('mystyle', new google.maps.StyledMapType(myStyle, {
		name : 'My Style'
	}));
	map.setMapTypeId('mystyle');
	map.setCenter(myLatLng);
	map.controls[google.maps.ControlPosition.RIGHT_TOP].push(document
			.getElementById('locationsUnderAType'));
	map.controls[google.maps.ControlPosition.TOP_CENTER].push(document
			.getElementById('editBoundaryPopup'));
//	map.controls[google.maps.ControlPosition.TOP_CENTER].push(document
//			.getElementById('pathTypePopup'));
	google.maps.event.addListener(map, "click", function(event) {
		$("#departure").val("");
		$("#departureId").val("");
		$("#destination").val("");
		$("#destinationId").val("");
		$("#boundary").val("");
		var lat = event.latLng.lat();
		var lng = event.latLng.lng();
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			addAMarker(null, lat + "," + lng);
		} else {
			addAPath(null);
		}
	});

	map.setOptions({
		draggableCursor : 'corsshair'
	});

	createDrawingManager();
	createColorPicker();
	
	google.maps.LatLng.prototype.kmTo = function(a) {
		var e = Math, ra = e.PI / 180;
		var b = this.lat() * ra, c = a.lat() * ra, d = b - c;
		var g = this.lng() * ra - a.lng() * ra;
		var f = 2 * e.asin(e.sqrt(e.pow(e.sin(d / 2), 2) + e.cos(b) * e.cos(c)
				* e.pow(e.sin(g / 2), 2)));
		return f * 6378.137;
	};

	google.maps.Polyline.prototype.inKm = function(n) {
		var a = this.getPath(n), len = a.getLength(), dist = 0;
		for ( var i = 0; i < len - 1; i++) {
			dist += a.getAt(i).kmTo(a.getAt(i + 1));
		}
		return dist;
	};
	getAllLocationTypes();
}