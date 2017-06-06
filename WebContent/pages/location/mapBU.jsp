<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
#map_canvas {
	height: 333px;;
	width: 100%;
	top: 0;
	bottom: 0;
}

#searchFields {
	margin: 0 0 0 0;
	padding-bottom: 12px;
}

#infowindow-content .title {
	font-weight: bold;
}

#infowindow-content {
	display: none;
}

#map_canvas #infowindow-content {
	display: inline;
}

.inlineIcon {
	display: inline-block;
	position: relative;
	vertical-align: middle;
	width: auto !important;
}

.NoDisk:after {
	background-color: transparent;
}

.ui-icon-walking:after {
	background-image:
		url("http://icons.iconarchive.com/icons/anatom5/people-disability/32/walking-icon.png");
	background-size: 23px 23px;
	border-radius: 0;
}

.ui-icon-bike:after {
	background-image:
		url("http://icons.iconarchive.com/icons/aha-soft/transport/32/bike-icon.png");
	background-size: 23px 23px;
	border-radius: 0;
}

.ui-icon-driving:after {
	background-image:
		url("http://icons.iconarchive.com/icons/cemagraphics/classic-cars/32/yellow-pickup-icon.png");
	background-size: 23px 23px;
	border-radius: 0;
}
</style>
</head>
<body>
	<div id="map_canvas"></div>
	<!-- 	<div id="infowindow-content"> -->
	<!-- 		<img src="" width="16" height="16" id="place-icon"> <span -->
	<!-- 			id="place-name" class="title"></span><br> <span -->
	<!-- 			id="place-address"></span> -->
	<!-- 	</div> -->
	<div id="searchFields" style="width: 85%;">
		<fieldset data-role="controlgroup" data-type="horizontal">
			<label for="walking"><span
				class="ui-alt-icon ui-icon-walking ui-btn-icon-notext inlineIcon NoDisk"></span></label>
			<input type="radio" name="radio-choice-v-2" id="walking" value="on"
				checked="checked"> <label for="bicycle"><span
				class="ui-alt-icon ui-icon-bike ui-btn-icon-notext inlineIcon NoDisk"></span></label>
			<input type="radio" name="radio-choice-v-2" id="bicycle" value="on">
			<label for="driving"><span
				class="ui-alt-icon ui-icon-driving ui-btn-icon-notext inlineIcon NoDisk"></span></label>
			<input type="radio" name="radio-choice-v-2" id="driving" value="on">
		</fieldset>
		<div class="ui-block-solo">
			<input type="text" data-theme="c" id="from" placeholder="Departure">
		</div>
		<div class="ui-block-solo">
			<input type="text" data-theme="c" id="to" placeholder="Destination">
		</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(
			function() {
				$("#map_canvas").css("width", $("#mainBodyContents").css("width"));
				$("#map_canvas").css("max-height",
						$(window).height() - $(".jqm-header").css("height"));
				$("#map_canvas").css(
						"min-height",
						$(window).height() - $("#mainBodyContents").css("height")
								+ $("#mainBodyContents").css("padding-top"));
			});
	var map, directionsService, directionsDisplay, infoWindow, marker, input, markerDestination;
	var travelM = 'WALKING';
	function findDeparture(x, y) {
		var url = "http://maps.googleapis.com/maps/api/geocode/json?latlng=" + x + "," + y
				+ "&sensor=true";
		$.ajax({
			url : url,
			cache : false,
			success : function(data) {
				var tmp = data.results[0].formatted_address;
				$("#from").val(tmp);
			}
		});
	}

	function initMap() {
		var myLatLng = {
			lat : -31.569743,
			lng : 27.246471
		};
		infoWindow = new google.maps.InfoWindow();
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
				myLatLng = {
					lat : position.coords.latitude,
					lng : position.coords.longitude
				};
				findDeparture(position.coords.latitude, position.coords.longitude);
				marker = new google.maps.Marker({
					position : myLatLng,
					map : map
				});
				map.setCenter(myLatLng);
			}, function() {
				handleLocationError(true, infoWindow, map.getCenter());
			});
			map = new google.maps.Map(document.getElementById('map_canvas'), {
				zoom : 18,
				streetViewControl : true,
				fullscreenControl : true
			});
		} else {
			handleLocationError(false, infoWindow, map.getCenter());
		}
		input = document.getElementById('to');
		map.controls[google.maps.ControlPosition.BOTTOM_LEFT].push(document
				.getElementById('searchFields'));
		var autocomplete = new google.maps.places.Autocomplete(input);
		autocomplete.bindTo('bounds', map);
		// 		var infowindowContent = document.getElementById('infowindow-content');
		markerDestination = new google.maps.Marker({
			map : map,
			anchorPoint : new google.maps.Point(0, -29)
		});
		directionsService = new google.maps.DirectionsService;
		directionsDisplay = new google.maps.DirectionsRenderer;
		autocomplete.addListener('place_changed', function() {
			// 					infoWindow = new google.maps.InfoWindow();
			markerDestination.setVisible(false);
			marker.setVisible(false);
			var place = autocomplete.getPlace();
			if (!place.geometry) {
				window.alert("No details available for input: '" + place.name + "'");
				return;
			}
			if (place.geometry.viewport) {
				map.fitBounds(place.geometry.viewport);
			} else {
				map.setCenter(place.geometry.location);

				map.setZoom(17); // Why 17? Because it looks good.
			}
			markerDestination.setPosition(place.geometry.location);
			var bounds = new google.maps.LatLngBounds();
			bounds.extend(markerDestination.getPosition());
			bounds.extend(marker.getPosition());
			map.fitBounds(bounds);
			calculateAndDisplayRoute();
		});
		autocomplete.setTypes([]);
	}

	function calculateAndDisplayRoute() {
		directionsDisplay.setMap(null);
		directionsDisplay.setMap(map);
		directionsService.route(
				{
					origin : new google.maps.LatLng(marker.getPosition().lat(), marker
							.getPosition().lng()),
					destination : new google.maps.LatLng(markerDestination.getPosition().lat(),
							markerDestination.getPosition().lng()),
					travelMode : travelM
				}, function(response, status) {
					if (status === 'OK') {
						directionsDisplay.setDirections(response);
						alert(response.routes[0].legs[0].distance.value);
						alert(response.routes[0].legs[0].duration.value);
						alert(response.routes[1].legs[0].duration.value);
					} else {
						window.alert('Directions request failed due to ' + status);
					}
				});
	}

	function handleLocationError(browserHasGeolocation, infoWindow, pos) {
		infoWindow.setPosition(pos);
		infoWindow.setContent(browserHasGeolocation ? 'Error: The Geolocation service failed.'
				: 'Error: Your browser doesn\'t support geolocation.');
		infoWindow.open(map);
	}
</script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&libraries=places&callback=initMap"
	type="text/javascript"></script>
</html>