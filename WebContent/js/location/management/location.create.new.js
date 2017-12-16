var tmpCreateNewlocation;
function createNew(seq) {// a number to indicate the sequence of next
	// procedures
	// closeAMenuPopup();
	showLocationInfo();
	$("#actionBar").css("display", "inline");
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
		$(".SaveCancelBTNPanel").css("display", "none");
		$("#actionBarNextButton").attr("disabled", true);
		$("#actionBarNextButton").addClass("disabledBTN");
		$("#actionBarBackButton").attr("disabled", true);
		$("#actionBarBackButton").addClass("disabledBTN");
		$("#actionBarSaveButton").attr("disabled", true);
		$("#actionBarSaveButton").addClass("disabledBTN");
		$(".locationFields").val("");
		$(document).keyup(function(e) {
			if (e.keyCode == 27) {
				removeDrawingMode();
				// hideMainBoundary();
			}
		});
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			mapOptions = {
				draggableCursor : "url('images/map-markers/mouse-cursors/buildingss.png'), auto"
			};
			map.setOptions(mapOptions);
			// var mouseX;
			// var mouseY;
			$("#map_canvas").mousemove(function(event) {
				showActionBarLabel("Pin Property", event.pageX, event.pageY);
			});

			$("#actionBarMessage")
					.html(
							"Please find the area of the property on the map, place a marker point on the map and press next.");
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
	case 1:// CTREATE TYPE
		$("#actionBarNextButtonDiv").css("display", "block");
		map.setOptions({
			draggableCursor : 'crosshair'
		});
		map.setOptions(mapOptions);
		selectThisLocationType(null);
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			$("#actionBarMessage").html("Set a type for this property.");
			setTimeout(function() {
				$('#editLocationTypePopup').popup({
					positionTo : "window",
					transition : "pop",
					history : false
				}).trigger('create').popup('open');
			}, 100);
			$("#actionBarNextButton").attr("onclick", "createNew(2)")
					.trigger("create");
			$("#actionBarBackButton").attr("onclick", "createNew(1)");
			$("#actionBarBackButton").removeClass("disabledBTN")
			.trigger("create");
			break;
		} else {
			$("#map_canvas").css("cursor",
					"url(images/map-markers/mouse-cursors/pin.png) , auto");
			map.setOptions(mapOptions);
		}
		break;
	case 2: // SET INFO
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			$("#actionBarMessage").html(
					"Set a label and description for this property.");
			$("#actionBarBackButtonDiv").css("display", "block");
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
			$("#actionBarMessage")
					.html(
							"Please draw a boundary around the property. "
									+ "Make sure to place the pins at an accurate geographical position");
			$("#actionBarSaveButtonDiv").css("display", "block");
			// openEditBoundaryPopup();
			// $(".locationSaveNextButton").attr("onclick", "createNew(4)");
			$("#locationSaveCancelPanel").css("display", "inline-block")
					.trigger("create");
			$("#locationSaveCancelPanel")
					.css(
							"top",
							parseInt(parseInt($(".jqm-header").height())
									+ parseInt($("#locPathModeRadiobtn")
											.height()) + 3)).trigger("create");
			$("#locationSaveCancelPanel")
					.css(
							"left",
							parseInt(parseInt($(window).width() / 2)
									- parseInt($("#locationSaveCancelPanel")
											.width() / 2))).trigger("create");
			startDrawingMode();
		} else {
			$("#map_canvas").css("cursor",
					"url(images/map-markers/mouse-cursors/pin.png) , auto");
			map.setOptions(mapOptions);
		}
		break;
	}
}

function showActionBarLabel(text, posX, posY) {
	$("#actionBarLabel").html(text);
	$('#actionBarLabel').css("display", "block");
	$('#actionBarLabel').css("position", "absolute");
	$('#actionBarLabel').css("left",
			posX - ($("#actionBarLabel").width() / 2) + 'px');
	$('#actionBarLabel').css("top", posY - 40 + 'px');
	$('#actionBarLabel').trigger("create");
}

function clearActionBarLabel() {
	$('#actionBarLabel').css("display", "none");
}