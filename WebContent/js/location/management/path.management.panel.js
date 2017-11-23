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
			alert("getAllLocationTypes");
		}
	});
}

function getLocationTypeDropDown(obj) {
	if (obj == null)
		obj = JSON.parse(getCookie('TripPathIdsCookie'));
	var locationData = "";
	$(obj).each(function(k, l) {
		if (l.parent.locationTypeId == $("#parentLocationTypeId").val()) {
			locationData += "<option value='" + l.locationTypeId + "'>"
			+ l.locationType + "</option>";
		}else
			obj = l;
	});
	if(locationData.length>0){
		$("#locationType").html(locationData);
		$("#locationType").selectmenu("refresh").trigger("create");
	}
	if (obj.children != null)
		getLocationTypeDropDown(obj.children);
	else
		return;
}

function getParentLocationTypeId(obj, id) {
	if (obj == null)
		obj = JSON.parse(getCookie('TripPathIdsCookie'));
	var locationData = "";
	$(obj).each(function(k, l) {
		if (l.locationTypeId == id) {
			$("#parentLocationTypeId").val(l.parent.locationTypeId);
//			return;
		}else
			obj = l;
	});
	if (obj.children != null)
		getParentLocationTypeId(obj.children, id);
	else
		return;
}
