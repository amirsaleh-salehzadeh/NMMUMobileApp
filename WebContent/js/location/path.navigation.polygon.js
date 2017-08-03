function drawPolygons ()
{
	//map = new google.maps.Map(document.getElementById('map_canvas'), { });
	// Define the LatLng coordinates for the polygon's path.
	  var testCoords = [
	    {lat: -34.008559, lng: 25.668914},
	    {lat: -34.008552, lng: 25.669260},
	    {lat: -34.008672, lng: 25.669276},
	    {lat: -34.008794, lng: 25.669281},
	    {lat: -34.008791, lng: 25.668887},
	    {lat: -34.008607, lng: 25.668893},
	    {lat: -34.008559, lng: 25.668914}
	  ];

	  // Construct the polygon.
	  var testPolygon = new google.maps.Polygon({
	    paths: testCoords,
	    strokeColor: '#FF0000',
	   // strokeOpacity: 0.8,
	    strokeWeight: 2,
	    fillColor: '#FF0000',
	   // fillOpacity: 0.35
	  });
	  testPolygon.setMap(map);
}