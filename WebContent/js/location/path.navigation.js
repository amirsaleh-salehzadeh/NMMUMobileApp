var map, marker, infoWindow;
var markers = [];
var paths = [];

function animateCircle(line) {
	var count = 0;
	window.setInterval(function() {
		count = (count + 1) % 200;
		var icons = line.get('icons');
		icons[0].offset = (count / 2) + '%';
		line.set('icons', icons);
	}, 20);
}

function openMarkerPopup(edit) {
	if (!edit
			&& ($("#locationTypeId").val() == "0" || $("#parentLocationId")
					.val() == "0")) {
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
			var polylineLength = 0;
			$.each(data, function(k, l) {
				if (k == 0) {
					pathString = l.departure.locationID + ","
							+ l.destination.locationID;
					$("#departureName").val(l.departure.locationName);
					$("#destinationName").val(l.destination.locationName);
				} else
					pathString += "," + l.destination.locationID;
				var pathCoor = [];
				var lat1 = parseFloat(l.departure.gps.split(',')[0]);
				var lng1 = parseFloat(l.departure.gps.split(',')[1]);
				var pointPath1 = new google.maps.LatLng(lat1, lng1);
				var lat2 = parseFloat(l.destination.gps.split(',')[0]);
				var lng2 = parseFloat(l.destination.gps.split(',')[1]);
				var pointPath2 = new google.maps.LatLng(lat2, lng2);
				pathCoor.push(pointPath1);
				pathCoor.push(pointPath2);
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
				polylineLength += google.maps.geometry.spherical.computeDistanceBetween(pointPath1, pointPath2);
//				alert(polylineLength);
				pathPolyline.setMap(map);
				pathPolyline.addListener('click', function() {
					removePath(l.pathId);
				});
				paths.push(pathPolyline);
				animateCircle(pathPolyline);
			});
			alert(polylineLength);
			$("#tripString").val(pathString);
			$("#departureId").val(pathString.split(",")[0]);
			$("#destinationId").val(
					pathString.split(",")[pathString.split(",").length - 1]);
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
					var str = "<select name='selectLocationType' data-iconpos='noicon' class='locationTypeNavBar' onclick='createMyType(this);' id='NavBar"
							+ data.locationType + "' >";
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
					$("#locationTypesContainer").controlgroup("refresh");
					getMyChild(data.locationTypeId);
					setLocationTypeCreate();
					getAllMarkers();
				}
			});
}


function startTrip() {
	var url = "REST/GetLocationWS/StartTrip?from=" + $("#departureId").val()
			+ "&to=" + $("#destinationId").val();
	$.ajax({
		url : url,
		cache : false,
		success : function(data) {
			$("#tripId").val(data[0].tripId);
		}
	});
}

function removeTrip() {
	var url = "REST/GetLocationWS/RemoveTrip?tripId=" + $("#tripId").val();
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
function openAR() {
	var tmp = $('#destinationId').val();
	if (tmp == null || tmp == "null" || tmp == "")
		tmp = 0;
	window.open("insta/docs/index.jsp?destinationId=" + tmp + "&pathType="
			+ $("[name='radio-choice-path-type']:checked").val());
}
var myLatLng = {
	lat : -34.009211,
	lng : 25.669051
};
var infoWindow;
var successHandler = function(position) {
	var pos = {
		lat : position.coords.latitude,
		lng : position.coords.longitude
	};
	// 		infoWindow.setPosition(pos);
	// 		infoWindow.setContent('Location found.');
	// 		infoWindow.open(map);
	map.setCenter(pos);
	marker = new google.maps.Marker({
		position : pos,
		map : map
	});
};

var errorHandler = function(errorObj) {
	alert(errorObj.code + ": " + errorObj.message);

};

function initiMap() {
	map = new google.maps.Map(document.getElementById('map_canvas'), {
		center : {
			lat : -34.009211,
			lng : 25.669051
		},
		zoom : 17,
		fullscreenControl : true
	});
	infoWindow = new google.maps.InfoWindow;
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(successHandler,
				errorHandler, {
					enableHighAccuracy : true,
					maximumAge : 10000
				});
	} else {
		handleLocationError(false, infoWindow, map.getCenter());
	}
	input = document.getElementById('to');
	map.controls[google.maps.ControlPosition.BOTTOM_LEFT].push(document
			.getElementById('searchFields'));
	google.maps.event.addListener(map, "click", function(event) {
		var lat = event.latLng.lat();
		var lng = event.latLng.lng();
		if ($("#from").val() == "") {
			$("#from").val(lat + ", " + lng);
			return;
		} else if ($("#to").val() == "") {
			$("#to").val(lat + ", " + lng);
			return;
		} else {
			drawPoly();
		}
	});
}
function handleLocationError(browserHasGeolocation, infoWindow, pos) {
	infoWindow.setPosition(pos);
	infoWindow
			.setContent(browserHasGeolocation ? 'Error: The Geolocation service failed.'
					: 'Error: Your browser doesn\'t support geolocation.');
	infoWindow.open(map);
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
