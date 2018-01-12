function drawPolygons(location) {
	var arrayBoundary = location.boundary.split(";")[0].split("_");
	var CoordinatesArray = new Array();
	for ( var i = 0; i < arrayBoundary.length; i++) {
		var LatAndLng = arrayBoundary[i].split(",");
		var LatLng = new google.maps.LatLng(LatAndLng[0], LatAndLng[1]);
		CoordinatesArray.push(LatLng);
	}
	var FillColour = "#F8B624";
	var DRAWPolygon = new google.maps.Polygon({
		paths : CoordinatesArray,
		strokeWeight : 1,
		fillColor : "#081B2C",
		fillOpacity : 1,
		title : location.locationName + " "
				+ location.locationType.locationType,
		map : map,
		zIndex : 2
	});
	DRAWPolygon.id = location.locationID;
	if (location.locationType.locationTypeId == 2)
		DRAWPolygon.setOptions({
			fillOpacity : .33,
			zIndex : 1,
			fillColor : FillColour
		});
	google.maps.event.addListener(DRAWPolygon, 'click', function(event) {
		if (location.locationType.locationTypeId == 2)
			toast(location.locationName + " "
					+ location.locationType.locationType, event.xa.x,
					event.xa.y);
		else
			toast(location.locationType.locationType + " "
					+ location.locationName, event.xa.x, event.xa.y);

	});
	locationPolygons.push(DRAWPolygon);
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

function measurePolygonForAPath(coorPoly, width) {
	var distance = parseFloat(width) / 222240, geoInput = {
		type : "LineString",
		coordinates : coorPoly
	};
	var geoReader = new jsts.io.GeoJSONReader(), geoWriter = new jsts.io.GeoJSONWriter();
	var geometry = geoReader.read(geoInput).buffer(distance);
	var polygon = geoWriter.write(geometry);
	var oLanLng = [];
	var oCoordinates;
	oCoordinates = polygon.coordinates[0];
	for ( var i = 0; i < oCoordinates.length; i++) {
		var oItem;
		oItem = oCoordinates[i];
		oLanLng.push(new google.maps.LatLng(oItem[1], oItem[0]));
	}
	return oLanLng;
}
