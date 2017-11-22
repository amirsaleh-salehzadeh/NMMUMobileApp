var locationTypeJSONData;
var arrAreas = [ 'South_369_2', 'North_371_2' ];
var arrLocationTypesTest = [ 'Client_0_1', 'Area_1_2', 'Building_2_3',
		'Level_3_4', 'Outdoor Intersection_2_5', 'Staircase_4_6', 'Room_4_7',
		'Elevator_4_8', 'Indoor Intersection_4_9', 'Entrance_4_10' ];

function getAllLocationTypes() {
	var url = "REST/GetLocationWS/GetAllLocationTypes";
	$.ajax({
		url : url,
		cache : false,
		async : true,
		success : function(data) {
			setCookie('TripPathIdsCookie', JSON.stringify(data), 1);
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
			alert("getLocationTypePanel");
		}
	});
}

function getLocationTypePanel() {
	var locationData = "";
	var obj = JSON.parse(getCookie('TripPathIdsCookie'));
	if (obj != null && obj.children != null
			&& obj.locationTypeId == $("#locationTypeId").val()) {
		$(obj.children).each(
				function(k, l) {
					locationData += "<option value='" + l.locationTypeId + "'>"
							+ l.locationType + "</option>";
				});
		// if (locationData.length > 0)
		$("#locationType").html(locationData).trigger("create");
	}
}
