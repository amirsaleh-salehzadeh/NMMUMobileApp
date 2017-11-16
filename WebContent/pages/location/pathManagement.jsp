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

#infoDiv {
	position: absolute;
	display: inline;
	border: thick 4pt;
	border-color: black;
	font-size: 16pt;
	font-weight: bold;
	margin: 1em;
	background-color: #9b221f;
	font-size: 12pt;
	cursor: pointer;
}

#infoDivTitle {
	display: inline-block;
	opacity: 1 !important;
}

#parentLocationListView {
	position: absolute;
	z-index: 100;
	background-color: white;
	width: 100%;
}

.locationTypeNavBar {
	display: block;
	min-height: 3em;
	font-size: 16pt;
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

#BoundaryEdit {
	background-color: transparent;
}

#panelColour {
	/*width: 250px;*/
	font-family: Arial, sans-serif;
	font-size: 13px;
	/*float: left;*/
	/*margin: 10px;*/
}

#color-palette {
	clear: both;
}

.color-button {
	width: 14px;
	height: 14px;
	font-size: 0;
	margin: 2px;
	float: left;
	cursor: pointer;
}

#hand-button {
	margin-top: 5px;
	width: 250px;
}

#drawing-button {
	margin-top: 5px;
	width: 250px;
}

#delete-button {
	margin-top: 5px;
	width: 250px;
}

#imageEdit .ui-btn {
	overflow: visible;
	padding: .3em .1em;
}

#locationDescription {
	overflow-y: scroll;
	max-height: 100px;
	min-width: 333px;
	resize: none;
}
/*
#views {
    display: block;
    border: none;
    visibility: visible;
    margin: 0px;
    padding: 0px;
    position: relative;
    width: 400px;
    height: 225px;
}
*/
</style>
<script type="text/javascript">
	$(document).ready(function() {
		// 		selectRightPanelVal();
		$("#rightpanel").trigger("updatelayout");
		$(".liLocationLV").each(function() {
			$(this).bind('onclick', function(e) {
				alert('Selected Name=' + $(this).attr('value'));
			});
		});
	});
	// DST 
	//Distance in Metres
	//Speed in KMH
	//Time in Hours minutes seconds
	function getTime(distance, speed) {
		var TotalTime = (distance / 1000) / speed;
		var Hours = floor(TotalTime);
		var Minutes = floor((TotalTime - Hours) * 60);
		var Seconds = round((TotalTime - Hours - Minutes) * 60);
		var Kilometres = floor(distance / 1000);
		var Metres = round(distance - (Kilometres * 1000));
		var String = "You are "
				+ Kilometres
				+ " kilometer/s and "
				+ Metres
				+ " meter/s away from the destination. You will be there in about "
				+ Hours + " hour/s " + Minutes + " minute/s and " + Seconds
				+ " second/s.";
		return String;
	}
</script>
<link rel="stylesheet" href="css/jquery.treefilter.css">
<link href="css/location/croppie.css" rel="stylesheet">

<link href="css/location/management/path.management.css"
	rel="stylesheet">
<link href="css/location/management/path.management.toolbox.css"
	rel="stylesheet">
</head>
<div>
	<input type="hidden" id="parentLocationId" value="360"> <input
		type='hidden' id='locationTypeId' value="0"> <input
		type='hidden' id='locationTypeDefinition' value='def'> <input
		type="hidden" name="destinationId" id="destinationId"><input
		type="hidden" name="departureId" id="departureId"><input
		type="hidden" name="markerCoordinate" id="markerCoordinate"> <input
		type="hidden" name="markerId" id="markerId"> <input
		type="hidden" id="pathLatLng">

	<!-- 	<div class="ui-field-contain" id="locationsUnderAType"> -->
	<!-- 		<form> -->
	<!-- 			    <input data-type="search" id="parentLocation"> -->
	<!-- 			<div data-role="controlgroup" data-filter="true" -->
	<!-- 				data-input="#parentLocation" id="parentLocationListView"></div> -->
	<!-- 		</form> -->
	<!-- 	</div> -->
</div>



<div id="infoDiv">
	<ul data-role="listview" id="infoListView">
		<li id="locationTypeToAdd"></li>
		<li id="parentDescriptionToAdd"></li>
	</ul>
</div>

<div class="ui-grid-a" id="topToolBox" style="top: 0;">
	<div style="top: 0;" class="ui-block-a"
		onclick="selectALocationTypeToAdd(3)">
		Add Building<br> <img src="images/map-markers/building.png"
			width="48" height="48" />
	</div>
	<div style="top: 0;" class="ui-block-b"
		onclick="selectALocationTypeToAdd(5)">
		Add Intersection<br> <img src="images/map-markers/crossroad.png"
			width="48" height="48">
	</div>
</div>

<div data-role="collapsible" id="BoundaryEdit"
	data-collapsed-icon="carat-d" data-expanded-icon="carat-u"
	data-content-theme="false">
	<!-- 	<div id="panelColour"> -->
	<!-- 		<div id="color-palette"></div> -->
	<!-- 		<div> -->
	<!-- 		<button id="delete-button">Delete Selected Shape</button> -->
	<!-- 		</div> -->
	<!-- 	</div> -->
	<h1>Boundary Toolbar</h1>
	<!-- 	<span>Boundary Edit Controls</span> -->
	<div class="ui-grid-b">
		    
		<div class="ui-block-a">
			<span>Boundary Edit Controls</span>
			<button id="hand-button" onclick="removeDrawingMode()">Free
				Select Mode</button>
			<button id="drawing-button" onclick="setDrawingMode()">Select
				Drawing Mode</button>
			<button id="delete-button">Delete Selected Shape</button>
		</div>
		    
		<div class="ui-block-b">
			<span>Boundary Styling</span> <br>
			<div id="panelColour">
				<span>Select A Colour</span>
				<div id="color-palette"></div>
			</div>
			<br>

		</div>
		    
		<div class="ui-block-c">
			<span>Boundary Edit Points</span>
		</div>
	</div>
</div>

<div id="map_canvas"></div>

<div id="createType"></div>
<div id="map_canvas"></div>
<div id="loadingOverlay">
	<div class="markerLoading" style="display: none;"></div>
	<span id="loadingContent" style="display: none;"></span>
</div>

<div id="infoDiv" class="ui-block-solo">
	<ul data-role="listview" id="infoListView">
		<li id="locationTypeToAdd"></li>
		<li id="parentDescriptionToAdd"></li>
	</ul>
</div>

<!-- SEARCH FEILD RIGHT SIDE -->
<div id="searchFields" style="width: 85%;">
	<fieldset data-role="controlgroup" data-type="horizontal"
		name="optionType">
		<label for="marker"><span
			class="ui-alt-icon ui-icon-map-marker ui-btn-icon-notext inlineIcon NoDisk"></span></label>
		<input type="radio" name="radio-choice" id="marker" value="marker"
			checked="checked" onclick="selectActionType();"> <label
			for="path"><span
			class="ui-alt-icon ui-icon-map-path ui-btn-icon-notext inlineIcon NoDisk"></span></label>
		<input type="radio" name="radio-choice" id="path" value="path"
			onclick="selectActionType();">
	</fieldset>
</div>

<!-- INSERT LOCATION POPUP -->
<div data-role="popup" id="insertAMarker" data-position-to="window"
	data-transition="turn"
	style="background-color: #000000; width: 100%; padding: 7px 7px 7px 7px;">
	<!-- width: 333px; -->
	<a href="#" data-role="button" data-theme="a" data-icon="delete"
		data-iconpos="notext" class="ui-btn-right"
		onclick="$('#insertAMarker').popup('close'); ">Close</a>
	<div>
		<label id="creationLabel"></label>
	</div>
	<div class="ui-block-solo">
		<label for="markerName" id="markerLabel"></label> <input type="text"
			placeholder="Location Name" name="markerName" id="markerName"
			value="">
	</div>
	<div class="ui-block-solo">
		<label for="locationType" id="markerLabel"></label>
		<div class="ui-field-contain">
			<select
				name="locationType" id="locationType" data-mini="true">
				<option value="3">Building</option>
				<option value="5">Intersection</option>
				<option value="11">Entrance</option>
			</select>
		</div>
	</div>
	<div class="ui-block-solo">
		<label for="locationDescription" id="DescriptionLabel"></label>
		<textarea type="text" placeholder="Location Description"
			name="locationDescription" id="locationDescription" value="" rows="5"
			cols="17"></textarea>
	</div>

	<input type="hidden" name="icon" id="icon" value=""> <input
		type="hidden" name="boundary" id="boundary" value="">
	<div class="ui-block-solo" id="IconDiv">
		<div id="modal">
			<span>Upload file for icon</span> <input type="file" id="upload"
				value="Choose Image" accept="image/*">
			<div id="main-cropper"></div>
			<div id="iconCropDiv">
				<img id="croppedIcon" src="" alt="" />
			</div>
			</br>
			<button class="cropIcon" id="cropIcon">Crop Icon</button>
		</div>
	</div>
	<div class="ui-block-solo">
		<input type="button" data-icon="plus" value="Add Boundary"
			id="addBoundary" onclick="addPolygon()">
	</div>

	<div class="ui-block-solo">
		<a style="cursor: pointer;" data-role="button" href="#"
			class="ui-btn ui-shadow save-icon ui-corner-all"
			onclick="saveMarker()">Save</a>
	</div>
	<div class="ui-block-solo">
		<a style="cursor: pointer;" data-role="button" href="#"
			class="ui-btn ui-shadow save-icon ui-corner-all"
			onclick="printBarcode($('#markerId').val(),$('#markerName').val())">Print
			Barcode</a>
	</div>
	<div class="ui-block-solo">
		<a style="cursor: pointer;" data-role="button" href="#"
			class="ui-btn ui-shadow cancel-icon ui-corner-all"
			onclick="removeMarker()">Remove</a>
	</div>
</div>

<!-- INSERT PATH POPUP -->
<div data-role="popup" id="insertAPath" data-position-to="window"
	data-transition="turn"
	style="background-color: #000000; width: 333px; padding: 7px 7px 7px 7px;">
	<a href="#" data-role="button" data-theme="a" data-icon="delete"
		data-iconpos="notext" class="ui-btn-right"
		onclick="$('#insertAPath').popup('close');">Close</a>
	<div class="ui-block-solo">
		<input type="text" placeholder="From" name="departure" id="departure"
			value="">
	</div>
	<div class="ui-block-solo">
		<input type="text" placeholder="To" name="destination"
			id="destination" value="">
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
			class="ui-btn ui-shadow save-icon ui-corner-all"
			onclick="saveThePath()">Save</a>
	</div>
</div>

<script src="js/croppie.js"></script>
<script src="js/leanModal.min.js"></script>
<script src="js/jquery.Jcrop.min.js"></script>
<script type="text/javascript"
	src="js/location/management/path.management.image.js"></script>
<script type="text/javascript"
	src="js/location/management/path.management.polygon.js"></script>
<script type="text/javascript"
	src="js/location/management/path.management.js"></script>
<script type="text/javascript"
	src="js/location/management/path.management.marker.js"></script>
<script type="text/javascript"
	src="js/location/management/path.management.path.js"></script>
<script type="text/javascript"
	src="js/location/management/path.management.panel.js"></script>
<script src="js/jquery.treefilter-0.1.0.js"></script>
<script async defer
	src="https
	://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&libraries=drawing&callback=initMap"
	type="text/javascript"></script>
</html>