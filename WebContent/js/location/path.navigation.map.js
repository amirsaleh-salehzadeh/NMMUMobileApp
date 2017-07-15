function zoomInMap(){
	var zoom = map.getZoom();
	zoom++;
	map.setZoom(zoom);
}

function zoomOutMap(){
	var zoom = map.getZoom();
	zoom--;
	map.setZoom(zoom);
}

function mapSattelView(){
	map.setMapTypeId(google.maps.MapTypeId.HYBRID);
}

function mapMapView(){
	map.setMapTypeId('mystyle');
}

function openMenu(){
//    $('#openpanel').click(function(){
        $('#dashboardPanel').animate({'bottom':'0'},200);
//    });

//$('#close').click(function(){
    $('#dashboardPanel').animate({'bottom':'-121'},200);        
//});
	$( "#dashboardPanel" ).trigger( "updatelayout" );
}