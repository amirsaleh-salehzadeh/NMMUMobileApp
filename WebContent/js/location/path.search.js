window.onload = getLocationTypePanel;
var locationTypeJSONData;
function getLocationTypePanel() {
	var url = "REST/GetLocationWS/GetAllLocationTypes";
	$("#locationTypesContainer").controlgroup();
	$
			.ajax({
				url : url,
				cache : true,
				async : true,
				success : function(data) {
					locationTypeJSONData = data;
					var listAdd = '<li data-role="collapsible" data-iconpos="right" data-inset="false">';
					listAdd += '<h2>' + data.locationType + '</h2>';
					listAdd += '<ul data-role="listview" data-theme="b" data-inset="true" '
							+ data.locationTypeId
							+ ' class="locationTypes">';

					if (data.children.length > 1)
						$
								.each(
										data.children,
										function(k, l) {
											listAdd += '<li data-role="collapsible" data-iconpos="right" data-inset="false">';
											listAdd += '<h2>' + l.locationType
													+ '</h2>';
											listAdd += '<ul data-role="listview" data-theme="b" id="'
													+ l.locationTypeId
													+ '" class="locationTypes"></ul>This ONE</li>';
										});
					
					$("#autocompleteDestination").append(listAdd);
					$("#autocompleteDestination").listview("refresh");
					getMyChild(data.locationTypeId);
					$('li[data-role=collapsible]').collapsible();
				}
			});
	alert("sup");
	var url = "REST/GetLocationWS/SearchForALocation?userName=NMMU"
		+ "&locationName=";
     $.ajax({
			url : url,
			cache : false,
			success : function(data) {
				$.each(data,function(k, l) {	
				var str = "";
						alert("sup" + l.locationType.locationTypeId);
										str += "<li id='"
												+ l.locationID
												+ "_"
												+ l.gps
												+ "' onclick='selectDestination(this)'>"
												+ l.locationType.locationType
												+ " "
												+ l.locationName
												+ "</li>";
										alert(l.locationType);
										$("#"+l.locationType.locationTypeId).append(str);	
										$("#"+l.locationType.locationTypeId).listview("refresh");
					
	
	
								});
			}});
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
						listAdd += '<li data-role="collapsible" data-iconpos="right" data-inset="false">';
						listAdd += '<h2>' + l.locationType + '</h2>';
						listAdd += '<ul data-role="listview" data-theme="b" id="'
								+ l.locationTypeId
								+ '" class="locationTypes"></ul></li>';
					});
	listAdd +='</ul></li>';
		$("#autocompleteDestination").append(listAdd);
		$("#autocompleteDestination").listview("refresh");
		$('.selector').trigger('pagecreate');
		
	// } else
	$.each(childData.children, function(k, l) {
		childData = l;
		getMyChild(l.locationTypeId);
	});
}


function onSearch(){
//create a normal li ul of the returned locations
}
