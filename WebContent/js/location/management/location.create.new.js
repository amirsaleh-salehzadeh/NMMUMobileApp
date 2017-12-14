var tmpCreateNewlocation
function createNew(seq) {// a number to indicate the sequence of next
	// procedures
	showLocationInfo();
	var mapOptions = {
		draggableCursor : "url('images/map-markers/mouse-cursors/pin.png'), auto"
	};
	$("#locationCreateNewNextPanel").css("display","inline-block");
	switch (seq) {
	case 0:
		$("#locationGPS").val("");
		$("#markerId").val("");
		$("#icon").val("");
		$("#boundary").val("");
		$("#pathId").val("");
		$("#pathLatLng").val("");
		$("#destinationId").val("");
		$("#destinationGPS").val("");
		$("#departureId").val("");
		$("#departureGPS").val("");
		$("#boundaryColors").val("");

		$("#locationLabel").val("");
		$("#locationInfoDescriptionLabel").val("");
		$("#locationThumbnail").val("");
		$("#locationTypeLabelFooter").val("");
		$("#locationBoundary").html("");
		$(document).keyup(function(e) {
			if (e.keyCode == 27) {
				removeDrawingMode();
				hideMainBoundary();
			}
		});
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			popSuccessMessage("Please find the area of the property on the map, place a marker point on the map and press next.");
			$("#map_canvas").css("cursor",
			"url(images/map-markers/mouse-cursors/buildingss.png) , auto");
			var mapClickListener = function(event) {
				var lat = event.latLng.lat();
				var lng = event.latLng.lng();
				if (confirm("Are u sure u want to place a property here?//create a temp marker")) {
					$("#locationGPS").val(lat + "," + lng);
					$("#locationSaveNextButton").attr("onclick",
							"createNew(1);");
					
				} else
					return;

			};
			google.maps.event.addListener(map, "click", mapClickListener);
			break;
		} else {
			$("#map_canvas").css("cursor",
					"url(images/map-markers/mouse-cursors/pin.png) , auto");
			map.setOptions(mapOptions);
		}
	case 1:
		selectThisLocationType(null);
		popSuccessMessage("Please find the area of the property on the map, place a marker point on the map and press next.");
		$("#map_canvas").css("cursor",
		"url(images/map-markers/mouse-cursors/buildingss.png) , auto");
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			popSuccessMessage("Set a type for this property.");
			setTimeout(function() {
				$('#editLocationTypePopup').popup({
					positionTo : "window",
					transition : "pop",
					history : false
				}).trigger('create').popup('open');
			}, 100);
			$("#locationSaveNextButton").attr("onclick", "createNew(2)");
			break;
		} else {
			$("#map_canvas").css("cursor",
					"url(images/map-markers/mouse-cursors/pin.png) , auto");
			map.setOptions(mapOptions);
		}
	case 2:
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			// showMainBoundary();
			// $('.menuItemPopupClass').popup('close');
			// locationEditPanelOpen("", "");
			popSuccessMessage("Set a label and description for this property.");
			openLocationInfoPopup();
			$("#locationSaveNextButton").attr("onclick", "createNew(3)");
			// startDrawingMode();
		} else {
			$("#map_canvas").css("cursor",
					"url(images/map-markers/mouse-cursors/pin.png) , auto");
			map.setOptions(mapOptions);
		}
		break;
	case 3:
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			// showMainBoundary();
			// $('.menuItemPopupClass').popup('close');
			// locationEditPanelOpen("", "");
			popSuccessMessage("Please draw a boundary around the property. "
					+ "Make sure to place the pins at an accurate geographical position");
			openEditBoundaryPopup();
			$("#locationSaveNextButton").attr("onclick", "createNew(4)");
			// startDrawingMode();
		} else {
			$("#map_canvas").css("cursor",
					"url(images/map-markers/mouse-cursors/pin.png) , auto");
			map.setOptions(mapOptions);
		}
		break;
	}

}