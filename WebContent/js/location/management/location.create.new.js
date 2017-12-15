var tmpCreateNewlocation;
function createNew(seq) {// a number to indicate the sequence of next
	// procedures
	// closeAMenuPopup();
	showLocationInfo();
	var mapOptions = {
		draggableCursor : "url('images/map-markers/mouse-cursors/pin.png'), auto"
	};
	$("#locationCreateNewNextPanel").css("display", "none").trigger("create");
	switch (seq) {
	case 0:
		if (tmpCreateNewlocation != null) {
			tmpCreateNewlocation.setMap(null);
			tmpCreateNewlocation = null;
		}
		$(".SaveCancelBTNPanel").html($("#locationCreateNewNextPanel").html())
				.trigger("create");
		$("#locationCreateNewNextPanel").css("display", "none").trigger(
				"create");
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
			mapOptions = {
				draggableCursor : "url('images/map-markers/mouse-cursors/buildingss.png'), auto"
			};
			map.setOptions(mapOptions);
			popSuccessMessage("Please find the area of the property on the map, place a marker point on the map and press next.");
			var mapClickListener = function(event) {
				var lat = event.latLng.lat();
				var lng = event.latLng.lng();
				map.panTo({
					lat : parseFloat(lat),
					lng : parseFloat(lng)
				});
				tmpCreateNewlocation = new google.maps.Marker({
					map : map,
					position : {
						lat : parseFloat(lat),
						lng : parseFloat(lng)
					}
				});
				if (confirm("Are u sure u want to place a property here?")) {
					$("#locationGPS").val(lat + "," + lng);
//					$(".locationSaveNextButton").attr("onclick",
//							"createNew(1);");
//					popSuccessMessage("Press next or cancel");
//					$("#locationCreateNewNextPanel").css("display",
//							"inline-block");
//					$("#locationCreateNewNextPanel").css(
//							"top",
//							parseInt(parseInt($(".jqm-header").height())
//									+ parseInt($("#locPathModeRadiobtn")
//											.height()) + 3));
//					$("#locationCreateNewNextPanel")
//							.css(
//									"left",
//									parseInt(parseInt($(window).width())
//											/ 2
//											- +parseInt($(
//													"#locationCreateNewNextPanel")
//													.width()) / 2)).trigger(
//									"create");
					createNew(1);
				} else {
					tmpCreateNewlocation.setMap(null);
					tmpCreateNewlocation = null;
					return;
				}
			};
			google.maps.event.addListener(map, "click", mapClickListener);
			break;
		} else {
			$("#map_canvas").css("cursor",
					"url(images/map-markers/mouse-cursors/pin.png) , auto");
			map.setOptions(mapOptions);
		}
	case 1:
		mapOptions = {
			draggableCursor : "url('images/map-markers/mouse-cursors/buildingss.png'), auto"
		};
		map.setOptions(mapOptions);
		selectThisLocationType(null);
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			popSuccessMessage("Set a type for this property.");
			setTimeout(function() {
				$('#editLocationTypePopup').popup({
					positionTo : "window",
					transition : "pop",
					history : false
				}).trigger('create').popup('open');
			}, 100);
			$(".locationSaveNextButton").attr("onclick", "createNew(2)")
					.trigger("create");
			break;
		} else {
			$("#map_canvas").css("cursor",
					"url(images/map-markers/mouse-cursors/pin.png) , auto");
			map.setOptions(mapOptions);
		}
		break;
	case 2:
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			popSuccessMessage("Set a label and description for this property.");
			$("#editLocationTypePopup").on(
					"popupafterclose",
					function() {
						setTimeout(function() {
							$("#editLocationInfoPopup").trigger('create')
									.popup('open');
						}, 100);
					});
			$("#editLocationTypePopup").popup("close");
			$(".locationSaveNextButton").attr("onclick", "createNew(3)")
					.trigger("create");
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
			$("#editLocationInfoPopup").popup("close");
			popSuccessMessage("Please draw a boundary around the property. "
					+ "Make sure to place the pins at an accurate geographical position");
			// openEditBoundaryPopup();
//			$(".locationSaveNextButton").attr("onclick", "createNew(4)");
			$("#locationSaveCancelPanel").trigger("create");
			startDrawingMode();
		} else {
			$("#map_canvas").css("cursor",
					"url(images/map-markers/mouse-cursors/pin.png) , auto");
			map.setOptions(mapOptions);
		}
		break;
	}
}