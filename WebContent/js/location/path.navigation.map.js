function initiateNavigation() {
	if ($("#destinationId").val() == "") {
		alert("To start a trip, please select a destination first.");
		if (parseInt($('#searchBarDiv').css("right")) < -10) {
			openCloseSearch();
		}
		return;
	}
	if (getCookie("TripPathGPSCookie") == "")
		$('#popupPathType').popup('open').trigger('create');
	else
		showViewItems();
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
	map.setMapTypeId(google.maps.MapTypeId.HYBRID);
	$("#satelliteView").fadeOut();
	$("#mapViewIcon").fadeIn();
}

function mapMapView() {
	map.setMapTypeId('mystyle');
	$("#satelliteView").fadeIn();
	$("#mapViewIcon").fadeOut();
}

function openCloseSearch() {
	if (parseInt($('#searchBarDiv').css("right")) < -10) {
		$('#searchBarDiv').animate({
			'right' : '0'
		}, 500);
	} else {
		$('#searchBarDiv').animate({
			'right' : '-100%'
		}, 500);
	}
	$("#autocompleteContainer").css("bottom", "44");
	$("#searchBarDiv").trigger("updatelayout");
}

function selectDualMode() {
	$("#zoomSettings").css("display", "block");
	$("#cameraView").css("display", "block");
	$("#cameraView").css("position", "absolute");
	$("#mapView").css("display", "block");
	$('#cameraView').height($(window).height() / 4);
	$('#videoContent').height($(window).height() / 4);
	$('#cameraView').width($(window).width() / 4);
	$('#videoContent').width($(window).width() / 4);
	$('#dualModeSelect').fadeOut();
	$('#mapViewSelect').fadeIn();
	stopCamera();
	startCamera();
	findMyLocation();
}

function selectMapMode() {
	$("#cameraView").css("display", "none");
	// $('#mapView').height($(window).height());
	// $('#map_canvas').height($(window).height());
	$('#mapViewSelect').fadeOut();
	$('#dualModeSelect').fadeIn();
	stopCamera();
	findMyLocation();
}
function arrivalPopup(gps) {
	var url = "REST/GetLocationWS/SearchForALocation?userName=NMMU" + "&gps="
			+ gps;
	$.ajax({
		url : url,
		cache : true,
		async : true,
		success : function(data) {
			$.each(data, function(k, l) {
				$('#currentTime').val(Date());
				$('#currentLocationName').val(l.locationName);
				$('#popupCurrentLocation').popup('open');
			});
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});
}

function showViewItems() {
	if (getCookie("TripPathGPSCookie") == "") {
		$("#barcodeDescription").fadeOut();
		$("#destinationShow").fadeOut();
		$("#compassID").fadeOut();
		$("#directionShow").fadeOut();
		$("#start").fadeIn();
		$("#remove").fadeOut();
	} else {
//		getThePath();
		$("#start").fadeOut();
		$("#remove").fadeIn();
		$("#barcodeDescription").fadeIn();
		$("#destinationShow").fadeIn();
		$("#compassID").fadeIn();
		$("#directionShow").fadeIn();
	}
}