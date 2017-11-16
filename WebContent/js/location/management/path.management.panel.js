var locationTypeJSONData;
var arrAreas = [ 'South_369_2', 'North_371_2' ];
var arrLocationTypesTest = [ 'Client_0_1', 'Area_1_2', 'Building_2_3',
		'Level_3_4', 'Outdoor Intersection_2_5', 'Staircase_4_6', 'Room_4_7',
		'Elevator_4_8', 'Indoor Intersection_4_9', 'Entrance_4_10' ];
function getLocationTypePanel() {
	var url = "REST/GetLocationWS/GetAllLocationTypes";
	$.ajax({
		url : url,
		cache : false,
		async : true,
		success : function(data) {
			locationTypeJSONData = data;
			var str = data.locationType + '_' + data.parent.locationTypeId
					+ '_' + data.locationTypeId;
			arrLocationTypes.push(str);

			if (data.children.length > 1)
				$.each(data.children, function(k, l) {
					var str = data.locationType + '_'
							+ data.parent.locationTypeId + '_'
							+ data.locationTypeId;
					arrLocationTypes.push(str);
				});

			getMyChild(data.locationTypeId);
		}

	});
}

var childData;
function getMyChild(select) {
	if (childData == null)
		childData = locationTypeJSONData;
	else if (childData.children == null)
		return;
	$.each(childData.children, function(k, l) {
		{
			var str = l.locationType + '_' + select + '_'
					+ l.locationType.locationTypeId;
			arrLocationTypes.push(str);
		}
	});
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
					alert("getLocationSearchPanel");
				}
			});
	$('#parentLocationListView').val();
}

function selectParent(field) {
	$("#parentLocationId").val($(field).attr("id").split("_")[0]);
	$("#parentDescriptionToAdd").html($(field).html() + " Campus");
	$("#infoListView").listview();
	$("#infoListView").listview();
	$("#infoListView").listview("refresh");

}
function getDecendentList() {// gets all the children types and locations
	// for a location
	var url = "REST/GetLocationWS/GetAllLocationsForUser?parentLocationId=360&locationTypeId=2&userName=NMMU";
	$.ajax({
		url : url,
		cache : false,
		async : true,
		success : function(data) {
			locationTypeJSONData = data;
			var strCampus = "";
			$.each(data, function(k, l) {
				strCampus = l.locationName + "_" + l.locationID + "_" + "2";
				arrAreas.push(strCampus);
			});

		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
			alert("getDecendentList");
		}
	});
	// alert("Before Initite");
	initiateTreeItems();
	// alert("After Initite");

}
function initiateTreeItems() {

	for ( var i = 0; i < arrAreas.length; i++) {
		console.log(arrAreas[i]);
		var strCampus = "";
		strCampus += "<li><div>" + arrAreas[i].split("_")[0] + "</div><ul>";
		strCampus += getlocationDecendentType("2", arrAreas[i].split("_")[1]);
		// alert(getlocationDecendentType(2,arrAreas[i].split("_")[1]));
		strCampus += "</ul></li>";
		$("#my-tree").html($("#my-tree").html() + strCampus);
	}

}

function getlocationDecendentType(locationTypeId, locationId) {
	var str = "";
	for ( var i = 0; i < arrLocationTypesTest.length; i++) {
		if (locationTypeId == arrLocationTypesTest[i].split("_")[1]) {
			str += "<li><div>" + arrLocationTypesTest[i].split("_")[0]
					+ "</div><ul>";
			str += "</ul></li>";
		}
		return str;
	}
}

// function getChildLocations(parentID, locationTypeID) {// creates the string
// for the
// // list items of the location
// // type and returns it
// var url =
// "REST/GetLocationWS/GetAllLocationsForUser?parentLocationId=369&locationTypeId=3&userName=NMMU";
// var locations="";
// $.ajax({
// url : url,
// cache : false,
// async : true,
// success : function(data) {
// console.log("Starts");
// $
// .each(
// data,
// function(k, l) {
// // if(l.locationType.locationTypeId=="3"){
// console.log(l.locationName);
// locations += '<li><div>'+ l.locationName + '</div><ul>';
// //locations +=
// getlocationDecendentType(l.locationType.locationTypeId,l.locationID);
// locations+='</ul></li>';
//									
// });
// },
// error : function(xhr, ajaxOptions, thrownError) {
// alert(xhr.status);
// alert(thrownError);
//				
// }
// });
//			
// return locations;
// }

