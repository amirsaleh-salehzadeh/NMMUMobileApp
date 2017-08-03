function initiateNavigation() {
	var bounds = new google.maps.LatLngBounds();
	bounds.extend(markerDest.getPosition());
	bounds.extend(marker.getPosition());
	map.fitBounds(bounds);
	// if (getCookie("TripPathGPSCookie") == ""){
	// $('#popupPathType').popup();
	// $('#popupPathType').popup('open').trigger('create');
	// }
	// else
	// showViewItems();
	getThePath();
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
	map.setMapTypeId('map_style');
	$("#satelliteView").fadeIn();
	$("#mapViewIcon").fadeOut();
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

// TO SELECT MAP MODE OR AR MODE
function selectMapMode() {
	// $("#cameraView").css("display", "none");
	// $('#mapView').height($(window).height());
	// $('#map_canvas').height($(window).height());
	$('#mapViewSelect').fadeOut();
	$('#dualModeSelect').fadeIn();
	stopCamera();
	findMyLocation();
}
function arrivalPopup(gps) {
	var url = "REST/GetLocationWS/SearchForALocation?userName=NMMU&gps=" + gps;
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
		$("#currentLocationShow").fadeOut();
		$("#searchBarDivTop").fadeIn();
	} else {
		$("#barcodeDescription").fadeIn();
		$("#currentLocationShow").fadeIn();
		$("#searchBarDivTop").fadeOut();
	}
}