<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
.inlineIcon {
	display: inline-block;
	position: relative;
	vertical-align: middle;
	width: auto !important;
}

.ui-icon-map-marker:after {
	background-image: url("images/icons/marker.png");
	background-size: 23px 23px;
	border-radius: 0;
}

.ui-icon-map-path:after {
	background-image: url("images/icons/journey.png");
	background-size: 23px 23px;
	border-radius: 0;
}

#searchFields {
	margin: 0 0 0 0;
	padding-bottom: 12px;
}
</style>
</head>
<body>
	<div id="map_canvas"></div>
	<div id="searchFields" style="width: 85%;">
		<fieldset data-role="controlgroup" data-type="horizontal"
			name="optionType">
			<label for="marker"><span
				class="ui-alt-icon ui-icon-map-marker ui-btn-icon-notext inlineIcon NoDisk"></span></label>
			<input type="radio" name="radio-choice" id="marker" value="marker">
			<label for="path"><span
				class="ui-alt-icon ui-icon-map-path ui-btn-icon-notext inlineIcon NoDisk"></span></label>
			<input type="radio" name="radio-choice" id="path" checked="checked"
				value="path">
		</fieldset>
	</div>
	<div data-role="popup" id="insertAMarker" data-position-to="window"
		data-transition="turn"
		style="background-color: #000000; width: 333px; padding: 7px 7px 7px 7px;">
		<a href="#" data-role="button" data-theme="a" data-icon="delete"
			data-iconpos="notext" class="ui-btn-right"
			onclick="$('#insertAMarker').popup('close');">Close</a>
		<div class="ui-block-solo">
			<input type="text" placeholder="Location Name" name="markerName"
				id="markerName" value="NMMU-Path-Definition-Enterance-"> <input
				type="hidden" name="markerCoordinate" id="markerCoordinate">
		</div>
		<div class="ui-field-contain">
			    <label for="locationType">Location Type</label>     <select
				name="locationType" id="locationType">
				<logic:iterate id="locationTIteration" name="locationTypes"
					type="common.location.LocationTypeENT">
					<option value="<%=locationTIteration.getLocationTypeId()%>"><%=locationTIteration.getLocationType()%></option>
				</logic:iterate>
			</select>
		</div>
		<div class="ui-block-solo">
			<a style="cursor: pointer;" data-role="button" href="#"
				class="ui-btn ui-shadow save-icon ui-corner-all" id="submitRider"
				onclick="saveMarker()">Save</a>
		</div>
	</div>

	<div data-role="popup" id="insertAPath" data-position-to="window"
		data-transition="turn"
		style="background-color: #000000; width: 333px; padding: 7px 7px 7px 7px;">
		<a href="#" data-role="button" data-theme="a" data-icon="delete"
			data-iconpos="notext" class="ui-btn-right"
			onclick="$('#insertAPath').popup('close');">Close</a>
		<div class="ui-block-solo">
			<input type="text" placeholder="From" name="departure" id="departure"
				value=""> <input type="hidden" name="departureId"
				id="departureId">
		</div>
		<div class="ui-block-solo">
			<input type="text" placeholder="To" name="destination"
				id="destination" value=""> <input type="hidden"
				name="destinationId" id="destinationId">
		</div>
		<div class="ui-field-contain">
			    <label for="pathType">Path Type</label> <select name="pathType"
				id="pathType">
				<logic:iterate id="pathTIteration" name="pathTypes"
					type="common.location.PathTypeENT">
					<option value="<%=pathTIteration.getPathTypeId()%>"><%=pathTIteration.getPathType()%></option>
				</logic:iterate>
			</select>
		</div>
		<div class="ui-block-solo">
			<a style="cursor: pointer;" data-role="button" href="#"
				class="ui-btn ui-shadow save-icon ui-corner-all" id="submitRider"
				onclick="savePath()">Save</a>
		</div>
	</div>
</body>
<script type="text/javascript">
	function saveMarker() {
		var url = "REST/GetLocationWS/SaveUpdateLocation?locationName=" + $("#markerName").val()
				+ "&coordinate=" + $("#markerCoordinate").val() + "&locationType="
				+ $("#locationType").val() + "&userName=admin";
		$.ajax({
			url : url,
			cache : false,
			success : function(data) {
				window.location.replace("t_location.do?reqCode=pathCreation");
			}
		});
	}

	function savePath() {
		var url = "REST/GetLocationWS/SavePath?fLocationId=" + $("#departureId").val()
				+ "&tLocationId=" + $("#destinationId").val() + "&pathType=" + $("#pathType").val();
		$.ajax({
			url : url,
			cache : false,
			success : function(data) {
// 				window.location.replace("t_location.do?reqCode=pathCreation");
				$("#departure").val("");
				$("#departureId").val("");
				$("#destination").val("");
				$("#destinationId").val("");
			}
		});
		
	}

	var map, marker;

	function getAllMarkers() {
		var url = "REST/GetLocationWS/GetAllLocationsForUser?userName=admin";
		$.ajax({
			url : url,
			cache : false,
			success : function(data) {
				$.each(data, function(k, l) {
					marker = new google.maps.Marker({
						position : {
							lat : parseFloat(l.gps.split(",")[0]),
							lng : parseFloat(l.gps.split(",")[1].replace(" ", ""))
						},
						map : map,
						title : l.locationName
					});
					marker.addListener('click', function() {
						addToPath(l.locationName, l.locationID);
						alert(l.locationID);
					});
				});
			}
		});
	}

	function getAllPaths() {
		var url = "REST/GetLocationWS/GetAllPathsForUser?userName=admin";
		$.ajax({
			url : url,
			cache : false,
			success : function(data) {
				$.each(data, function(k, l) {
					var pathCoor = [];
					pathCoor.push(new google.maps.LatLng(parseFloat(l.departure.gps.split(',')[0]),
							parseFloat(l.departure.gps.split(',')[1].replace(" ", ""))));
					pathCoor.push(new google.maps.LatLng(
							parseFloat(l.destination.gps.split(',')[0]),
							parseFloat(l.destination.gps.split(',')[1].replace(" ", ""))));
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
						strokeWeight : 2
					});
					pathPolyline.setMap(map);
				});
			}
		});
	}

	function addToPath(name, id) {
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
			openPathCreationPopup();
			var lat = event.latLng.lat();
			var lng = event.latLng.lng();
			$("#markerCoordinate").val(lat + ", " + lng);
		});
		// 		google.maps.event.addDomListener(window, "load", initMap);
	}

	function openPathCreationPopup() {
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			$('#insertAMarker').popup().trigger('create');
			$('#insertAMarker').popup('open').trigger('create');
		} else {
			$('#insertAPath').popup().trigger('create');
			$('#insertAPath').popup('open').trigger('create');
		}
	}

	$(document).ready(
			function() {
				$("#map_canvas").css("min-width", parseInt($("#mainBodyContents").css("width")));
				$("#map_canvas")
						.css(
								"min-height",
								parseInt($(window).height())
										- parseInt($(".jqm-header").css("height")) - 7);
			});
</script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&callback=initMap"
	type="text/javascript"></script>
</html>