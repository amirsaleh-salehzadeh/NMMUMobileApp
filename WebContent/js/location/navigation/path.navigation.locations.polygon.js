function drawPolygons(location) {
	var arrayBoundary = location.boundary.split(";")[0].split("_");
	var CoordinatesArray = new Array();
	for ( var i = 0; i < arrayBoundary.length; i++) {
		var LatAndLng = arrayBoundary[i].split(",");
		var LatLng = new google.maps.LatLng(LatAndLng[0], LatAndLng[1]);
		CoordinatesArray.push(LatLng);
	}
	var FillColour = "#F8B624";
	var polygon = new google.maps.Polygon({
		paths : CoordinatesArray,
		strokeWeight : 1,
		strokeColor : "#F8B624",
		fillColor : "#081B2C",
		fillOpacity : .66,
		title : location.locationName + " "
				+ location.locationType.locationType,
		map : map,
		zIndex : 2
	});
	var polygonBoundary = new google.maps.Polygon({
		path : CoordinatesArray,
		strokeWeight : 1,
		strokeColor : "#081B2C",
		fillColor : "#F8B624",
		fillOpacity : .66,
		map : map,
		zIndex : 2
	});
	polygon.id = location.locationID;
	polygonBoundary.id = location.locationID;
	if (location.locationType.locationTypeId == 2){
		polygon.setOptions({
			fillOpacity : .22,
			zIndex : 1,
			fillColor : FillColour
		});
		polygonBoundary.setOptions({
			fillOpacity : .11,
			zIndex : 1
		});
	}
	google.maps.event.addListener(polygon, 'click', function(event) {
		if (location.locationType.locationTypeId == 2)
			toast(location.locationName + " "
					+ location.locationType.locationType, event.xa.x,
					event.xa.y);
		else
			toast(location.locationType.locationType + " "
					+ location.locationName, event.xa.x, event.xa.y);

	});
	google.maps.event.addListener(polygonBoundary, 'click', function(event) {
		if (location.locationType.locationTypeId == 2)
			toast(location.locationName + " "
					+ location.locationType.locationType, event.xa.x,
					event.xa.y);
		else
			toast(location.locationType.locationType + " "
					+ location.locationName, event.xa.x, event.xa.y);

	});
	locationPolygons.push(polygon);
	polygonBoundary.setMap(null);
	locationPolylines.push(polygonBoundary);
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
