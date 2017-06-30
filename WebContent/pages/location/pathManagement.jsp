<%@page import="common.location.LocationTypeENT"%>
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
<div id="map_canvas"></div>
<div id="locationTypeFields" style="width: 50%;">
	<form>
		<div data-role="controlgroup" id="locationTypesContainer" data-type="horizontal"
			data-mini="true">
		</div>
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