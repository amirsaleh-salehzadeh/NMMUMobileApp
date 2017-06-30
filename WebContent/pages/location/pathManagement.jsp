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

#locationTypeFields {
	padding-left: 22em;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		getLocationTypePanel();
		getPathTypePanel();
		selectRightPanelVal();
		$("#rightpanel").trigger("updatelayout");
		$(".liLocationLV").each(function() {
			$(this).bind('onclick', function(e) {
				alert('Selected Name=' + $(this).attr('value'));
			});
		});
	});
</script>
</head>
<div data-role="panel" id="rightpanel" data-position="right"
	data-display="overlay">
	<div class="ui-block-solo" id="locationTypeListViewDiv">
		<ul data-role="listview" data-inset="true" data-filter="true"
			data-filter-placeholder="Location Type..." id="locationTypeListView">
		</ul>
	</div>
	<div class="ui-block-solo" id="pathTypeListViewDiv">
		<ul data-role="listview" data-inset="true" id="pathTypeListView"
			data-filter="true" data-filter-placeholder="Path Type...">
		</ul>
	</div>
</div>
<div id="map_canvas"></div>
<div id="locationTypeFields" style="width: 100%;">
	<form>
		<fieldset data-role="controlgroup" data-type="horizontal"
			data-mini="true">
			    <label for="select-native-14">Select A</label>     <select
				name="select-native-14" id="select-native-14">
			</select>     <label for="select-native-15">Select B</label>     <select
				name="select-native-15" id="select-native-15">
				<option value="#">One</option>
				<option value="#">Two</option>
				<option value="#">Three</option>
			</select>     <label for="select-native-16">Select C</label>     <select
				name="select-native-16" id="select-native-16">
				<option value="#">One</option>
				<option value="#">Two</option>
				<option value="#">Three</option>
			</select>
		</fieldset>
	</form>
</div>
<div id="searchFields" style="width: 85%;">
	<fieldset data-role="controlgroup" data-type="horizontal"
		name="optionType">
		<label for="marker"><span
			class="ui-alt-icon ui-icon-map-marker ui-btn-icon-notext inlineIcon NoDisk"></span></label>
		<input type="radio" name="radio-choice" id="marker" value="marker"
			checked="checked" onclick="selectRightPanelVal();"> <label
			for="path"><span
			class="ui-alt-icon ui-icon-map-path ui-btn-icon-notext inlineIcon NoDisk"></span></label>
		<input type="radio" name="radio-choice" id="path" value="path"
			onclick="selectRightPanelVal();">
	</fieldset>
</div>
<div data-role="popup" id="insertAMarker" data-position-to="window"
	data-transition="turn"
	style="background-color: #000000; width: 333px; padding: 7px 7px 7px 7px;">
	<a href="#" data-role="button" data-theme="a" data-icon="delete"
		data-iconpos="notext" class="ui-btn-right"
		onclick="$('#insertAMarker').popup('close'); ">Close</a>
	<div class="ui-block-solo">
		<input type="text" placeholder="Location Name" name="markerName"
			id="markerName" value=""> <input type="hidden"
			name="markerCoordinate" id="markerCoordinate"> <input
			type="hidden" name="markerId" id="markerId">
	</div>
	<div class="ui-field-contain">
		<!-- 		    <label for="locationType">Location Type</label>     <select -->
		<!-- 			name="locationType" id="locationType"> -->
		<%-- 			<logic:iterate id="locationTIteration" name="locationTypes" --%>
		<%-- 				type="common.location.LocationTypeENT"> --%>
		<%-- 				<option value="<%=locationTIteration.getLocationTypeId()%>"><%=locationTIteration.getLocationType()%></option> --%>
		<%-- 			</logic:iterate> --%>
		<form>
			    <input data-type="search" id="parentLocation">
		</form>
		<div data-role="controlgroup" data-filter="true"
			data-input="#parentLocation" id="parentLocationListView"></div>
	</div>
	<div class="ui-block-solo">
		<a style="cursor: pointer;" data-role="button" href="#"
			class="ui-btn ui-shadow save-icon ui-corner-all" id="submitRider"
			onclick="saveMarker()">Save</a>
	</div>
	<div class="ui-block-solo">
		<a style="cursor: pointer;" data-role="button" href="#"
			class="ui-btn ui-shadow save-icon ui-corner-all" id="submitRider"
			onclick="printBarcode($('#markerId').val(),$('#markerName').val())">Print
			Barcode</a>
	</div>
	<div class="ui-block-solo">
		<a style="cursor: pointer;" data-role="button" href="#"
			class="ui-btn ui-shadow cancel-icon ui-corner-all" id="submitRider"
			onclick="removeMarker()">Remove</a>
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
<script type="text/javascript" src="js/location/path.management.js"></script>
<script async defer
	src="https
	://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&callback=initMap"
	type="text/javascript"></script>
</html>