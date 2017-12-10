<%@page import="common.location.LocationTypeENT"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib prefix="logic" uri="/WEB-INF/struts-logic.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Control Panel</title>
<script type="text/javascript">
	$(document).ready(function() {
		// 		selectRightPanelVal();
		$("#editBoundaryPopup").css("display", "none");
		$("#editPathPopup").css("display", "none");
		$(".liLocationLV").each(function() {
			$(this).bind('onclick', function(e) {
				alert('Selected Name=' + $(this).attr('value'));
			});
		});
	});
</script>


<link href="css/location/colorpicker.css" rel="stylesheet">
<link href="css/location/croppie.css" rel="stylesheet">
<link href="css/location/management/management.css" rel="stylesheet">
<link href="css/location/management/location.edit.css" rel="stylesheet">
<link href="css/location/management/polygon.management.css"
	rel="stylesheet">
<link href="css/location/management/toolbox.management.css"
	rel="stylesheet">
</head>



<!-- HIDDEN INPUTS HIDDEN INPUTS HIDDEN INPUTS HIDDEN INPUTS HIDDEN INPUTS HIDDEN INPUTS HIDDEN INPUTS HIDDEN INPUTS HIDDEN INPUTS HIDDEN INPUTS  -->



<input type="hidden" readonly  id="parentLocationId" value="360">
<input type='hidden' readonly  id='locationTypeId' value="0">
<input type='hidden' readonly id='parentLocationTypeId' value="0">
<input type='hidden' readonly name="destinationId" id="destinationId">
<input type='hidden' readonly name="destinationGPS" id="destinationGPS">
<input type='hidden' readonly name="departureId" id="departureId">
<input type='hidden' readonly name="departureGPS" id="departureGPS">
<input type='hidden' readonly name="pathId" id="pathId">
<input type='hidden' readonly name="markerCoordinate" id="markerCoordinate">
<input type='hidden' readonly name="markerId" id="markerId">
<input type='hidden' readonly id="pathLatLng">
<input type='hidden' readonly name="pathTypeIds" id="pathTypeIds">
<input type='hidden' readonly name="tempBoundaryColors" id="tempBoundaryColors">
<input type='hidden' readonly name="boundaryColors" id="boundaryColors">
<input type='hidden' readonly name="icon" id="icon" value="">
<input type='hidden' readonly name="boundary" id="boundary" value="">




<!-- TOP PANEL ICONS TOP PANEL ICONS TOP PANEL ICONS TOP PANEL ICONS TOP PANEL ICONS TOP PANEL ICONS TOP PANEL ICONS TOP PANEL ICONS TOP PANEL ICONS  -->


<div class="ui-block-solo" id="mapSatelViewIcon"
	style="width: inherit; padding: 3px; margin: 2px;"
	onclick="mapSattelView();">
	<img alt="" src="images/icons/satellite.png" width="48" height="48"
		id="mapSatelViewImage" />
</div>

<a href="#" data-mini="true" data-role="button"
	class="ui-shadow ui-corner-all ui-btn-icon-left ui-icon-info"
	id="openLocationEditMenu"><img width='32' height='32'
	src='images/icons/add.png'>NEW</a>
<a href="#pathEditPanel" data-role="button" style="display: none;"
	id="pathEditPanelBTN"></a>



<!-- PATH/LOCATION SELECT PATH/LOCATION SELECT PATH/LOCATION SELECT PATH/LOCATION SELECT PATH/LOCATION SELECT PATH/LOCATION SELECT PATH/LOCATION SELECT  -->



<fieldset data-role="controlgroup" data-mini="true"
	data-type="horizontal" name="optionType" id="locPathModeRadiobtn">
	<!-- 	AREA -->
	<label for="marker" class="ui-icon-map-marker"><span
		class="inlineIcon" id="modeSelection_locationText">CAMPUS</span></label> <input
		type="radio" name="radio-choice" id="marker" value="marker"
		checked="checked" onclick="selectActionType();">
	<!-- 		PATH -->
	<label for="path" class="ui-icon-map-path"><span
		class="ui-alt-icon inlineIcon">PATH</span></label> <input type="radio"
		name="radio-choice" id="path" value="path"
		onclick="selectActionType();">
</fieldset>



<div id="infoDiv" class="ui-block-solo">
	<ul data-role="listview" id="infoListView">
	</ul>
<!-- 		<label for="locationInfo">Location </label> -->
		<div id="locationInfo" class=""></div>
</div>


<!-- LOCATION EDIT MENU LOCATION EDIT MENU LOCATION EDIT MENU LOCATION EDIT MENU -->



<div data-role="popup" id="locationEditMenu" data-mini="true" data-dismissible="false">
	<ul data-role="listview" style="min-width: 210px;">
		<li data-role="list-divider" id="locationEditMenuTitle">Choose an
			action</li>
		<li data-icon="false"><a href="#" onclick="openALocation();">Open</a></li>
		<li data-icon="false"><a href="#"
			onclick="openLocationTypePopup();">Edit Location Type</a></li>
		<li data-icon="false"><a href="#"
			onclick="openLocationInfoPopup();">Edit Info</a></li>
		<li data-icon="false"><a href="#"
			onclick="showMainBoundary();">Edit Boundary </a></li>
		<li data-icon="false"><a href="#" onclick="openIconPopup();">Edit
				Thumbnail</a></li>
		<li data-role="list-divider"></li>
		<li data-icon="false"><a href="#">Delete</a></li>
		<li data-role="list-divider"></li>
		<li data-icon="false"><a href="#"
			onclick="printBarcode($('#markerId').val(),$('#markerName').val());">Print
				QR</a></li>
		<li data-role="list-divider"></li>
		<li><a href="#" data-rel="back" class="pathMenu ui-btn ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-left" onclick="unselectBoundary();">Close</a></li>
	</ul>
</div>



<!-- LOCATION TYPE POPUP LOCATION TYPE POPUP LOCATION TYPE POPUP LOCATION TYPE POPUP LOCATION TYPE POPUP -->



<div data-role="popup" id="editLocationTypePopup"
	class="menuItemPopupClass">
	<a href="#" data-role="button" data-theme="a" data-icon="delete"
		data-iconpos="notext" class="ui-btn-right closeMessageButtonIcon"
		onclick="$('#editLocationTypePopup').popup('close');unselectBoundary();">Close</a>
	<div class="ui-block-solo editlocationFormRow">
		<label for="locationType" id="locationTypeLabel"></label>
		<div class="ui-field-contain">
			<div data-role="controlgroup" name="locationType" id="locationType"
				data-mini="true"></div>
		</div>
	</div>
	<div class="ui-grid-a editlocationFormRow">
		<div class="ui-block-a">
			<a style="cursor: pointer;" data-role="button" href="#"
				class="pathMenu ui-btn ui-shadow save-icon " onclick="saveMarker()">Save</a>
		</div>
		<div class="ui-block-b">
			<a style="cursor: pointer;" data-role="button" href="#"
				class="pathMenu ui-btn ui-shadow cancel-icon "
				onclick="closeAMenuPopup();">Close</a>
		</div>
	</div>
</div>



<!-- LOCATION INFO POPUP LOCATION INFO POPUP LOCATION INFO POPUP LOCATION INFO POPUP LOCATION INFO POPUP -->



<div data-role="popup" id="editLocationInfoPopup"
	class="menuItemPopupClass">
	<a href="#" data-role="button" data-theme="a" data-icon="delete"
		data-iconpos="notext" class="ui-btn-right closeMessageButtonIcon"
		onclick="$('#editLocationInfoPopup').popup('close');unselectBoundary();">Close</a>
	<div class="ui-block-solo editlocationFormRow">
		<label for="markerName" id="markerLabel">Label</label> <input
			class="pathMenu" type="text" placeholder="Label" name="markerName"
			id="markerName" value="">
	</div>
	<div class="ui-block-solo editlocationFormRow">
		<label for="locationDescription">Description</label>
		<textarea type="text" placeholder="Description"
			name="locationDescription" id="locationDescription" value="" rows="5"></textarea>
	</div>
	<div class="ui-grid-a editlocationFormRow">
		<div class="ui-block-a">
			<a style="cursor: pointer;" data-role="button" href="#"
				class="pathMenu ui-btn ui-shadow save-icon " onclick="saveMarker()">Save</a>
		</div>
		<div class="ui-block-b">
			<a style="cursor: pointer;" data-role="button" href="#"
				class="pathMenu ui-btn ui-shadow cancel-icon "
				onclick="closeAMenuPopup();">Close</a>
		</div>
	</div>
</div>



<!-- EDIT ICON POPUP EDIT ICON POPUP EDIT ICON POPUP EDIT ICON POPUP EDIT ICON POPUP EDIT ICON POPUP EDIT ICON POPUP -->



<div data-role="popup" id="editIconPopup" data-position-to="window"
	data-transition="turn" style="width: 100%; padding: 7px 7px 7px 7px;"
	class="menuItemPopupClass">
	<a href="#" data-role="button" data-theme="a" data-icon="delete"
		data-iconpos="notext" class="ui-btn-right closeMessageButtonIcon"
		onclick="$('#editIconPopup').popup('close');unselectBoundary();">Close</a>
	<div class="pathMenu editlocationFormRow" id="IconCollapsible">
		<label>Icon</label>
		<div class="ui-block-solo" id="iconDiv">
			<!-- 			<div id="modal" class="pathMenu"> -->
			<span>Upload file for icon</span> <input class="pathMenu" type="file"
				id="upload" value="Choose Image" accept="image/*">
			<div id="main-cropper"></div>
			<div id="iconCropDiv">
				<img id="croppedIcon" src="" alt="" />
			</div>
			<button class="cropIcon pathMenu" id="cropIcon">Crop Icon</button>
			<!-- 			</div> -->
		</div>
	</div>
	<div class="ui-grid-a editlocationFormRow">
		<div class="ui-block-a">
			<a style="cursor: pointer;" data-role="button" href="#"
				class="pathMenu ui-btn ui-shadow save-icon " onclick="saveMarker()">Save</a>
		</div>
		<div class="ui-block-b">
			<a style="cursor: pointer;" data-role="button" href="#"
				class="pathMenu ui-btn ui-shadow cancel-icon "
				onclick="closeAMenuPopup();">Close</a>
		</div>
	</div>
</div>



<!-- EDIT BOUNDARY POPUP EDIT BOUNDARY POPUP EDIT BOUNDARY POPUP EDIT BOUNDARY POPUP EDIT BOUNDARY POPUP EDIT BOUNDARY POPUP  -->



<div id="editBoundaryPopup" class="toolBar">
	<div class="ui-grid-e editlocationFormRow">
		<div class="ui-block-a">
			<img src='images/icons/cursor-pointer.png' class="pathMenu" width="48"
				height="48" title="Normal Mode" onclick="removeDrawingMode()">
			<img src='images/icons/polygon-select.png' width="48" height="48"
				class="pathMenu" title="Drawing Mode" onclick="setDrawingMode()" />
			<img src='images/icons/edit.png' width="48" height="48" id="editBoundary"
				class="pathMenu" title="Edit Boundary Points"/>
			<img src='images/icons/delete-icon.png' width="48" height="48"
				class="pathMenu" title="Delete Boundary" onclick="deletePolygon()" />
		</div>
		<div class="ui-block-b">
			<div id="boundaryColorFieldset">
				<span>Fill Colour</span>
				<div id="colorSelectorFill">
					<div style="background-color: #1E90FF"></div>
				</div>
				<span>Border Colour</span>
				<div id="colorSelectorBorder">
					<div style="background-color: #1E90FF"></div>
				</div>
				<div id="color-palette" style="display: none"></div>
			</div>
			<img src='images/icons/undo.png' class="pathMenu" width="48"
				height="48" title="Undo Colour Change" onclick="undoColourChange()">
		</div>
		<div class="ui-block-c">
			<a style="cursor: pointer;" data-role="button" href="#"
				class="pathMenu ui-btn ui-shadow save-icon " onclick="saveMarker()">Save</a>
		</div>
		<div class="ui-block-d">
			<a style="cursor: pointer;" data-role="button" href="#"
				class="pathMenu ui-btn ui-shadow cancel-icon "
				onclick="hideMainBoundary();unselectBoundary();">Close</a>
		</div>
	</div>
</div>

<!-- LOCATION EDIT PANEL LOCATION EDIT PANEL LOCATION EDIT PANEL LOCATION EDIT PANEL LOCATION EDIT PANEL  -->



<!-- 		<img src="images/icons/polygon.png" id="editBoundaryIcon" width="48" -->
<!-- 			height="48" style="cursor: pointer;" />Edit Boundary -->

<!-- 		<img src="images/icons/image.png" id="editIconIcon" width="48" -->
<!-- 			height="48" style="cursor: pointer;" />Edit Thumbnail -->

<!-- 	<div class="ui-block-solo editlocationFormRow" -->
<!-- 		onclick="" id="calendarIcon"> -->
<!-- 		<img src="images/icons/calendar.png" id="editIconIcon" width="48" -->
<!-- 			height="48" style="cursor: pointer;" />Schedule Access  -->
<!-- 	</div> -->













<!-- EDIT PATH MENU EDIT PATH MENU EDIT PATH MENU EDIT PATH MENU EDIT PATH MENU EDIT PATH MENU EDIT PATH MENU -->




<div data-role="popup" id="pathEditMenu" data-mini="true">
	<ul data-role="listview" style="min-width: 210px;">
		<li data-role="list-divider" id="pathEditMenuTitle">Choose an
			action</li>
		<li data-icon="false"><a href="#" onclick="openPathTypePopup();">Edit
				Path Type</a></li>
		<li data-icon="false"><a href="#" onclick="openPathInfoPopup();">Edit
				Info</a></li>
		<li data-icon="false"><a href="#"><label for="pathWidth">Path
					Width (Meters)</label> <input type="range" placeholder="Label"
				name="pathWidth" id="pathWidth" value="5" min="0" max="50">
		</a></li>
		<!-- 		<li data-icon="false"><a href="#" onclick="openIconPopup();">Edit -->
		<!-- 				Thumbnail</a></li> -->
		<li data-role="list-divider"></li>
		<li data-icon="false"><a href="#" onclick="removePath();">Delete</a></li>
	</ul>
</div>



<!-- PATH INFO POPUP PATH INFO POPUP PATH INFO POPUP PATH INFO POPUP PATH INFO POPUP -->



<div data-role="popup" id="editPathInfoPopup" class="menuItemPopupClass">
	<a href="#" data-role="button" data-theme="a" data-icon="delete"
		data-iconpos="notext" class="ui-btn-right closeMessageButtonIcon"
		onclick="$('#editPathInfoPopup').popup('close'); ">Close</a>
	<div class="ui-block-solo editlocationFormRow">
		<label for="pathName" id="markerLabel">Label</label> <input
			class="pathMenu" type="text" placeholder="Label" name="pathName"
			id="pathName" value="">
	</div>
	<div class="ui-block-solo editlocationFormRow">
		<label for="pathDescription">Description</label>
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
				onclick="closeAMenuPopup();">Close</a>
		</div>
	</div>
</div>



<div id="editPathPopup" class="ui-grid-b toolBar">
	<div class="ui-block-a">
		<input type="text" placeholder="From (Departure)" name="departure"
			id="departure" value="" readonly >
	</div>
	<div class="ui-block-b">
		<input type="text" placeholder="To (Destination)" name="destination"
			id="destination" value="" readonly >
	</div>
	<div class="ui-block-c">
		<label for="pathLength">Length </label> <span id="pathLength"></span>
	</div>
</div>
<!-- 	<div class="ui-grid-a editlocationFormRow"> -->
<!-- 		<div class="ui-block-a"> -->
<!-- 			<a style="cursor: pointer;" data-role="button" href="#" -->
<!-- 				class="pathMenu ui-btn ui-shadow save-icon " onclick="saveThePath()">Save</a> -->
<!-- 		</div> -->
<!-- 		<div class="ui-block-b"> -->
<!-- 			<a style="cursor: pointer;" data-role="button" href="#" -->
<!-- 				class="pathMenu ui-btn ui-shadow cancel-icon " -->
<!-- 				onclick="removePath()">Remove</a> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- 	<a href="#" onclick="pathEditPanelClose()" -->
<!-- 		class="pathMenu ui-btn ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-left editlocationFormRow" -->
<!-- 		id="closeLocationEditMenu">Close Settings</a> -->



<!-- MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP MAP  -->



<div id="map_canvas"></div>



<!-- LOADING LOADING LOADING LOADING LOADING LOADING LOADING LOADING LOADING LOADING LOADING LOADING LOADING  -->



<div id="loadingOverlay">
	<div class="markerLoading" style="display: none;"></div>
	<span id="loadingContent" style="display: none;"></span>
</div>



<!-- MARKER LABEL MARKER LABEL MARKER LABEL MARKER LABEL MARKER LABEL MARKER LABEL MARKER LABEL -->



<div id="googleMapMarkerLabel"></div>



<!-- PATH TYPE POPUP PATH TYPE POPUP PATH TYPE POPUP vPATH TYPE POPUP PATH TYPE POPUP PATH TYPE POPUP PATH TYPE POPUP PATH TYPE POPUP -->



<div id="editPathTypePopup" data-role="popup" class="menuItemPopupClass">
	<a href="#" data-role="button" data-theme="a" data-icon="delete"
		data-iconpos="notext" class="ui-btn-right closeMessageButtonIcon"
		onclick="$('#editPathTypePopup').popup('close'); ">Close</a>
	<logic:iterate id="pathTIteration" name="pathTypes"
		type="common.location.PathTypeENT">
		<img src='images/icons/cursor-pointer.png' class="pathTypeIcon"
			alt="<%=pathTIteration.getPathTypeId()%>" width="48" height="48"
			title="<%=pathTIteration.getPathType()%>"
			onclick="selectIcon('<%=pathTIteration.getPathTypeId()%>');">
	</logic:iterate>
	<div class="ui-grid-a editlocationFormRow">
		<div class="ui-block-a">
			<a style="cursor: pointer;" data-role="button" href="#"
				class="pathMenu ui-btn ui-shadow save-icon " onclick="saveThePath()">Save</a>
		</div>
		<div class="ui-block-b">
			<a style="cursor: pointer;" data-role="button" href="#"
				class="pathMenu ui-btn ui-shadow cancel-icon "
				onclick="closeAMenuPopup();">Close</a>
		</div>
	</div>
</div>


<script src="js/croppie.js"></script>
<script src="js/colorpicker.js"></script>
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
	src="js/location/management/map.management.js"></script>
<script type="text/javascript"
	src="js/location/management/image.thumbnail.croppie.js"></script>
<script type="text/javascript"
	src="js/location/management/marker.polygon.js"></script>
<script type="text/javascript"
	src="js/location/management/management.general.js"></script>
<script type="text/javascript"
	src="js/location/management/marker.management.js"></script>
<script type="text/javascript"
	src="js/location/management/panel.edit.management.js"></script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyABLdskfv64ZZa0mpjVcTMsEAXNblL9dyE&libraries=drawing&callback=initMap"
	type="text/javascript"></script>
</html>