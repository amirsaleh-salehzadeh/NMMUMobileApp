var locationTypeJSONData;
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
					// getMyChild(data.locationTypeId);
					// setLocationTypeCreate();
					//
					// getAllMarkers();
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
					locationTypeJSONData = data;
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

function selectParent(field) {
	var exist = false;
	// $("#infoListView li").each(function() {
	// if ($(this).html().indexOf($(field).html()) !== -1)
	// exist = true;
	// });
	// if (!exist || $("#locationTypeId").val("3")
	// || $("#locationTypeId").val("5")) {
	// $(".locationTypeNavBar option").each(
	// function() {
	// if ($(this).val() == $(field).attr("id").split("_")[2]) {
	// $("#locationTypeId").val($(this).val());
	// $("#locationTypeDefinition").val(
	// $(this).html().replace(" ", ""));
	// }
	// });
	$("#parentLocationId").val($(field).attr("id").split("_")[0]);
	// $("#locationTypeId").val($(field).attr("id").split("_")[2]);
	// if ($("#locationTypeId").val() == 3) {
	// $("#infoListView").html(
	// "<li > Adding Building on </li>"
	// + "<li id='" + $("#locationTypeId").val() + "_"
	// + $(field).attr("id").split("_")[0]
	// + "' onclick='changeTheLocation(this);'>"
	// + $(field).html() + " Campus</li>");
	// } else {
	// $("#infoListView").html(
	// "<li > Adding Intersection on </li>"
	// + "<li id='" + $("#locationTypeId").val() + "_"
	// + $(field).attr("id").split("_")[0]
	// + "' onclick='changeTheLocation(this);'>["
	// + $("#locationTypeDefinition").val() + "] "
	// + $(field).html() + "</li>");
	// }
	$("#parentDescriptionToAdd").html($(field).html() + " Campus");
	$("#infoListView").listview();
	// getMyChild($(field).attr("id").split("_")[2]);
	$("#infoListView").listview();
	$("#infoListView").listview("refresh");
	// }
	// getLocationSearchPanel();
	// getAllMarkers();
	// setLocationTypeCreate();

}
function getDecendentList(field) {// gets all the children types and locations
									// for a location
	var url = "REST/GetLocationWS/GetAllLocationTypes";
	var str = "";
	$.ajax({
		url : url,
		cache : false,
		async : true,
		success : function(data) {
			alert(data.locationTypeId);
			if(data.locationTypeId==$(field).attr("id").split("_")[0]){
			$.each(data,
					function(k, l) {
				alert(l.locationTypeId);
						
							str += "<li><div>"+l.locationType+"</div>"
									+ getChildLocations(
											l.locationType.locationTypeId, $(
													field).attr("id")
													.split("_")[0]) + "</li>";
						
					});
			}},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});
	//alert($(field).attr("id").split("_")[0]);
	$('#' + $(field).attr("id"))
			.html($('#' + $(field).attr("id")).html() + str);
	$("#my-tree").val();
}
function getChildLocations(typeID, parentID) {// creates the string for the
												// list items of the location
												// type and returns it

	var url = "REST/GetLocationWS/GetAllLocationsForUser?parentLocationId="
			+ parentID+
	"&locationTypeId=" + typeID + "&userName=NMMU";
	$
			.ajax({
				url : url,
				cache : false,
				async : true,
				success : function(data) {
					var str = "<ul>";
					$
							.each(
									data,
									function(k, l) {
										str += '<li onclick="getDecendentList(this)" id="'
												+ l.locationType.locationTypeId
												+ "_"
												+ l.locationID
												+ '"><div><a href="#" '
												+ '" data-mini="true" class="ui-btn parentLocationList">'
												+ l.locationName + '</a></div>';
									});
				},
				error : function(xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
					alert(thrownError);
				}
			});
	str += "</ul>";
	return str;
}

function checkChilden(typeID, parentID) {// checks if location has types
											// under it and locations of those
											// types
	var check = true;
	var url = "REST/GetLocationWS/GetAllLocationsForUser?parentLocationId="
			+ parentID+
	"&locationTypeId=" + typeID + "&userName=NMMU";
	$.ajax({
		url : url,
		cache : false,
		async : true,
		success : function(data) {
			if (data == null || data == "") {
				check = false;
			}
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});
	var url = "REST/GetLocationWS/GetAllLocationTypesForUser?parentId="
			+ parentID+
	"&locationTypeId=" + typeID;
	$.ajax({
		url : url,
		cache : false,
		async : true,
		success : function(data) {
			if (data == null || data == "") {
				check = false;
			}
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});

	return check;
}
