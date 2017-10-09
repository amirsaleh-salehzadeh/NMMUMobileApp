var styles = [ {
	featureType : "administrative",
	elementType : "labels",
	stylers : [ {
		visibility : "off"
	} ]
}, {
	featureType : "poi",
	elementType : "labels",
	stylers : [ {
		visibility : "off"
	} ]
}, {
	featureType : "road",
	elementType : "labels",
	stylers : [ {
		visibility : "off"
	} ]
}, {
	featureType : "transit.station",
	elementType : "labels",
	stylers : [ {
		visibility : "off"
	} ]
}, {
	featureType : "water",
	elementType : "labels",
	stylers : [ {
		visibility : "off"
	} ]
}, {
	featureType : "landscape.man_made",
	elementType : "geometry",
	stylers : [ {
		color : "#efe6cc" // #f7f1df
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
		visibility : "on"
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

var sattelStyle = [ {
	featureType : "administrative",
	elementType : "labels",
	stylers : [ {
		visibility : "off"
	} ]
}, {
	featureType : "poi",
	elementType : "labels",
	stylers : [ {
		visibility : "off"
	} ]
}, {
	featureType : "road",
	elementType : "labels",
	stylers : [ {
		visibility : "off"
	} ]
}, {
	featureType : "transit.station",
	elementType : "labels",
	stylers : [ {
		visibility : "off"
	} ]
}, {
	featureType : "water",
	elementType : "labels",
	stylers : [ {
		visibility : "off"
	} ]
}, {
	featureType : "landscape.man_made",
	elementType : "geometry",
	stylers : [ {
		color : "#efe6cc" // #f7f1df
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
		visibility : "on"
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

function initiMap() {
	speed = 0;
	heading = 0;

	var styledMap = new google.maps.StyledMapType(styles, {
		name : "Styled Map"
	});

	map = new google.maps.Map(document.getElementById('map_canvas'), {
		center : {
			lat : -34.009211,
			lng : 25.669051
		},
		zoom : 14,
		zoomControl : false,
		streetViewControl : false,
		mapTypeControl : false,
		rotateControl : false,
		fullscreenControl : false,
		labels : true
	// ,
	});
	// map.mapTypes.set('mystyle', new google.maps.StyledMapType(myStyle, {
	// name : 'My Style'
	// }));
	map.mapTypes.set('map_style', styledMap);
	map.setMapTypeId('map_style');
	input = document.getElementById('to');
//	map.controls[google.maps.ControlPosition.LEFT_CENTER].push(document
//			.getElementById('zoomSettings'));
	map.controls[google.maps.ControlPosition.LEFT_TOP].push(document
			.getElementById('menuBTNLeftSideDiv'));
//	map.controls[google.maps.ControlPosition.LEFT_TOP].push(document
//			.getElementById('searchBarDivTop'));
	map.controls[google.maps.ControlPosition.LEFT_TOP].push(document
			.getElementById('menuItems'));
	map.setMapTypeId('map_style');
	findMyLocation();
	$("#mapViewIcon").fadeOut();
	selectMapMode();
	// getLocationTypePanel();
	if (getCookie("TripPathGPSCookie") != "")
		getThePath();
	else
		showViewItems();
	mapSattelView();
}

function zoomInMap() {
	var zoom = map.getZoom();
	zoom++;
	map.setZoom(zoom);
}

function zoomOutMap() {
	var zoom = map.getZoom();
	zoom--;
	map.setZoom(zoom);
}

function mapSattelView() {
	map.setMapTypeId(google.maps.MapTypeId.SATELLITE);
	$("#satelliteView").fadeOut();
	$("#mapViewIcon").fadeIn();
	showHideLeftSideMenu();
}

function mapMapView() {
	map.setMapTypeId('map_style');
	$("#satelliteView").fadeIn();
	$("#mapViewIcon").fadeOut();
	showHideLeftSideMenu();
}

function selectDualMode() {
	$("#zoomSettings").css("display", "block");
	$("#cameraView").css("display", "block");
	$("#cameraView").css("position", "absolute");
	// $("#mapView").css("display", "block");
	$('#cameraView').height($(window).height() / 4);
	$('#videoContent').height($(window).height() / 4);
	$('#cameraView').width($(window).width() / 4);
	$('#videoContent').width($(window).width() / 4);
	$('#dualModeSelect').fadeOut();
	$('#mapViewSelect').fadeIn();
	stopCamera();
	startCamera();
//	findMyLocation();
	showHideLeftSideMenu();
}

// TO SELECT MAP MODE OR AR MODE
function selectMapMode() {
	// $("#cameraView").css("display", "none");
	// $('#mapView').height($(window).height());
	// $('#map_canvas').height($(window).height());
	$('#mapViewSelect').fadeOut();
	$('#dualModeSelect').fadeIn();
	stopCamera();
//	findMyLocation();
	showHideLeftSideMenu();
	showHideLeftSideMenu();
}

function showViewItems() {
	if (getCookie("TripPathGPSCookie") == "") {
		$("#barcodeDescription").fadeOut();
		$("#currentLocationShow").fadeOut();
		$("#searchBarDivTop").fadeIn();
	} else {
		$("#barcodeDescription").fadeIn();
		$("#currentLocationShow").fadeIn();
		$("#searchBarDivTop").fadeOut();
	}
}

function showHideLeftSideMenu() {
//	$("#start").css('display', 'block');
	if ($("#menuItems").css("display") == "none")
		$("#menuItems").fadeIn();
	else
		$("#menuItems").fadeOut();
}

function hideBottomPanel() {
	$("#locationInfoDiv").animate({
		bottom : "-=" + $("#locationInfoDiv").height()
	}, 1500);
	setTimeout(function() {
		// $("#locationInfoDiv").css('bottom','-' +
		// $("#locationInfoDiv").height()).trigger("create");
		$("#locationInfoDiv").css('display', 'none');
	}, 1500);
}

function showBottomPanel() {
	$("#start").css('display', 'block');
	$("#locationInfoDiv").css('display', 'block').trigger("create");
	$("#locationInfoDiv").css('bottom', '-' + $("#locationInfoDiv").height());
	$("#locationInfoDiv").animate({
		bottom : "0"
	}, 1500);
}