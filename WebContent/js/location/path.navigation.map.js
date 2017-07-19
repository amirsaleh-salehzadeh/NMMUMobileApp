function initiateNavigation() {
	if ($("#destinationId").val() == "") {
		alert("Please choose a destination first please.");
		if (parseInt($('#searchBarDiv').css("right")) < -10) {

			openCloseSearch();
		}
		return;
	}
	$('#popupPathType').popup('open').trigger('create');
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
		$('#buttonContainer').animate({
			'right' : '266'
		}, 500);
		$('#searchBarDiv').animate({
			'right' : '0'
		}, 500);
	} else {
		$('#buttonContainer').animate({
			'right' : '0'
		}, 500);
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
//	$('#mapView').height($(window).height());
//	$('#map_canvas').height($(window).height());
	$('#mapViewSelect').fadeOut();
	$('#dualModeSelect').fadeIn();
	stopCamera();
	findMyLocation();
}