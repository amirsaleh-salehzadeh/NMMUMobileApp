var map, marker, infoWindow;
function removeMarker() {
	var url = "REST/GetLocationWS/RemoveALocation?locationId="
			+ $("#markerId").val();
	if (confirm('Are you sure you want to remove this location?'))
		$.ajax({
			url : url,
			cache : false,
			success : function(data) {
				$('#insertAMarker').popup('close');
				if (data.errorMSG != null) {
					alert(data.errorMSG);
					return;
				}
				getAllMarkers();
			},
			error : function(xhr, ajaxOptions, thrownError) {
				alert(xhr.status);
				alert(thrownError);
			}
		});
}

function printBarcode(id, name) {
	if (id == "") {
		alert("The location does not exist yet. Please save the location first");
		return;
	}
	window.open("pages/location/barcodePrint.jsp?locationId=" + id);
}

function saveMarker() {
	if ($("#markerName").val() == "") {
		alert("Please select a name for the location");
		return;
	}
	var url = "REST/GetLocationWS/SaveUpdateLocation?parentId="
			+ $("#parentLocationId").val() + "&locationName="
			+ $("#markerName").val() + "&coordinate="
			+ $("#markerCoordinate").val() + "&locationType="
			+ $("#locationTypeId").val() + "&locationId="
			+ $("#markerId").val() + "&userName=NMMU";

	$.ajax({
		url : url,
		cache : false,
		async : true,
		success : function(data) {
			marker = new google.maps.Marker({
				position : {
					lat : parseFloat(data.gps.split(",")[0]),
					lng : parseFloat(data.gps.split(",")[1])
				},
				map : map,
				icon : refreshMap(data),
				title : data.locationName
			});
			var bounds = new google.maps.LatLngBounds();
			bounds.extend(marker.getPosition());
			marker.addListener('click', function() {
				addToPath(data, data.gps);
			});
			markers.push(marker);
			if ($("#destinationIds").val() != "")
				$("#destinationIds").val(
						$("#destinationIds").val() + "," + data.locationID);
			else
				$("#destinationIds").val(data.locationID);
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});
	$('#insertAMarker').popup('close');
	$('#insertAMarker').popup("destroy");
}

function removePath(id) {
	if (confirm('Are you sure you want to remove this path?')) {
		var url = "REST/GetLocationWS/RemoveAPath?pathId=" + id;
		$.ajax({
			url : url,
			cache : false,
			success : function(data) {
				if (data.errorMSG != null) {
					alert(data.errorMSG);
					return;
				}
				getAllPaths();
			},
			error : function(xhr, ajaxOptions, thrownError) {
				alert(xhr.status);
				alert(thrownError);
			}
		});
	} else {
		return;
	}
}

function savePath() {
	var locationIds = $("#destinationIds").val().split(",");
	for ( var i = 0; i < locationIds.length() - 1; i++) {
		$("#departureId").val(locationIds[i]);
		$("#destinationId").val(locationIds[i + 1]);
		var url = "REST/GetLocationWS/SavePath?fLocationId="
				+ $("#departureId").val() + "&tLocationId="
				+ $("#destinationId").val() + "&pathType="
				+ $("#pathType").val();
		$.ajax({
			url : url,
			cache : false,
			async : true,
			success : function(data) {
				$("#departure").val("");
				$("#departureId").val("");
				$("#destination").val("");
				$("#destinationId").val("");
				getAllPaths();
				$('#insertAPath').popup('close');
			},
			error : function(xhr, ajaxOptions, thrownError) {
				alert(xhr.status);
				alert(thrownError);
			}
		});
	}
}

var markers = [];
var paths = [];
function getAllMarkers() {
	var url = "REST/GetLocationWS/GetAllLocationsForUser?parentLocationId="
			+ $("#parentLocationId").val() + "&locationTypeId="
			+ $("#locationTypeId").val() + "&userName=NMMU";
	for ( var i = 0; i < markers.length; i++) {
		markers[i].setMap(null);
	}
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
										var pos = {
											lat : parseFloat(l.gps.split(",")[0]),
											lng : parseFloat(l.gps.split(",")[1])
										};
										marker = new google.maps.Marker(
												{
													map : map,
													icon : refreshMap(l),
													animation : google.maps.Animation.DROP,
													draggable : true,
													title : l.locationName

												});
										marker.addListener('click', function(
												point) {
											addToPath(l, l.gps);
											map.setCenter(pos);
											map.setZoom(17);
										});
										marker
												.addListener(
														'dragend',
														function(point) {
															if (confirm("Are you sure you want to move the marker?")) {
																$(
																		"#markerCoordinate")
																		.val(
																				point.latLng
																						.lat()
																						+ ","
																						+ point.latLng
																								.lng());
																$("#markerId")
																		.val(
																				l.locationID);
																$(
																		"#parentLocationId")
																		.val(
																				l.parentId);
																$("#markerName")
																		.val(
																				l.locationName);
																$(
																		"#locationTypeId")
																		.val(
																				l.locationType.locationTypeId);
																setLocationTypeCreate();
																saveMarker();
															} else {
																this
																		.setPosition(pos);
															}
														});
										marker.setPosition(pos);
										markers.push(marker);
									});
					$('#parentLocationListView').html(str);
				},
				error : function(xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
					alert(thrownError);
				}
			});
}

function refreshMap(location) {
	var gps = {
		lat : parseFloat(location.gps.split(",")[0]),
		lng : parseFloat(location.gps.split(",")[1])
	};
	var icon = 'images/map-markers/';
	if (location.locationType.locationTypeId == "1") {
		icon += 'marker-blue.png';
	} else if (location.locationType.locationTypeId == "2") {
		icon += 'marker-green.png';
		map.setCenter(gps);
		map.setZoom(7);
	} else if (location.locationType.locationTypeId == "3") {
		icon += 'marker-orange.png';
		map.setCenter(gps);
		map.setZoom(15);
	} else if (location.locationType.locationTypeId == "4") {
		icon += 'marker-pink.png';
		map.setCenter(gps);
		map.setZoom(19);
	} else if (location.locationType.locationTypeId == "5") {
		icon += 'marker-pink.png';
		map.setCenter(gps);
		map.setZoom(20);
	} else
		icon += 'marker-yellow.png';
	return icon;
}

function getAllPaths() {
	var url = "REST/GetLocationWS/GetAllPathsForUser?userName=NMMU";
	for ( var i = 0; i < paths.length; i++) {
		paths[i].setMap(null);
	}
	$.ajax({
		url : url,
		cache : false,
		success : function(data) {
			$.each(data, function(k, l) {
				var pathCoor = [];
				pathCoor.push(new google.maps.LatLng(parseFloat(l.departure.gps
						.split(',')[0]),
						parseFloat(l.departure.gps.split(',')[1])));
				pathCoor.push(new google.maps.LatLng(
						parseFloat(l.destination.gps.split(',')[0]),
						parseFloat(l.destination.gps.split(',')[1])));
				var color = '#FF0000';
				if (l.pathType.pathTypeId == "1")
					color = '#ffb400';
				if (l.pathType.pathTypeId == "2")
					color = '#0ec605';
				if (l.pathType.pathTypeId == "3")
					color = '#3359fc';
				if (l.pathType.pathTypeId == "4")
					color = '#000000';
				if (l.pathType.pathTypeId == "5")
					color = '#ffffff';
				if (l.pathType.pathTypeId == "6")
					color = '#fc33f0';
				var pathPolyline = new google.maps.Polyline({
					path : pathCoor,
					geodesic : true,
					strokeColor : color,
					strokeOpacity : 1.0,
					strokeWeight : 6
				});
				pathPolyline.addListener('click', function() {
					removePath(l.pathId);
				});
				pathPolyline.setMap(map);
				paths.push(pathPolyline);
			});
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});
}

function addToPath(location, gps) {
	gps = gps.replace(" ", "");
	if ($('[name="optionType"] :radio:checked').val() == "marker") {
		var edit = true;
		if (location == null) {
			edit = false;
			$("#markerId").val("");
			$("#markerName").val("");
			$("#markerCoordinate").val(gps);
			$("#markerLabel").html();
		} else {
			$("#markerId").val(location.locationID);
			$("#markerName").val(location.locationName);
			$("#markerCoordinate").val(gps);
			$("#markerLabel").html(location.locationType.locationType);
		}
		openMarkerPopup(edit);
	} else {
		if (location == null) {
			alert("A path can only be drawn between two locations");
			return;
		}
		if ($("#departure").val() == "") {
			$("#departure").val(location.locationName);
			$("#departureId").val(location.locationID);
			google.maps.event.clearInstanceListeners(map);
			$("#pathLatLng").val(location.gps);
			$("#destinationIds").val(location.locationID);
			google.maps.event.addListener(map, "click", function(event) {
				addAPathInnerConnection(event);
			});
			return;
		} else if ($("#destination").val() == "") {
			$("#destination").val(location.locationName);
			$("#destinationId").val(location.locationID);
			google.maps.event.clearInstanceListeners(map);
			var lastUnnecessaryMarkerId = $("#destinationIds").val().split(",")[$(
					"#destinationIds").val().split("_").length];
			var lastUnnecessaryMarkerGPS = $("#pathLatLng").val().split("_")[$(
					"#pathLatLng").val().split("_").length];
			$("#destinationIds").val(
					$("#destinationIds").val().replace(
							"," + lastUnnecessaryMarkerId, ""));
			$("#pathLatLng").val(
					$("#pathLatLng").val().replace(
							"_" + lastUnnecessaryMarkerGPS, ""));
			$("#markerId").val(lastUnnecessaryMarkerId);
			var url = "REST/GetLocationWS/RemoveALocation?locationId="
					+ $("#markerId").val();
			$.ajax({
				url : url,
				cache : false,
				async : true,
				success : function(data) {
					$('#insertAMarker').popup('close');
					if (data.errorMSG != null) {
						alert(data.errorMSG);
						return;
					}
					getAllMarkers();
				},
				error : function(xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
					alert(thrownError);
				}
			});
			$("#pathLatLng").val($("#pathLatLng").val() + "_" + gps);
			$("#destinationIds").val(
					$("#destinationIds").val() + "," + data.locationID);
			openPathCreationPopup();
		}
	}
}

function getGoogleMapPosition(gps) {
	var res = new google.maps.LatLng(parseFloat(gps.split(',')[0]),
			parseFloat(gps.split(',')[1]));
	return res;
}

function addAPathInnerConnection(event) {
	var lat = event.latLng.lat();
	var lng = event.latLng.lng();
	$("#markerCoordinate").val(lat + "," + lng);
	$("#markerName").val("Intersection");
	$("#pathLatLng").val($("#pathLatLng").val() + "_" + lat + "," + lng);
	updateConstantLine();
	google.maps.event.addListener(map, "mousemove", function(event) {
		updateMovingLine(event);
	});
	$("#locationTypeId").val(5);
	saveMarker();
}
var constantLine, movingLine, pathPolylineConstant, lastOne;
function updateMovingLine(event) {
	var pointPath = event.latLng;
	var tmpPathCoor = [];
	tmpPathCoor.push(pointPath);
	tmpPathCoor.push(lastOne);
	if (movingLine == null) {
		movingLine = new google.maps.Polyline({
			path : tmpPathCoor,
			geodesic : true,
			strokeColor : 'green',
			strokeOpacity : 1.0,
			strokeWeight : 2,
			map : map
		});
		google.maps.event.addListener(movingLine, "click", function(event) {
			addAPathInnerConnection(event);
		});
		paths.push(movingLine);
	} else
		movingLine.setPath(tmpPathCoor);
	movingLine.setMap(null);
	movingLine.setMap(map);
}

function updateConstantLine() {
	var tmpPathCoor = [];
	var nextDestGPS = $("#pathLatLng").val().split("_");
	polylineConstantLength = 0;
	if (nextDestGPS.length > 1)
		for ( var i = 0; i < nextDestGPS.length; i++) {
			tmpPathCoor.push(getGoogleMapPosition(nextDestGPS[i]));
			lastOne = getGoogleMapPosition(nextDestGPS[i]);
		}
	else
		return;
	var lineSymbol = {
		path : google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
		scale : 4,
		strokeColor : 'yellow'
	};
	if (pathPolylineConstant != undefined)
		pathPolylineConstant.setMap(null);
	if (pathPolylineConstant == null)
		pathPolylineConstant = new google.maps.Polyline({
			path : tmpPathCoor,
			geodesic : true,
			icons : [ {
				icon : lineSymbol,
				offset : '100%'
			} ],
			strokeColor : 'green',
			strokeOpacity : 1.0,
			strokeWeight : 3
		});
	else
		pathPolylineConstant.setPath(tmpPathCoor);
	pathPolylineConstant.setMap(map);
	paths.push(pathPolylineConstant);
}

function animateCircle(line) {
	var count = 0;
	window.setInterval(function() {
		count = (count + 1) % 200;
		var icons = line.get('icons');
		icons[0].offset = (count / 2) + '%';
		line.set('icons', icons);
	}, 50);
}

function openMarkerPopup(edit) {
	if (!edit
			&& (parseInt($("#locationTypeId").val()) > 1 || $(
					"#parentLocationId").val() == "0")) {
		alert("Please select the marker type (at the top menu) and parent location (at the right side menu) first.");
		return;
	}
	$('#insertAMarker').popup().trigger('create');
	$('#insertAMarker').popup('open').trigger('create');

}

function openPathCreationPopup() {
	$('#insertAPath').popup().trigger('create');
	$('#insertAPath').popup('open').trigger('create');
}

function initMap() {
	getLocationTypePanel();
	getPathTypePanel();
	getAllPaths();
	var myLatLng = {
		lat : -33.5343803,
		lng : 24.2683424
	};

	map = new google.maps.Map(document.getElementById('map_canvas'), {
		zoom : 7,
		fullscreenControl : true,
		streetViewControl : false
	// mapTypeId : 'satellite'
	});

	map.setCenter(myLatLng);
	map.controls[google.maps.ControlPosition.BOTTOM_LEFT].push(document
			.getElementById('searchFields'));
	map.controls[google.maps.ControlPosition.LEFT_TOP].push(document
			.getElementById('createType'));
	map.controls[google.maps.ControlPosition.TOP_CENTER].push(document
			.getElementById('locationTypeFields'));
	map.controls[google.maps.ControlPosition.RIGHT_TOP].push(document
			.getElementById('locationsUnderAType'));
	map.controls[google.maps.ControlPosition.LEFT_TOP].push(document
			.getElementById('infoDiv'));
	google.maps.event.addListener(map, "click", function(event) {
		$("#departure").val("");
		$("#departureId").val("");
		$("#destination").val("");
		$("#destinationId").val("");
		var lat = event.latLng.lat();
		var lng = event.latLng.lng();
		addToPath(null, lat + "," + lng);
	});
}

function selectRightPanelVal() {
	if ($('[name="optionType"] :radio:checked').val() == "marker") {
		$("#locationTypeListViewDiv").css("display", "block");
		$("#pathTypeListViewDiv").css("display", "none");
	} else {
		$("#locationTypeListViewDiv").css("display", "none");
		$("#pathTypeListViewDiv").css("display", "block");
	}
}
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
					getMyChild(data.locationTypeId);
					setLocationTypeCreate();
					getAllMarkers();
				}
			});
}

function changeTheLocation(li) {
	$("#locationTypeId").val($(li).attr("id").split("_")[0]);
	setLocationTypeCreate();
	$("#parentLocationId").val($(li).attr("id").split("_")[1]);
	var remove = false;
	$("#infoListView li").each(function() {
		if (remove)
			$(this).remove();
		if ($(this).attr("id") == $(li).attr("id"))
			remove = true;
	});
	getAllMarkers();
}

function setLocationTypeCreate() {
	$(".locationTypeNavBar option").each(function() {
		if ($(this).val() == $("#locationTypeId").val()) {
			$("#locationTypeDefinition").val($(this).html().replace(" ", ""));
			$("#createType").html($(this).html().replace(" ", ""));
		}
	});
	google.maps.event.trigger(map, 'resize');
}

function selectParent(field) {
	var exist = false;
	$("#infoListView li").each(function() {
		if ($(this).html().indexOf($(field).html()) !== -1)
			exist = true;
	});
	if (!exist) {
		$(".locationTypeNavBar option").each(
				function() {
					if ($(this).val() == $(field).attr("id").split("_")[2]) {
						$("#locationTypeId").val($(this).val());
						$("#locationTypeDefinition").val(
								$(this).html().replace(" ", ""));
					}
				});
		$("#parentLocationId").val($(field).attr("id").split("_")[0]);
		$("#locationTypeId").val($(field).attr("id").split("_")[2]);
		$("#infoListView").append(
				"<li id='" + $("#locationTypeId").val() + "_"
						+ $(field).attr("id").split("_")[0]
						+ "' onclick='changeTheLocation(this);'>["
						+ $("#locationTypeDefinition").val() + "] "
						+ $(field).html() + "</li>");
		$("#infoListView").listview();
		getMyChild($(field).attr("id").split("_")[2]);
		// getMyChild($(field).attr("id").split("_")[2]);
		$("#infoListView").listview();
		$("#infoListView").listview("refresh");
		getAllMarkers();
		setLocationTypeCreate();
	}
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

function createMyType(selectOpt) {
	$("#locationTypeId").val($(selectOpt).val());
	setLocationTypeCreate();
}

function getPathTypePanel() {
	var url = "REST/GetLocationWS/GetAllPathTypes";
	$.ajax({
		url : url,
		cache : false,
		success : function(data) {
			var tmp = "";
			$.each(data, function(k, l) {
				tmp += "<li value='" + l.pathTypeId
						+ "' class='liPathLV'><a href='#'>" + l.pathType
						+ "</a></li>";
			});
			$("ul#pathTypeListView").html(tmp).trigger("create");
			$("ul#pathTypeListView").listview();
			$("ul#pathTypeListView").listview("refresh");
			$("#rightpanel").trigger("updatelayout");
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
		}
	});
}

$(document).ready(
		function() {
			$("#map_canvas").css("min-width",
					parseInt($("#mainBodyContents").css("width")));
			$("#map_canvas").css(
					"min-height",
					parseInt($(window).height())
							- parseInt($(".jqm-header").css("height")) - 7);

		});
