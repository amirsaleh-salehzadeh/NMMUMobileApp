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
	/* 	padding-left: 22em; */
	
}
/*  left panel of parent locations info */
#infoDiv .ui-listview>.ui-li-static,.ui-btn {
	border: thick 4pt;
	border-color: black;
	font-size: 20pt;
	margin: 1em;
	background-color: #00457c;
	font-size: 12pt;
	cursor: pointer;
	color: white;
	border-radius: 25px;
	-webkit-text-stroke-width: 0.3px;
	-webkit-text-stroke-color: black;
}
/* small html text div */
#createType {
	position: absolute;
	display: inline;
	border: thick 4pt;
	border-color: #00457c;
	border-radius: 25px;
	font-size: 30pt;
	font-weight: bold;
	margin: 1em;
	background-color: transparent;
	font-size: 12pt;
	cursor: pointer;
	color: #00457c;
	background-color: transparent;
	background-repeat: no-repeat !important;
	background-position: center !important;
}

#infoDivTitle {
	display: inline-block;
	opacity: 1 !important;
}
/* right side panel */
#parentLocationListView {
	position: absolute;
	z-index: 100;
	background-color: transparent;
	width: 100%;
}

#parentLocationListView .ui-btn {
	border: thick 4pt;
	border-color: black;
	font-size: 20pt;
	margin: 1em;
	background-color: #00457c;
	font-size: 12pt;
	cursor: pointer;
	color: white;
	border-radius: 25px;
	-webkit-text-stroke-width: 0.3px;
	-webkit-text-stroke-color: black;
}
/* top panel */
.locationTypeNavBar {
	display: block;
	min-height: 3em;
	font-size: 16pt;
}

#locationTypesContainer .ui-btn {
	border-color: black;
	font-size: 20pt;
	background-color: #00457c;
	font-size: 12pt;
	cursor: pointer;
	color: white;
	-webkit-text-stroke-width: 0.3px;
	-webkit-text-stroke-color: black;
}

.locationTypeNavBar select {
	display: block;
	background: url('images/map-markers/marker-blue.png') no-repeat left
		100% 100% #FEFEFE;
	background-size: 66px 66px;
}

.locationTypeNavBar option {
	display: block;
	background-color: black !important;
	color: white;
	border-width: 6px;
	border: 2px #fff;
	border-bottom: thin;
	min-height: .7em;
	border-color: white;
}
</style>
</head>
<div>
	<input type="hidden" id="parentLocationId" value="0"> <input
		type='hidden' id='locationTypeId' value='0'> <input
		type='hidden' id='locationTypeDefinition' value='def'>
	<div class="ui-field-contain" id="locationsUnderAType">
		<form>
			    <input data-type="search" id="parentLocation">
			<div data-role="controlgroup" data-filter="true"
				data-input="#parentLocation" id="parentLocationListView"></div>
		</form>

	</div>
</div>
<div id="map_canvas"></div>
<div id="locationTypeFields">
	<form>
		<div data-role="controlgroup" id="locationTypesContainer"
			data-type="horizontal" data-mini="true"></div>
	</form>
	<br />
	<div id="createType"></div>
</div>
<div id="infoDiv">
	<ul data-role="listview" id="infoListView">
	</ul>
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
		<label for="markerName" id="markerLabel"></label> <input type="text"
			placeholder="Location Name" name="markerName" id="markerName"
			value=""> <input type="hidden" name="markerCoordinate"
			id="markerCoordinate"> <input type="hidden" name="markerId"
			id="markerId">
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