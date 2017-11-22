<%@page import="common.location.LocationTypeENT"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
	function showHideSettingsMenu() {
		$("#openLocationEditMenu").trigger("click");
	}
</script>

<link href="css/location/croppie.css" rel="stylesheet">
<link href="css/location/management/path.management.css"
	rel="stylesheet">
<link href="css/location/management/path.management.toolbox.css"
	rel="stylesheet">
<link href="css/location/management/path.management.location.edit.css"
	rel="stylesheet">
<link href="css/location/management/path.management.polygon.css"
	rel="stylesheet">
</head>
<input type="hidden" id="parentLocationId" value="360">
<input type='hidden' id='locationTypeId' value="0">
<input type='hidden' id='locationTypeDefinition' value='def'>
<input type="hidden" name="destinationId" id="destinationId">
<input type="hidden" name="departureId" id="departureId">
<input type="hidden" name="markerCoordinate" id="markerCoordinate">
<input type="hidden" name="markerId" id="markerId">
<input type="hidden" id="pathLatLng">
<!-- <div id="topToolBox" class="ui-block-solo"> -->
<a href="#menuPanel" data-mini="true" data-role="button"
	class="ui-shadow ui-corner-all ui-btn-icon-left ui-icon-info"
	id="openLocationEditMenu"><img width='24' height='24'
	src='images/icons/add.png' class=''>NEW</a>
<!-- SEARCH FEILD RIGHT SIDE -->
<fieldset data-role="controlgroup" data-mini="true"
	data-type="horizontal" name="optionType" id="locPathModeRadiobtn">
	<label for="marker" class="ui-icon-map-marker"><span
		class="inlineIcon">CAMPUS</span></label> <input type="radio"
		name="radio-choice" id="marker" value="marker" checked="checked"
		onclick="selectActionType();"> <label for="path"
		class="ui-icon-map-path"><span class="ui-alt-icon inlineIcon">PATH</span></label>
	<input type="radio" name="radio-choice" id="path" value="path"
		onclick="selectActionType();">
</fieldset>
<div id="infoDiv" class="ui-block-solo">
	<ul data-role="listview" id="infoListView">
	</ul>
</div>
<!-- </div> -->
<div data-role="panel" id="menuPanel" data-position="right"
	data-display="overlay"
	class="ui-panel ui-panel-position-right ui-panel-display-overlay 
	ui-panel-animate ui-panel-open"
	data-dismissible="false" data-swipe-close="false">
	<div class="ui-block-solo">
		<label for="markerName" class="formLabel" id="markerLabel">Campus</label>
		<input class="pathMenu" type="text" placeholder="Label"
			name="markerName" id="markerName" value="">
	</div>
	<div class="ui-block-solo">
		<label for="locationType"></label>
		<div class="ui-field-contain">
			<select name="locationType" id="locationType" data-mini="true">
				<option value="2">Area</option>
				<option value="3">Building</option>
				<option value="5">Intersection</option>
				<option value="11">Entrance</option>
			</select>
		</div>
	</div>
	<div class="ui-block-solo">
		<label for="locationDescription" id="DescriptionLabel"></label>
		<textarea class="pathMenu" type="text" placeholder="Description"
			name="locationDescription" id="locationDescription" value="" rows="5"></textarea>
	</div>
	<input type="hidden" name="icon" id="icon" value=""> <input
		type="hidden" name="boundary" id="boundary" value="">
	<div class="pathMenu ui-block-solo"
		onclick="$('#editBoundaryPopup').popup('open');" id="locationIcon">
		<img src="images/icons/polygon.png" id="editIconIcon" width="48"
			height="48" style="cursor: pointer;" /> Edit Boundary
	</div>
	<div class="pathMenu ui-block-solo"
		onclick="$('#editIconPopup').popup('open');" id="locationIcon">
		<img src="images/icons/image.png" id="editIconIcon" width="48"
			height="48" style="cursor: pointer;" /> Edit Icon
	</div>
	<div class="ui-block-solo">
		<a style="cursor: pointer;" data-role="button" href="#"
			class="pathMenu ui-btn ui-shadow save-icon " onclick="saveMarker()">Save</a>
	</div>
	<div class="ui-block-solo">
		<a style="cursor: pointer;" data-role="button" href="#"
			class="pathMenu ui-btn ui-shadow save-icon "
			onclick="printBarcode($('#markerId').val(),$('#markerName').val())">Print
			Barcode</a>
	</div>
	<div class="ui-block-solo">
		<a style="cursor: pointer;" data-role="button" href="#"
			class="pathMenu ui-btn ui-shadow cancel-icon "
			onclick="removeMarker()">Remove</a>
	</div>
	<a href="#" data-rel="close"
		class=" pathMenu ui-btn ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-left ui-btn-inline"
		id="closeLocationEditMenu">Close Settings</a>
</div>

<div id="map_canvas"></div>
<div id="loadingOverlay">
	<div class="markerLoading" style="display: none;"></div>
	<span id="loadingContent" style="display: none;"></span>
</div>

<!-- EDIT ICON POPUP -->
<div data-role="popup" id="editIconPopup" data-position-to="window"
	data-transition="turn" style="width: 100%; padding: 7px 7px 7px 7px;">
	<a href="#" data-role="button" data-theme="a" data-icon="delete"
		data-iconpos="notext" class="ui-btn-right closeMessageButtonIcon"
		onclick="$('#editIconPopup').popup('close'); ">Close</a>
	<div class="pathMenu" id="IconCollapsible">
		<h1 class="pathMenu">Icon</h1>
		<div class="ui-block-solo" id="IconDiv">
			<div id="modal" class="pathMenu">
				<span>Upload file for icon</span> <input class="pathMenu"
					type="file" id="upload" value="Choose Image" accept="image/*">
				<div id="main-cropper"></div>
				<div id="iconCropDiv">
					<img id="croppedIcon" src="" alt="" />
				</div>
				</br>
				<button class="cropIcon pathMenu" id="cropIcon">Crop Icon</button>
			</div>
		</div>
	</div>
</div>



<div data-role="popup" id="editBoundaryPopup" data-position-to="window"
	data-transition="turn" style="width: 100%; padding: 7px 7px 7px 7px;">
	<a href="#" data-role="button" data-theme="a" data-icon="delete"
		data-iconpos="notext" class="ui-btn-right closeMessageButtonIcon"
		onclick="$('#editBoundaryPopup').popup('close'); ">Close</a>
	<h1 class="pathMenu">Boundary</h1>
	<div class="ui-grid-solo">
		<span class="pathMenu">Boundary Edit Controls</span>
		<button class="pathMenu" id="hand-button"
			onclick="removeDrawingMode()">Free Select Mode</button>
		<button class="pathMenu" id="drawing-button"
			onclick="setDrawingMode()">Select Drawing Mode</button>
		<button class="pathMenu" id="delete-button">Delete Selected
			Boundary</button>
	</div>
	    
	<div class="ui-grid-solo">
		<span>Boundary Styling</span>
		<div id="panelColour">
			<span>Select A Colour</span>
			<div id="color-palette"></div>
		</div>
	</div>
	    
	<div class="ui-grid-solo">
		<!-- 		 For later work	<span>Boundary Edit Points</span> -->
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
			class="ui-btn ui-shadow save-icon " onclick="saveThePath()">Save</a>
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
<script async defer
	src="https
	://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&libraries=drawing&callback=initMap"
	type="text/javascript"></script>
</html>