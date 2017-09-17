var locationTypeJSONData;
var arrLocationTypes=[];
var arrLocationTypesTest=['Client_0_1','Area_1_2','Building_2_3','Level_3_4','Outdoor Intersection_2_5','Staircase_4_6','Room_4_7','Elevator_4_8','Indoor Intersection_4_9','Entrance_4_10'];
function getLocationTypePanel() {
	 
	var url = "REST/GetLocationWS/GetAllLocationTypes";
	$
			.ajax({
				url : url,
				cache : false,
				async : true,
				success : function(data) {
					locationTypeJSONData = data;
					var str = data.locationType+'_'+data.parent.locationTypeId+'_'+data.locationTypeId;
					arrLocationTypes.push(str);						

					if (data.children.length > 1)
						$.each(data.children, function(k, l) {
							var str = data.locationType+'_'+data.parent.locationTypeId+'_'+data.locationTypeId;
							arrLocationTypes.push(str);	
						});
				
					 getMyChild(data.locationTypeId);
					// setLocationTypeCreate();
					//
					// getAllMarkers();
//					
//						for (var i = 0; i < arrLocationTypesTest.length; i++) {
						    //Do something
						}
			
			});
}

var childData;
function getMyChild(select) {
	if (childData == null)
		childData = locationTypeJSONData;
	else if (childData.children == null)
		return;	
	$
			.each(
					childData.children,
					function(k, l) {
						 {
							 var str = l.locationType+'_'+select+'_'+l.locationType.locationTypeId;
								arrLocationTypes.push(str);	
						}
											});
	
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
	//var exist = false;
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
function getDecendentList() {// gets all the children types and locations
									// for a location
	
	
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
										alert(l.locationName+" "+l.locationID);
										str="";
										str += "<li><div>"+l.locationName+"</div>";
										str+= getLocationDecendents(2,l.locationID);
										$("#my-tree").html($("#my-tree").html()+str);
									});
					
				},
				error : function(xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
					alert(thrownError);
				}
			});
//	$("#my-tree").html(str);
//	$('#' + $(field).attr("id")).html($('#' + $(field).attr("id")).html() + str);
//	$("#my-tree").html($("#my-tree").html());
}
function getLocationDecendents(typeId,locationId){
	var str = "";
	for (var i = 0; i < arrLocationTypesTest.length; i++) {
		if(typeId==arrLocationTypesTest[i].split("_")[1]){
		str+="<ul>";
		str += "<li><div>"+arrLocationTypesTest[i].split("_")[0]+"</div>";
		str+=getChildLocations(locationId, arrLocationTypesTest[i].split("_")[2]);
		str+="</li></ul>";
	 }
	}
  return str;
}
function getChildLocations(parentID, locationTypeID) {// creates the string for the
												// list items of the location
												// type and returns it
	var url = "REST/GetLocationWS/GetAllLocationsForUser?parentLocationId="+parentID+"&locationTypeId="+locationTypeID+"&userName=NMMU";
	var str = "<ul>";
	$
			.ajax({
				url : url,
				cache : false,
				async : true,
				success : function(data) {
					
					$
							.each(
									data,
									function(k, l) {
										//conlose.log(l.locationName);
//										str += '<li><div>'+ l.locationName + '</div>';
//										str += getLocationDecendents(l.locationType.locationTypeId,l.locationID);
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
