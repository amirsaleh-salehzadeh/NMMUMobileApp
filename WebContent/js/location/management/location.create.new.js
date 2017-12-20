var tmpCreateNewlocation;
var newPathInProgress;
function cancelCreatingNew() {
	newPathInProgress = false;
	$('.menuItemPopupClass').popup('close');
	$("#locationEditMenu").unbind("popupafterclose");
	$("#pathEditMenu").unbind("popupafterclose");
	hideLocationInfo();
	hidePathInfo();
	if (tmpCreateNewlocation != null) {
		tmpCreateNewlocation.setMap(null);
		tmpCreateNewlocation = null;
	}
	if (selectedShape != null
			&& ($("#locationEditMenu").val() != "0" || $("#locationEditMenu")
					.val().length <= "0")) {
		selectedShape.setMap(null);
		selectedShape = null;
	}
	map.setOptions({
		draggableCursor : 'default'
	});
	$("#actionBar").css("display", "none");
	clearActionBarLabel();
	$("#map_canvas").unbind('mousemove');
	$(".locationFields").val("");
	removeDrawingMode();
	cancelADrawnPath();
	clearActionBarLabel();
}

function createNew(seq) {
	$("#actionBar").css("display", "inline-block");
	var mapOptions = {
		draggableCursor : "default"
	};
	$(document).keyup(function(e) {
		if (e.keyCode == 27) {
			removeDrawingMode();
			map.setOptions({
				draggableCursor : "default"
			});
			$('img').unbind('mouseover');
			clearActionBarLabel();
		}
	});
	$("#map_canvas").unbind('mousemove');
	clearActionBarLabel();
	if ($("#locationName").val().length > 0)
		$("#locationLabel").val($("#locationName").val());
	if ($("#locationDescription").val().length > 0)
		$("#locationInfoDescriptionLabel").val($("#locationDescription").val());
	switch (seq) {
	case 0:
		if (tmpCreateNewlocation != null) {
			tmpCreateNewlocation.setMap(null);
			tmpCreateNewlocation = null;
		}
		showLocationInfo();
		$(".SaveCancelBTNPanel").css("display", "none");
		$("#actionBarNextButton").attr("disabled", true);
		$("#actionBarNextButton").addClass("disabledBTN");
		$("#actionBarBackButton").attr("disabled", true);
		$("#actionBarBackButton").addClass("disabledBTN");
		$("#actionBarSaveButton").attr("disabled", true);
		$("#actionBarSaveButton").addClass("disabledBTN");
		$(".locationFields").val("");
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			setALocationTypeNew();
		} else {
			$("#map_canvas").mousemove(
					function(event) {
						showActionBarLabel("Select the Departure", event.pageX,
								event.pageY);
					});
			newPathInProgress = true;
			// setAPathTypeNew();
		}
		break;
	case 1:
		$("#actionBarNextButtonDiv").css("display", "block");
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			mapOptions = {
				draggableCursor : "url('images/map-markers/mouse-cursors/buildingss.png'), auto"
			};
			setAPointOnMap();
		} else {
			return;
		}
		break;
	case 2: // SET INFO
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			setLocationInfoNew();
		} else {
			$("#map_canvas").css("cursor",
					"url(images/map-markers/mouse-cursors/pin.png) , auto");
		}
		break;
	case 3:
		if ($('[name="optionType"] :radio:checked').val() == "marker") {
			$("#editLocationInfoPopup").popup("close");
			$("#actionBarMessage")
					.html("Please draw a boundary around the property. "
									+ "Make sure to place the pins at an accurate geographical position");
			$("#actionBarSaveButtonDiv").css("display", "block");
			startDrawingMode();
		} else {
			$("#map_canvas").css("cursor",
					"url(images/map-markers/mouse-cursors/pin.png) , auto");
		}
		break;
	}
	map.setOptions(mapOptions);
}

function setLocationInfoNew() {
	$("#actionBarMessage").html(
			"Set a label and description for this property.");
	$("#actionBarBackButtonDiv").css("display", "block");
	// $("#editLocationTypePopup").on("popupafterclose", function() {
	setTimeout(function() {
		$("#editLocationInfoPopup").trigger('create').popup('open');
	}, 100);
	// });
	// $("#editLocationTypePopup").popup("close");
	$("#actionBarNextButton").attr("onclick", "createNew(3)").trigger("create");
	$("#actionBarBackButton").attr("onclick", "createNew(1)");
	// $(".locationSaveNextButton").attr("onclick", "createNew(3)").trigger(
	// "create");
}

function setALocationTypeNew() {
	selectThisLocationType(null);
	$("#actionBarMessage").html("Set a type for this property.");
	setTimeout(function() {
		$('#editLocationTypePopup').popup({
			positionTo : "window",
			transition : "pop",
			history : false
		}).trigger('create').popup('open');
	}, 100);
}

function setAPathTypeNew() {
	$("#actionBarMessage").html("Place set the path types");
	$("#actionBarNextButton").attr("onclick", "createNew(1)").trigger("create");
	$("#actionBarBackButton").attr("onclick", "createNew(0)");
	// $(".locationSaveNextButton").attr("onclick", "createNew(3)").trigger(
	// "create");
	$("#actionBarNextButton").removeClass("disabledBTN").trigger("create");
	$("#actionBarBackButton").removeClass("disabledBTN").trigger("create");
	$(".pathTypeIcon").each(function() {
		if ($(this).hasClass("pathTypeIconSelected")) {
			$(this).removeClass("pathTypeIconSelected");
		}
		$(this).trigger("create");
	});
	$("#editPathTypePopup").css("position", "absolute").trigger("create");
	$("#editPathTypePopup").css(
			"top",
			parseInt($(".jqm-header").height())
					+ parseInt($("#locPathModeRadiobtn").height() + 3) + 'px');
	setTimeout(function() {
		$("#editPathTypePopup").trigger('create').popup('open');
	}, 100);
}

function setPathInfoNew() {
	$("#actionBarMessage").html(
			"Place the start point on an intersection or entrance");
	$(".pathTypeIcon").each(function() {
		if ($(this).hasClass("pathTypeIconSelected")) {
			$(this).removeClass("pathTypeIconSelected");
		}
		$(this).trigger("create");
	});
	$("#editPathTypePopup").css("position", "absolute").trigger("create");
	$("#editPathTypePopup").css(
			"top",
			parseInt($(".jqm-header").height())
					+ parseInt($("#locPathModeRadiobtn").height() + 3) + 'px');
	setTimeout(function() {
		$("#editPathTypePopup").trigger('create').popup('open');
	}, 100);
}

function setAPointOnMap() {
	$("#map_canvas").mousemove(function(event) {
		showActionBarLabel("Pin Property", event.pageX, event.pageY);
	});
	$("#actionBarMessage")
			.html(
					"Place a marker on the map to point the property and then, press next.");
	var mapClickListener = function(event) {
		var lat = event.latLng.lat();
		var lng = event.latLng.lng();
		map.panTo({
			lat : parseFloat(lat),
			lng : parseFloat(lng)
		});
		if (tmpCreateNewlocation != null) {
			tmpCreateNewlocation.setMap(null);
			tmpCreateNewlocation = null;
		}
		tmpCreateNewlocation = new google.maps.Marker({
			map : map,
			position : {
				lat : parseFloat(lat),
				lng : parseFloat(lng)
			}
		});
		if (confirm("Are u sure u want to place a property here?")) {
			$("#locationGPS").val(lat + "," + lng);
			$("#actionBarNextButton").attr("onclick", "createNew(2)").trigger(
					"create");
			$("#actionBarBackButton").attr("onclick", "createNew(0)");
			$("#actionBarBackButton").removeClass("disabledBTN").trigger(
					"create");
			google.maps.event.clearInstanceListeners(map);
			toast("The property location is set");
			createNew(2);
		} else {
			tmpCreateNewlocation.setMap(null);
			tmpCreateNewlocation = null;
			return;
		}
	};
	google.maps.event.addListener(map, "click", mapClickListener);
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