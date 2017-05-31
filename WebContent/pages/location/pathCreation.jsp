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

.ui-icon-map-marker:after {
	background-image:
		url("../images/icons/marker.png");
	background-size: 23px 23px;
	border-radius: 0;
}

.ui-icon-map-path:after {
	background-image:
		url("../images/icons/journey.png");
	background-size: 23px 23px;
	border-radius: 0;
}

</style>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&libraries=places&callback=initMap"
	type="text/javascript"></script>
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
				class="ui-alt-icon ui-icon-map-marker ui-btn-icon-notext inlineIcon NoDisk"></span></label>
			<input type="radio" name="radio-choice-v-2" id="walking" value="on"
				checked="checked"> <label for="bicycle"><span
				class="ui-alt-icon ui-icon-map-path ui-btn-icon-notext inlineIcon NoDisk"></span></label>
			<input type="radio" name="radio-choice-v-2" id="bicycle" value="on">
			<label for="driving"><span
				class="ui-alt-icon ui-icon-driving ui-btn-icon-notext inlineIcon NoDisk"></span></label>
			<input type="radio" name="radio-choice-v-2" id="driving" value="on">
		</fieldset>
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
			// 			markerDestination.setVisible(true);
			// 					var address = '';
			// 					if (place.address_components) {
			// 						address = [
			// 								(place.address_components[0]
			// 										&& place.address_components[0].short_name || ''),
			// 								(place.address_components[1]
			// 										&& place.address_components[1].short_name || ''),
			// 								(place.address_components[2]
			// 										&& place.address_components[2].short_name || '') ]
			// 								.join(' ');
			// 					}
			// 					infowindowContent.children['place-icon'].src = place.icon;
			// 					infowindowContent.children['place-name'].textContent = place.name;
			// 					infowindowContent.children['place-address'].textContent = address;
			// 					infowindow.open(map, markerDestination);
			calculateAndDisplayRoute();
		});
		autocomplete.setTypes([]);
	}

	function calculateAndDisplayRoute() {
		directionsDisplay.setMap(null);
		directionsDisplay.setMap(map);
		// 		var wp = new Array();
		// 		wp[0] = new google.maps.LatLng(marker.getPosition().lat(), marker.getPosition().lng());
		// 		wp[1] = new google.maps.LatLng(markerDestination.getPosition().lat(), markerDestination.getPosition()
		// 				.lng());
		// 		directionsService.loadFromWaypoints(wp);
		// 		google.maps.DirectionsService.addListener(directionsService, "load", function() {
		// 			alert(directionsService.getDuration().seconds + " seconds");
		// 		});
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
</html>