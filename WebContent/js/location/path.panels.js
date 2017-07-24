var locationTypeJSONData;
var marker;
var markers = [];
function getLocationTypePanel() {
	for ( var i = 0; i < markers.length; i++) {
		markers[i].setMap(null);
	}
	var url = "REST/GetLocationWS/GetAllLocationTypes";
	$
			.ajax({
				url : url,
				cache : true,
				async : true,
				success : function(data) {
					locationTypeJSONData = data;

					var listAdd = '<li data-role="collapsible" data-mini="true" data-iconpos="right" data-inset="true">';
					listAdd += '<h2>' + data.locationType + '</h2>';
					listAdd += '<ul data-role="listview" data-theme="b" data-collapsed="false" id="'
							+ data.locationTypeId
							+ '" class="locationTypes" data-filter="true" data-input="#destinationName"></ul></li>';
					console.log(data.locationTypeId);
					$("#autocompleteDestination").append(listAdd);
					$("#autocompleteDestination").listview();
					$("#autocompleteDestination").listview("refresh");
					$("#" + data.locationTypeId).listview();
					$("#" + data.locationTypeId).listview("refresh");
					getMyChild(data.locationTypeId);
					$('li[data-role=collapsible]').collapsible();
					
					url = "REST/GetLocationWS/SearchForALocation?userName=NMMU"
						+ "&locationType=Campus&locationName=";
				$.ajax({
					url : url,
					cache : true,
					async : true,
					success : function(data) {
						$.each(data, function(k, l) {
							var marker = marker = new google.maps.Marker({
								position : {
									lat : parseFloat(l.gps.split(",")[0]),
									lng : parseFloat(l.gps.split(",")[1])
								},
								map : map,
								icon : 'WebContent/images/map-markers/marker-green.png',
								title : l.locationName
							});
							markers.push(marker);
							var str = "";
							str += "<li id='" + l.locationID + "_" + l.gps
									+ "' onclick='selectDestination(this);getCampusMarkers('"+l.locationId+")'>"
								    + l.locationName
									+ "</li>";
							
							$("#" + l.locationType.locationTypeId).append(str);
							$("#" + l.locationType.locationTypeId).listview();
							$("#" + l.locationType.locationTypeId).listview("refresh");
							$("#autocompleteDestination").listview("refresh");
						});
						
					},error: function (xhr, ajaxOptions, thrownError) {
				        alert(xhr.status);
				        alert(thrownError);
				      } 
				});
					
					url = "REST/GetLocationWS/SearchForALocation?userName=NMMU"
						+ "&locationType=Building&locationName=";
				$.ajax({
					url : url,
					cache : true,
					async : true,
					success : function(data) {
						$.each(data, function(k, l) {
						
							var str = "";
							str += "<li id='" + l.locationID + "_" + l.gps
									+ "' onclick='selectDestination(this)'>"
								    + l.locationName
									+ "</li>";
							
							$("#" + l.locationType.locationTypeId).append(str);
							$("#" + l.locationType.locationTypeId).listview();
							$("#" + l.locationType.locationTypeId).listview("refresh");
							$("#autocompleteDestination").listview("refresh");
						});
						
					},error: function (xhr, ajaxOptions, thrownError) {
				        alert(xhr.status);
				        alert(thrownError);
				      } 
				});
				
				$( "div#searchBarDiv" ).on( "swipe", openCloseSearch );
				}
			});
	
}

var childData;
function getMyChild(select) {
	if (childData == null)
		childData = locationTypeJSONData;
	else if (childData.children == null)
		return;
	var listAdd = "";
	$
			.each(
					childData.children,
					function(k, l) {
						listAdd += '<li data-role="collapsible" data-mini="true" data-iconpos="right" data-inset="true" >';
						listAdd += '<h2>' + l.locationType + '</h2>';
						listAdd += '<ul data-role="listview" data-theme="b" data-filter-reveal="true" data-collapsed="false" id="'
								+ l.locationTypeId
								+ '" class="locationTypes" data-filter="true" data-input="#destinationName"></ul></li>';
					});
	$("#autocompleteDestination").append(listAdd);
	$("#autocompleteDestination").listview("refresh");
	// } else
	$.each(childData.children, function(k, l) {
		childData = l;
		getMyChild(l.locationTypeId);
	});
}

