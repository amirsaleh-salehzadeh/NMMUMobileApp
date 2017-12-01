<%@page import="common.location.LocationTypeENT"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						// 		selectRightPanelVal();
						$("#editBoundaryPopup").css("display", "none");
						$("#rightpanel").trigger("updatelayout");
						$(".liLocationLV")
								.each(
										function() {
											$(this)
													.bind(
															'onclick',
															function(e) {
																alert('Selected Name='
																		+ $(
																				this)
																				.attr(
																						'value'));
															});
										});
						$(".rightSidePanel")
								.on(
										"panelbeforeopen",
										function(event, ui) {
											selectThisLocationType(null);
											$(this)
													.css(
															"top",
															parseInt($(
																	".jqm-header")
																	.height())
																	+ parseInt($(
																			"#locPathModeRadiobtn")
																			.height())
																	+ 7);
											$("#markerName").focus();
										});
					});
	function showHideSettingsMenu() {
		$("#openLocationEditMenu").trigger("click");

	}

	function showHideMainBoundary() {
		if ($("#editBoundaryPopup").css("display") == "none")
			$("#editBoundaryPopup").css("display", "block");
		else
			$("#editBoundaryPopup").css("display", "none");
	}
</script>

<link href="css/location/croppie.css" rel="stylesheet">
<link href="css/location/management/path.management.css"
	rel="stylesheet">
<link href="css/location/management/path.management.location.edit.css"
	rel="stylesheet">
<link href="css/location/management/path.management.polygon.css"
	rel="stylesheet">
<link href="css/location/management/path.management.toolbox.css"
	rel="stylesheet">
</head>
<input type="hidden" id="parentLocationId" value="360">
<input type='hidden' id='locationTypeId' value="0">
<input type='hidden' id='parentLocationTypeId' value="0">
<input type="hidden" name="destinationId" id="destinationId">
<input type="hidden" name="destinationGPS" id="destinationGPS">
<input type="hidden" name="departureId" id="departureId">
<input type="hidden" name="departureGPS" id="departureGPS">
<input type="hidden" name="pathId" id="pathId">
<input type="hidden" name="markerCoordinate" id="markerCoordinate">
<input type="hidden" name="markerId" id="markerId">
<input type="hidden" id="pathLatLng">
<input type="hidden" name="pathTypeIds" id="pathTypeIds">



<div class="ui-block-solo" id="mapSatelViewIcon"
	style="width: inherit; padding: 3px; margin: 2px;"
	onclick="mapSattelView();">
	<img alt="" src="images/icons/satellite.png" width="32" height="32"
		id="mapSatelViewImage" />
</div>

<a href="#locationEditPanel" data-mini="true" data-role="button"
	class="ui-shadow ui-corner-all ui-btn-icon-left ui-icon-info"
	id="openLocationEditMenu"><img width='24' height='24'
	src='images/icons/add.png'>NEW</a>
<a href="#pathEditPanel" data-role="button" style="display: none;"
	id="pathEditPanelBTN"></a>
<!-- SEARCH FEILD RIGHT SIDE -->
<fieldset data-role="controlgroup" data-mini="true"
	data-type="horizontal" name="optionType" id="locPathModeRadiobtn">
	<label for="marker" class="ui-icon-map-marker"><span
		class="inlineIcon" id="modeSelection_locationText">CAMPUS</span></label> <input
		type="radio" name="radio-choice" id="marker" value="marker"
		checked="checked" onclick="selectActionType();"> <label
		for="path" class="ui-icon-map-path"><span
		class="ui-alt-icon inlineIcon">PATH</span></label> <input type="radio"
		name="radio-choice" id="path" value="path"
		onclick="selectActionType();">
</fieldset>
<div id="infoDiv" class="ui-block-solo">
	<ul data-role="listview" id="infoListView">
	</ul>
</div>



<!-- LOCATION EDIT PANEL LOCATION EDIT PANEL LOCATION EDIT PANEL LOCATION EDIT PANEL LOCATION EDIT PANEL  -->



<div data-role="panel" id="locationEditPanel" data-position="right"
	data-display="overlay"
	class="ui-panel ui-panel-position-right ui-panel-display-overlay 
	ui-panel-animate ui-panel-open rightSidePanel"
	data-dismissible="false" data-swipe-close="false">
	<input type="hidden" name="icon" id="icon" value=""> <input
		type="hidden" name="boundary" id="boundary" value="">
	<div class="ui-block-solo editlocationFormRow">
		<label for="locationType" id="locationTypeLabel"></label>
		<div class="ui-field-contain">
			<div data-role="controlgroup" name="locationType" id="locationType"
				data-mini="true"></div>
		</div>
	</div>
	<div class="ui-block-solo editlocationFormRow">
		<label for="markerName" id="markerLabel">Label</label> <input
			class="pathMenu" type="text" placeholder="Label" name="markerName"
			id="markerName" value="">
	</div>
	<div class="ui-block-solo editlocationFormRow pathMenu">
		<label for="locationDescription" id="DescriptionLabel">Description</label>
		<textarea type="text" placeholder="Description"
			name="locationDescription" id="locationDescription" value="" rows="5"></textarea>
	</div>
	<div class="ui-block-solo editlocationFormRow"
		onclick="showHideMainBoundary();">
		<img src="images/icons/polygon.png" id="editBoundaryIcon" width="48"
			height="48" style="cursor: pointer;" />Edit Boundary

	</div>
	<div class="ui-block-solo editlocationFormRow"
		onclick="$('#editIconPopup').popup('open');" id="locationIcon">
		<img src="images/icons/image.png" id="editIconIcon" width="48"
			height="48" style="cursor: pointer;" />Edit Thumbnail
	</div>

	<!-- 	<div class="ui-block-solo editlocationFormRow" -->
	<!-- 		onclick="" id="calendarIcon"> -->
	<!-- 		<img src="images/icons/calendar.png" id="editIconIcon" width="48" -->
	<!-- 			height="48" style="cursor: pointer;" />Schedule Access  -->
	<!-- 	</div> -->

	<div class="ui-grid-a editlocationFormRow">
		<div class="ui-block-a">
			<a style="cursor: pointer;" data-role="button" href="#"
				class="pathMenu ui-btn ui-shadow save-icon " onclick="saveMarker()">Save</a>
		</div>
		<div class="ui-block-b">
			<a style="cursor: pointer;" data-role="button" href="#"
				class="pathMenu ui-btn ui-shadow cancel-icon "
				onclick="removeMarker()">Remove</a>
		</div>
	</div>
	<a style="cursor: pointer;" data-role="button" href="#"
		class="pathMenu ui-btn ui-shadow save-icon editlocationFormRow"
		onclick="printBarcode($('#markerId').val(),$('#markerName').val())">Print
		Barcode</a> <a href="#" data-rel="close"
		class=" pathMenu ui-btn ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-left editlocationFormRow"
		id="closeLocationEditMenu">Close Settings</a>
</div>



<!-- INSERT PATH POPUP INSERT PATH POPUP INSERT PATH POPUP INSERT PATH POPUP INSERT PATH POPUP INSERT PATH POPUP INSERT PATH POPUP -->



<div data-role="panel" id="pathEditPanel" data-position="right"
	data-display="overlay"
	class="ui-panel ui-panel-position-right ui-panel-display-overlay 
	ui-panel-animate ui-panel-open rightSidePanel"
	data-dismissible="false" data-swipe-close="false">
	<div class="ui-block-solo editlocationFormRow "
		style="white-space: nowrap;">
		<label for="pathWidth">Path Width (Meters)</label>
		<div class="ui-field-contain">
			<input class="pathMenu" type="range" placeholder="Label"
				name="pathWidth" id="pathWidth" value="5" min="0" max="50">
		</div>
	</div>
	<div class="ui-block-solo editlocationFormRow">
		<label for="departure">From</label> <input type="text"
			placeholder="From" class="pathMenu" name="departure" id="departure"
			value="">
	</div>
	<div class="ui-block-solo editlocationFormRow">
		<label for="destination">To</label> <input type="text"
			placeholder="To" class="pathMenu" name="destination" id="destination"
			value="">
	</div>
	<div class="ui-block-solo editlocationFormRow">
		<label for="pathLength">Path Length</label> <span id="pathLength"></span>
	</div>
	<div class="ui-block-solo editlocationFormRow">
		<label for="pathName">Label</label> <input class="pathMenu"
			type="text" placeholder="Label" name="pathName" id="pathName"
			value="">
	</div>
	<div class="ui-block-solo editlocationFormRow pathMenu">
		<label for="pathDescription" id="DescriptionLabel">Description</label>
		<textarea type="text" placeholder="Description" name="pathDescription"
			id="pathDescription" value="" rows="5"></textarea>
	</div>
	<div class="ui-grid-a editlocationFormRow">
		<div class="ui-block-a">
			<a style="cursor: pointer;" data-role="button" href="#"
				class="pathMenu ui-btn ui-shadow save-icon " onclick="saveThePath()">Save</a>
		</div>
		<div class="ui-block-b">
			<a style="cursor: pointer;" data-role="button" href="#"
				class="pathMenu ui-btn ui-shadow cancel-icon "
				onclick="removePath()">Remove</a>
		</div>
	</div>

	<a href="#" data-rel="close"
		class="pathMenu ui-btn ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-left editlocationFormRow"
		id="closeLocationEditMenu">Close Settings</a>
</div>



<!-- MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP  -->



<div id="map_canvas"></div>



<!-- LOADING LOADING LOADING LOADING LOADING LOADING LOADING LOADING LOADING LOADING LOADING LOADING LOADING  -->



<div id="loadingOverlay">
	<div class="markerLoading" style="display: none;"></div>
	<span id="loadingContent" style="display: none;"></span>
</div>



<!-- EDIT ICON POPUP EDIT ICON POPUP EDIT ICON POPUP EDIT ICON POPUP EDIT ICON POPUP EDIT ICON POPUP EDIT ICON POPUP -->



<div data-role="popup" id="editIconPopup" data-position-to="window"
	data-transition="turn" style="width: 100%; padding: 7px 7px 7px 7px;">
	<a href="#" data-role="button" data-theme="a" data-icon="delete"
		data-iconpos="notext" class="ui-btn-right closeMessageButtonIcon"
		onclick="$('#editIconPopup').popup('close'); ">Close</a>
	<div class="pathMenu" id="IconCollapsible">
		<h1 class="pathMenu">Icon</h1>
		<div class="ui-block-solo" id="iconDiv">
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



<!-- EDIT BOUNDARY POPUP EDIT BOUNDARY POPUP EDIT BOUNDARY POPUP EDIT BOUNDARY POPUP EDIT BOUNDARY POPUP EDIT BOUNDARY POPUP  -->



<div id="editBoundaryPopup" class="ui-grid-a toolBar">
	<img src='images/icons/cursor-pointer.png' class="pathMenu" width="48"
		height="48" title="Free Select Mode" onclick="removeDrawingMode()"><img
		src='images/icons/polygon-select.png' width="48" height="48"
		class="pathMenu" title="Drawing Mode" onclick="setDrawingMode()" /> <img
		src='images/icons/delete-icon.png' width="48" height="48"
		class="pathMenu" title="Delete Boundary" onclick="setDrawingMode()" />
	<span id="selectBoundaryColor" title="Select A Colour"
		onclick="selectColor()"></span>
	<div id="color-palette"></div>
	<!-- 		 For later work	<span>Boundary Edit Points</span> -->
</div>



<!-- PATH TYPE POPUP PATH TYPE POPUP PATH TYPE POPUP vPATH TYPE POPUP PATH TYPE POPUP PATH TYPE POPUP PATH TYPE POPUP PATH TYPE POPUP -->



<div id="pathTypePopup" class="ui-grid-solo toolBar">
	<logic:iterate id="pathTIteration" name="pathTypes"
		type="common.location.PathTypeENT">
		<img src='images/icons/cursor-pointer.png' class="pathTypeIcon"
			alt="<%=pathTIteration.getPathTypeId()%>" width="48" height="48"
			title="<%=pathTIteration.getPathType()%>"
			onclick="selectIcon('<%=pathTIteration.getPathTypeId()%>');">
	</logic:iterate>
</div>



<script src="js/croppie.js"></script>
<script src="js/leanModal.min.js"></script>
<script src="js/jquery.Jcrop.min.js"></script>
<script type="text/javascript"
	src="js/location/management/path.data.transaction.js"></script>
<script type="text/javascript"
	src="js/location/management/path.polyline.drawing.js"></script>
<script type="text/javascript"
	src="js/location/management/path.polyline.interaction.js"></script>
<script type="text/javascript" src="js/location/management/path.type.js"></script>
<script type="text/javascript"
	src="js/location/management/path.management.map.js"></script>
<script type="text/javascript"
	src="js/location/management/path.management.image.js"></script>
<script type="text/javascript"
	src="js/location/management/path.management.polygon.js"></script>
<script type="text/javascript"
	src="js/location/management/path.management.js"></script>
<script type="text/javascript"
	src="js/location/management/path.management.marker.js"></script>
<script type="text/javascript"
	src="js/location/management/path.management.panel.js"></script>
<script async defer
	src="http://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&libraries=drawing&callback=initMap"
	type="text/javascript"></script>
<script type="text/javascript" src="js/location/google.map.label.js"></script>
</html>