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

.ui-icon-dirtroad:after {
	background-image:
		url("http://icons.iconarchive.com/icons/chrisl21/minecraft/24/Grass-icon.png");
	background-size: 24px 24px;
	border-radius: 0;
}
</style>
</head>
<body>
	<div id="map_canvas"></div>
	<div id="searchFields" style="width: 85%;">
		<fieldset data-role="controlgroup" data-mini="true"
			data-type="horizontal">
			<label for="walking"><span
				class="ui-icon-walking ui-btn-icon-notext inlineIcon NoDisk"></span></label>
			<input type="radio" name="radio-choice-v-2" id="walking" value="1"
				checked="checked"> <label for="dirtroad"> <span
				class="ui-icon-dirtroad ui-btn-icon-notext inlineIcon NoDisk"></span></label>
			<input type="radio" name="radio-choice-v-2" id="dirtroad" value="0"
				checked="checked"> <label for="wheelchair"><span
				class="ui-icon-wheelchair ui-btn-icon-notext inlineIcon NoDisk"></span></label>
			<input type="radio" name="radio-choice-v-2" id="wheelchair" value="3">
			<label for="driving"> <span
				class="ui-icon-driving ui-btn-icon-notext inlineIcon NoDisk"></span></label>
			<input type="radio" name="radio-choice-v-2" id="driving" value="4">
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
	function initiMap() {
		var map, marker;
		var myLatLng = {
			lat : -34.009211,
			lng : 25.669051
		};
		marker = new google.maps.Marker({
			position : myLatLng,
			map : map
		});
		map = new google.maps.Map(document.getElementById('map_canvas'), {
			zoom : 17,
			streetViewControl : true,
			fullscreenControl : true
		});
		map.setCenter(myLatLng);
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
</script>
<script type="text/javascript" src="js/location/path.management.js"></script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&libraries=places&callback=initiMap"
	type="text/javascript"></script>
</html>