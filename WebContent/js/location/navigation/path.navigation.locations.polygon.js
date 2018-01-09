function drawPolygons(location) {
	var arrayBoundary = location.boundary.split(";")[0].split("_");
	var CoordinatesArray = new Array();
	for ( var i = 0; i < arrayBoundary.length; i++) {
		var LatAndLng = arrayBoundary[i].split(",");
		var LatLng = new google.maps.LatLng(LatAndLng[0], LatAndLng[1]);
		CoordinatesArray.push(LatLng);
	}
	// var boundaryColour = getBoundaryColour(location.boundary);
	// var FillColour;
	// var BorderColour;
	// if (boundaryColour == "") {
	var FillColour = "#1E90FF";
	var BorderColour = "#1E90FF";
	// } else {
	// var FillColour = '#' + boundaryColour[0];
	// var BorderColour = '#' + boundaryColour[1];
	// }

	var DRAWPolygon = new google.maps.Polygon({
		paths : CoordinatesArray,
		strokeColor : BorderColour,
		strokeWeight : 1,
		fillColor : 'transparent',
		title : location.locationName + " "
				+ location.locationType.locationType,
		map : map
	});
	google.maps.event.addListener(DRAWPolygon, 'click', function(event) {
		showMarkerLabel(location.locationName + " "
				+ location.locationType.locationType, event.xa.x, event.xa.y);
	});
}

function showMarkerLabel(text, posX, posY) {
	$("#googleMapMarkerLabel").html(text);
	$('#googleMapMarkerLabel').css("display", "block");
	$('#googleMapMarkerLabel').css("position", "absolute").trigger("create");
	$('#googleMapMarkerLabel').css("top", posY + 'px');
	$('#googleMapMarkerLabel').css("left", posX + 'px');
	$('#googleMapMarkerLabel').trigger("create");
	$('#googleMapMarkerLabel').fadeIn();
	setTimeout(function() {
		$('#googleMapMarkerLabel').fadeOut();
	}, 3000);
}