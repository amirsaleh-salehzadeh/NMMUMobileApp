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
			}
		});
}

function printBarcode(id, name) {
	if (id == "") {
		alert("The location does not exist yet. Please save the location first");
		return;
	}
//	var query = '{"id":"' + id + '"}';
	window
			.open("pages/location/barcodePrint.jsp?locationId="
					+ id);
}

function saveMarker() {
	if ($("#markerName").val() == "") {
		alert("Please select a name for the location");
		return;
	}
	var url = "REST/GetLocationWS/SaveUpdateLocation?locationName="
			+ $("#markerName").val() + "&coordinate="
			+ $("#markerCoordinate").val() + "&locationType="
			+ $("#locationType").val() + "&userName=admin";

	$.ajax({
		url : url,
		cache : false,
		success : function(data) {
			marker = new google.maps.Marker({
				position : {
					lat : parseFloat(data.gps.split(",")[0]),
					lng : parseFloat(data.gps.split(",")[1])
				},
				map : map,
				title : data.locationName
			});
			var bounds = new google.maps.LatLngBounds();
			bounds.extend(marker.getPosition());
			map.fitBounds(bounds);
			marker.addListener('click', function() {
				addToPath(data.locationName, data.locationID, data.gps,
						data.locationType.locationTypeId);
			});
			markers.push(marker);
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
			}
		});
	} else {
		return;
	}
}

function savePath() {
	var url = "REST/GetLocationWS/SavePath?fLocationId="
			+ $("#departureId").val() + "&tLocationId="
			+ $("#destinationId").val() + "&pathType=" + $("#pathType").val();
	$.ajax({
		url : url,
		cache : false,
		success : function(data) {
			// window.location.replace("t_location.do?reqCode=pathManagement");
			$("#departure").val("");
			$("#departureId").val("");
			$("#destination").val("");
			$("#destinationId").val("");
			getAllPaths();
			$('#insertAPath').popup('close');
		}
	});
}

var markers = [];
var paths = [];
function getAllMarkers() {
	var url = "REST/GetLocationWS/GetAllLocationsForUser?userName=admin";
	for ( var i = 0; i < markers.length; i++) {
		markers[i].setMap(null);
	}
	$.ajax({
		url : url,
		cache : false,
		success : function(data) {
			$.each(data, function(k, l) {
				marker = new google.maps.Marker({
					position : {
						lat : parseFloat(l.gps.split(",")[0]),
						lng : parseFloat(l.gps.split(",")[1])
					},
					map : map,
					title : l.locationName
				});
				marker.addListener('click', function(point) {
					addToPath(l.locationName, l.locationID, l.gps,
							l.locationType.locationTypeId);
				});
				markers.push(marker);
			});
		}
	});
}

function getAllPaths() {
	var url = "REST/GetLocationWS/GetAllPathsForUser?userName=admin";
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
					strokeWeight : 7
				});
				pathPolyline.addListener('click', function() {
					removePath(l.pathId);
				});
				pathPolyline.setMap(map);
				paths.push(pathPolyline);
			});
		}

	});
}

function animateCircle(line) {
	var count = 0;
	window.setInterval(function() {
		count = (count + 1) % 200;

		var icons = line.get('icons');
		icons[0].offset = (count / 2) + '%';
		line.set('icons', icons);
	}, 20);
}

function addToPath(name, id, gps, typeId) {
	if ($('[name="optionType"] :radio:checked').val() == "marker") {
		$("#markerId").val(id);
		$("#markerName").val(name);
		$("#markerCoordinate").val(gps);
		$("#locationType option[value=" + typeId + "]").attr('selected',
				'selected').trigger('create');
		$('#locationType').selectmenu('refresh');
		$('#insertAMarker').popup().trigger('create');
		$('#insertAMarker').popup('open').trigger('create');
	} else {
		if ($("#departure").val() == "") {
			$("#departure").val(name);
			$("#departureId").val(id);
			return;
		} else if ($("#destination").val() == "") {
			$("#destination").val(name);
			$("#destinationId").val(id);
			openPathCreationPopup();
		}
	}
}

function openPathCreationPopup() {
	$('#insertAPath').popup().trigger('create');
	$('#insertAPath').popup('open').trigger('create');
}

function initMap() {
	getAllMarkers();
	getAllPaths();
	var myLatLng = {
		lat : -34.009083,
		lng : 25.669059
	};
	marker = new google.maps.Marker({
		position : myLatLng,
		map : map
	});
	map = new google.maps.Map(document.getElementById('map_canvas'), {
		zoom : 18,
		streetViewControl : true,
		fullscreenControl : true,
		mapTypeId : 'satellite'
	});
	map.setCenter(myLatLng);
	map.controls[google.maps.ControlPosition.BOTTOM_LEFT].push(document
			.getElementById('searchFields'));
	google.maps.event.addListener(map, "click", function(event) {
		$("#departure").val("");
		$("#departureId").val("");
		$("#destination").val("");
		$("#destinationId").val("");
		var lat = event.latLng.lat();
		var lng = event.latLng.lng();
		addToPath(null, null, lat + "," + lng, null);
	});
}

function drawPoly() {
	for ( var i = 0; i < paths.length; i++) {
		paths[i].setMap(null);
	}
	for ( var i = 0; i < markers.length; i++) {
		marker[i].setMap(null);
	}
	var url = "REST/GetLocationWS/GetADirectionFromTo?from=" + $("#from").val()
			+ "&to=" + $("#to").val() + "&pathType="
			+ $("[name='radio-choice-path-type']:checked").val();
	$.ajax({
		url : url,
		cache : false,
		success : function(data) {
			var pathString = "";
			$.each(data, function(k, l) {
				if (k == 0){
					pathString = l.departure.locationID + ","
							+ l.destination.locationID;
					$("#departureName").val(l.departure.locationName);
					$("#destinationName").val(l.destination.locationName);
				}
				else
					pathString += ","
						+ l.destination.locationID;
				var pathCoor = [];
				pathCoor.push(new google.maps.LatLng(parseFloat(l.departure.gps
						.split(',')[0]),
						parseFloat(l.departure.gps.split(',')[1])));
				pathCoor.push(new google.maps.LatLng(
						parseFloat(l.destination.gps.split(',')[0]),
						parseFloat(l.destination.gps.split(',')[1])));
				var lineSymbol = {
					path : google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
					scale : 5,
					strokeColor : 'black'
				};
				var pathPolyline = new google.maps.Polyline({
					path : pathCoor,
					geodesic : true,
					icons : [ {
						icon : lineSymbol,
						offset : '100%'
					} ],
					strokeColor : 'black',
					strokeOpacity : 1.0,
					strokeWeight : 7
				});
				pathPolyline.setMap(map);
				pathPolyline.addListener('click', function() {
					removePath(l.pathId);
				});
				paths.push(pathPolyline);
				animateCircle(pathPolyline);
			});
			$("#tripString").val(pathString);
			$("#departureId").val(pathString.split(",")[0]);
			$("#destinationId").val(pathString.split(",")[pathString.split(",").length-1]);
		}
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

function getLocationTypePanel() {
	var url = "REST/GetLocationWS/GetAllLocationTypes";
	$.ajax({
		url : url,
		cache : false,
		success : function(data) {
			var tmp = "";
			$.each(data, function(k, l) {
			tmp += "<li value='" + l.locationTypeId 
						+ "' class='liLocationLV'><a href='#'>"
						+ l.locationType + '</a></li>';
			});
			$("ul#locationTypeListView").html(tmp);
			$("ul#locationTypeListView").listview("refresh");
			$("#rightpanel").trigger("updatelayout");
		}
	});
}

function startTrip(){
	var url = "REST/GetLocationWS/StartTrip?from="+$("#departureId").val()+"&to="+$("#destinationId").val();
	$.ajax({
		url : url,
		cache : false,
		success : function(data) {
			$("#tripId").val(data[0].tripId);
		}
	});
}

function removeTrip(){
	var url = "REST/GetLocationWS/RemoveTrip?tripId="+$("#tripId").val();
	$.ajax({
		url : url,
		cache : false,
		success : function(data) {
			$("#from").val("");
			$("#departureId").val("");
			$("#to").val("");
			$("#destinationId").val("");
			$("#to").val("");
			$("#tripString").val("");
			$("#tripId").val("");
			for ( var i = 0; i < paths.length; i++) {
				paths[i].setMap(null);
			}
		}
	});
	
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
			$("ul#pathTypeListView").listview("refresh");
			$("#rightpanel").trigger("updatelayout");
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
