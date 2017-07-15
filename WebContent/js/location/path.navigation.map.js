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
}

function mapMapView() {
	map.setMapTypeId('mystyle');
}

function openMenu() {
	if (parseInt($('#searchBarDiv').css("right")) >= 0)
		openSearch();
	if (parseInt($('#dashboardPanel').css("bottom")) < -10) {
		$('#buttonContainer').animate({
			'bottom' : '121'
		}, 500);
		$('#dashboardPanel').animate({
			'bottom' : '0'
		}, 500);
	} else {
		$('#buttonContainer').animate({
			'bottom' : '0'
		}, 500);
		$('#dashboardPanel').animate({
			'bottom' : '-121'
		}, 500);
	}
	$("#dashboardPanel").trigger("updatelayout");
	$("#searchBarDiv").trigger("updatelayout");
}
function openSearch() {
	if (parseInt($('#dashboardPanel').css("bottom")) >= 0) {
		openMenu();
	}
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
	$("#dashboardPanel").trigger("updatelayout");
	$("#searchBarDiv").trigger("updatelayout");
}