<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
	background-size: 24px 24px;
	border-radius: 0;
}

.ui-icon-bike:after {
	background-image:
		url("http://icons.iconarchive.com/icons/aha-soft/transport/24/bike-icon.png");
	background-size: 24px 24px;
	border-radius: 0;
}

.ui-icon-driving:after {
	background-image:
		url("http://icons.iconarchive.com/icons/cemagraphics/classic-cars/24/yellow-pickup-icon.png");
	background-size: 24px 24px;
	border-radius: 0;
}

.ui-icon-wheelchair:after {
	background-image:
		url("http://icons.iconarchive.com/icons/icons-land/transport/24/Wheelchair-icon.png");
	background-size: 24px 24px;
	border-radius: 0;
}

.ui-icon-dirt-road:after {
	background-image:
		url("http://icons.iconarchive.com/icons/chrisl21/minecraft/24/Grass-icon.png");
	background-size: 24px 24px;
	border-radius: 0;
}

.ui-icon-start-trip:after {
	background-image:
		url("http://icons.iconarchive.com/icons/custom-icon-design/pretty-office-5/24/start-icon.png");
	background-size: 24px 24px;
	border-radius: 0;
}

.ui-icon-current-location:after {
	background-image:
		url("http://icons.iconarchive.com/icons/ahmadhania/spherical/24/target-icon.png");
	background-size: 24px 24px;
	border-radius: 0;
}

.ui-icon-clear-trip:after {
	background-image:
		url("http://icons.iconarchive.com/icons/wwalczyszyn/iwindows/24/Recycle-Bin-icon.png");
	background-size: 24px 24px;
	border-radius: 0;
}
</style>
</head>
<body>
	<input type="hidden" id="tripId">
	<div data-role="tabs" id="tabs">
		<div data-role="navbar">
			<ul>
				<li><a href="#mapView" data-ajax="false" class="ui-btn-active">Map
						View</a></li>
				<li><a href="#" data-ajax="false" onclick="openAR();">AR
						View</a></li>
			</ul>
		</div>
		<div id="mapView" class="ui-body-d ui-content">
			<input type="hidden" id="tripString">
			<div id="map_canvas"></div>
			<div id="searchFields" style="width: 85%;">
				<div id="navBar" class="ui-grid-a" style="width: 100%;">
					<div class="ui-block-a">
						<fieldset data-role="controlgroup" data-mini="true"
							data-type="horizontal"
							style="float: left; display: inline-block;">
							<label for="walking"><span
								class="ui-icon-walking ui-btn-icon-notext inlineIcon NoDisk"></span></label>
							<input type="radio" name="radio-choice-path-type" id="walking"
								value="1"> <label for="dirtroad"> <span
								class="ui-icon-dirt-road ui-btn-icon-notext inlineIcon NoDisk"></span></label>
							<input type="radio" name="radio-choice-path-type" id="dirtroad"
								value="0" checked="checked"> <label for="wheelchair"><span
								class="ui-icon-wheelchair ui-btn-icon-notext inlineIcon NoDisk"></span></label>
							<input type="radio" name="radio-choice-path-type" id="wheelchair"
								value="3"> <label for="driving"> <span
								class="ui-icon-driving ui-btn-icon-notext inlineIcon NoDisk"></span></label>
							<input type="radio" name="radio-choice-path-type" id="driving"
								value="4">
						</fieldset>
					</div>
					<div class="ui-block-B">
						<fieldset data-role="controlgroup" data-mini="true"
							data-type="horizontal"
							style="float: right; display: inline-block;">
							<label for="clearTrip"><span
								class="ui-icon-clear-trip ui-btn-icon-notext inlineIcon NoDisk"
								onclick="removeTrip()"></span></label> <input type="radio"
								name="radio-choice-v-2" id="clearTrip" value="1"> <label
								for="currentLocation"><span
								class="ui-icon-current-location ui-btn-icon-notext inlineIcon NoDisk"></span></label>
							<input type="radio" name="radio-choice-v-2" id="currentLocation"
								value="1"> <label for="startTrip"><span
								class="ui-icon-start-trip ui-btn-icon-notext inlineIcon NoDisk"
								onclick="startTrip()"></span></label> <input type="radio"
								name="radio-choice-v-2" id="startTrip" value="1">
						</fieldset>
					</div>
				</div>
				<div class="ui-block-solo">
					<input type="hidden" id="from" placeholder="Departure"> <input
						type="hidden" id="departureId" placeholder="DepartureId">
					<input type="text" id="departureName" placeholder="Departure">
				</div>
				<div class="ui-block-solo">
					<input type="hidden" id="to" placeholder="Destination"> <input
						type="hidden" id="destinationId" placeholder="DestinationId">
					<input type="text" id="destinationName" placeholder="Destination">
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	function openAR() {
		var tmp = $('#destinationId').val();
		if (tmp == null || tmp == "null" || tmp == "")
			tmp = 0;
		window.open("insta/docs/index.jsp?destinationId=" + tmp + "&pathType="
				+ $("[name='radio-choice-path-type']:checked").val());
	}
	$(document)
			.ready(
					function() {
						$("#map_canvas").css("min-width",
								parseInt($("#mainBodyContents").css("width")));
						$("#map_canvas").css(
								"min-height",
								parseInt($(window).height())
										- parseInt($(".jqm-header").css(
												"height")) - 7);
					});
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
			zoom : 17
		});
		infoWindow = new google.maps.InfoWindow;

		// Try HTML5 geolocation.
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(successHandler,
					errorHandler, {
						enableHighAccuracy : true,
						maximumAge : 10000
					});
		} else {
			// Browser doesn't support Geolocation
			handleLocationError(false, infoWindow, map.getCenter());
		}
		// 		map = null;
		// 		map = new google.maps.Map(document.getElementById('map_canvas'), {
		// 			zoom : 17,
		// 			streetViewControl : true,
		// 			fullscreenControl : true
		// 		});
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
</script>
<script type="text/javascript" src="js/location/path.management.js"></script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&libraries=places&callback=initiMap"
	type="text/javascript"></script>
</html>