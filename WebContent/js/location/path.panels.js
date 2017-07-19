var locationTypeJSONData;
function getLocationTypePanel() {
	var url = "REST/GetLocationWS/GetAllLocationTypes";
	$
			.ajax({
				url : url,
				cache : true,
				async : false,
				success : function(data) {
					locationTypeJSONData = data;

					var listAdd = '<li data-role="collapsible" data-iconpos="right" data-inset="false">';
					listAdd += '<h2>' + data.locationType + '</h2>';
					listAdd += '<ul data-role="listview" data-theme="b" data-iconpos="right" data-inset="true" data-filter="true" data-input="#destinationName"'
							+ data.locationTypeId + ' class="locationTypes">';
					listAdd += '<ul data-role="listview" data-theme="b" data-inset="true" data-mini="true" id="'
							+ data.locationTypeId + '" class="locationTypes">';
					listAdd += "</ul></li>";
					$("#autocompleteDestination").append(listAdd);
					$("#autocompleteDestination").listview();
					$("#autocompleteDestination").listview("refresh");
					$("#" + data.locationTypeId).listview();
					$("#" + data.locationTypeId).listview("refresh");
					getMyChild(data.locationTypeId);
					$('li[data-role=collapsible]').collapsible();
				}
			});
	var url = "REST/GetLocationWS/SearchForALocation?userName=NMMU"
			+ "&locationName=";
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
						listAdd += '<li data-role="collapsible" data-mini="true" data-iconpos="right" data-inset="false">';
						listAdd += '<h2>' + l.locationType + '</h2>';
						listAdd += '<ul data-role="listview" data-theme="b" id="'
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

