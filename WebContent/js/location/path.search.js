window.onload = getLocationTypePanel;
var locationTypeJSONData;
function getLocationTypePanel() {
	var url = "REST/GetLocationWS/GetAllLocationTypes";
	$("#locationTypesContainer").controlgroup();
	$
			.ajax({
				url : url,
				cache : false,
				success : function(data) {
					locationTypeJSONData = data;
					var str = '<li data-role="collapsible" data-iconpos="right" data-shadow="false" data-corners="false">';
					str += data.locationType + '<ul data-role="listview" data-shadow="false" data-inset="true" data-corners="false">';
					 
						$.each(data.children, function(k, l) {
							str += '<li><a href="#"></a></li>';
	            		});

					str+= '</ul></li>';
//					$("#locationTypeId").val(data.locationTypeId);
//					$("#locationTypeDefinition").val(data.locationType);
//					$("#locationTypesContainer").controlgroup("container")
//							.empty();
//					$("#locationTypesContainer").controlgroup("refresh");
//					$("#locationTypesContainer").controlgroup("container")
//							.append(str);
//					$("#NavBar" + data.locationType).selectmenu();
//					$("#NavBar" + data.locationType).selectmenu("refresh");
//					$("#locationTypesContainer").controlgroup("refresh");
					//getMyChild(data.locationTypeId);
//					setLocationTypeCreate();
//					getAllMarkers();
					$("#locationTypeList").append(str).listview('refresh');
				}
			});
}
var childData;
function getMyChild(select) {
	if (childData == null)
		childData = locationTypeJSONData;
	else if (childData.children == null)
		return;
	var navbarId = "";
	// if (childData.locationTypeId == select) {
	$("#locationTypeDefinition").val("");
	var str = "";
	$
			.each(
					childData.children,
					function(k, l) {
						if (str == "") {
							navbarId = l.locationType;
							str = "<select name='selectLocationType' data-iconpos='noicon' data-role='none' class='locationTypeNavBar' id='NavBar"
									+ l.locationType
									+ "' onclick='createMyType(this);'>";
						}
						str += "<option value='" + l.locationTypeId + "'> "
								+ l.locationType + "</option>";
					});
	str += "</select>";
	if ($("select#NavBar" + navbarId).length == 0) {
		$("#locationTypesContainer").controlgroup("container").append(str);
		$("#NavBar" + navbarId).selectmenu();
		$("#NavBar" + navbarId + " > option").each(function() {
			$("#NavBar" + navbarId).css("min-width", $(this).css("width"));
		});
		$("#locationTypesContainer").controlgroup("refresh");
	}
	// } else
	$.each(childData.children, function(k, l) {
		childData = l;
		getMyChild(l.locationTypeId);
	});
}


