function getClosestBuilding(){
	
}

function initiateNavigation() {
	
	if ($("#destinationId").val() == "") {
		alert("Please choose a destination first please.");
		if (parseInt($('#searchBarDiv').css("right")) < -10){
			
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
}

function mapMapView() {
	map.setMapTypeId('mystyle');
}

function openCloseMenu() {
	if (parseInt($('#searchBarDiv').css("right")) >= 0)
		openCloseSearch();
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

function openCloseSearch() {
	if (parseInt($('#dashboardPanel').css("bottom")) >= 0) {
		openCloseMenu();
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