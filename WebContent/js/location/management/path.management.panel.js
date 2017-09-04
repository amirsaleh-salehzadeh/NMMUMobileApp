function getLocationTypePanel() {
	var url = "REST/GetLocationWS/GetAllLocationTypes";
	$("#locationTypesContainer").controlgroup();
	$
			.ajax({
				url : url,
				cache : false,
				async : true,
				success : function(data) {
					locationTypeJSONData = data;
					var str = "<select name='selectLocationType'  data-iconpos='noicon' data-role='nojs' class='locationTypeNavBar' onclick='createMyType(this);' id='NavBar"
							+ data.locationType + "' data-enhance='false'>";
					str += "<option value='" + data.locationTypeId + "'>"
							+ data.locationType + "</option>";
					if (data.children.length > 1)
						$.each(data.children, function(k, l) {
							str += "<option value='" + l.locationTypeId + "'>"
									+ l.locationType + "</option>";
						});
					str += "</select>";
					$("#locationTypeId").val(data.locationTypeId);
					$("#locationTypeDefinition").val(data.locationType);
					$("#locationTypesContainer").controlgroup("container")
							.empty();
					$("#locationTypesContainer").controlgroup("refresh");
					$("#locationTypesContainer").controlgroup("container")
							.append(str);
					$("#NavBar" + data.locationType).selectmenu();
					$("#NavBar" + data.locationType).selectmenu("refresh");
					$("#locationTypesContainer").controlgroup("refresh");
//					getMyChild(data.locationTypeId);
//					setLocationTypeCreate();
//
//					getAllMarkers();
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

function getLocationSearchPanel() {
	var url = "REST/GetLocationWS/GetAllLocationsForUser?parentLocationId=360&locationTypeId=2&userName=NMMU";
	$
			.ajax({
				url : url,
				cache : false,
				async : true,
				success : function(data) {
					var str = "";
					$
							.each(
									data,
									function(k, l) {
										str += '<a href="#" id="'
												+ l.locationID
												+ "_"
												+ l.gps
												+ "_"
												+ l.locationType.locationTypeId
												+ '" data-mini="true" onclick="selectParent(this)" class="ui-btn parentLocationList">'
												+ l.locationName + '</a>';
									});
					$('#parentLocationListView').html(str);
				},
				error : function(xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
					alert(thrownError);
				}
			});
	$('#parentLocationListView').val();
}
