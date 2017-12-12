function toast(msg) {
	$(
			"<div class='ui-loader ui-overlay-shadow ui-body-e ui-corner-all'><h3>"
					+ msg + "</h3></div>").css({
		display : "block",
		opacity : 0.90,
		position : "fixed",
		padding : "7px",
		"text-align" : "center",
		width : "270px",
		left : ($(window).width() - 284) / 2,
		top : $(window).height() / 2
	}).appendTo($.mobile.pageContainer).delay(1500).fadeOut(400, function() {
		$(this).remove();
	});
}

function printBarcode(id, name) {
	if (id == "") {
		alert("The location does not exist yet. Please save the location first");
		return;
	}
	window.open("pages/location/barcodePrint.jsp?locationId=" + id);
}

function mapSattelView() {
	if ($("#mapSatelViewImage").attr("src").indexOf("map") > 0) {
		$("#mapSatelViewImage").attr("src", "images/icons/satellite.png");
		map.setMapTypeId('mystyle');
	} else {
		map.setMapTypeId(google.maps.MapTypeId.SATELLITE);
		$("#mapSatelViewImage").attr("src", "images/icons/maps.png");
		$("#mapSatelViewImage").attr("alt", "Map View");
	}
}

function createNew(seq) {// a number to indicate the sequence of next
	// procedures
	showLocationInfo();
	if (seq == 0) {
		$("#markerCoordinate").val("");
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
	}
	$("#locationSaveNextButton").html("Next");
	if ($('[name="optionType"] :radio:checked').val() == "marker") {
		// showMainBoundary();
		// $('.menuItemPopupClass').popup('close');
		// locationEditPanelOpen("", "");
		if (seq == 0) {
			selectThisLocationType(null);
			setTimeout(function() {
				$('#editLocationTypePopup').popup(
						{
							positionTo : "window",
							transition : "pop",
							history : false
						}).trigger('create').popup('open');
			}, 100);
			$("#locationSaveNextButton").attr("onclick", "createNew(1)");
		} else if (seq == 1) {
			openLocationInfoPopup();
			$("#locationSaveNextButton").attr("onclick", "createNew(2)");
		}
		// startDrawingMode();
	} else {
		$("#map_canvas").css("cursor",
				"url(images/map-markers/mouse-cursors/pin.png) , auto");
		map
				.setOptions({
					draggableCursor : "url('images/map-markers/mouse-cursors/pin.png'), auto"
				});
	}
}

function selectActionType() {
	if ($('[name="optionType"] :radio:checked').val() == "marker") {
		var gps = map.getCenter().toString();
		gps = gps.replace("(", "");
		gps = gps.replace(")", "");
		gps = gps.replace(" ", "");
		addAMarker(null, gps);
		getAllMarkers($("#parentLocationId").val(), false);
		hidePathInfo();
	} else {
		getAllPaths(false);
		showPathInfo();
	}
}

function getPathTypePanel() {
	var url = "REST/GetLocationWS/GetAllPathTypes";
	$.ajax({
		url : url,
		cache : false,
		async : true,
		success : function(data) {
			var tmp = "";
			$.each(data, function(k, l) {
				tmp += "<li value='" + l.pathTypeId
						+ "' class='liPathLV'><a href='#'>" + l.pathType
						+ "</a></li>";
			});
			$("ul#pathTypeListView").html(tmp).trigger("create");
			$("ul#pathTypeListView").listview();
			$("ul#pathTypeListView").listview("refresh");
		},
		error : function(xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			alert(thrownError);
			alert("getPathTypePanel");
		}
	});
}

$(document).ready(function() {
	$('#pathTypePopup').fadeOut();
	$('#locationEditPanel').fadeOut();
	// $(".jqm-demos").css("max-height",$(window).height());

});

function ShowLoadingScreen(loadingContent) {
	if (loadingContent == null) {
		loadingContent = "Please Wait";
	}
	$("#loadingOverlay").css("display", "block");
	$("#loadingContent").css("display", "block");
	$(".markerLoading").css('display', 'block').trigger("create");
	$("#loadingContent").html("Loading. . ." + "</br>" + loadingContent);
}
function HideLoadingScreen() {

	$("#loadingOverlay").css("display", "none");
	$(".markerLoading").css('display', 'none');
	$("#loadingContent").css("display", "none");
}

function setCookie(cname, cvalue, exdays) {
	var d = new Date();
	d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
	var expires = "expires=" + d.toUTCString();
	document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
	var name = cname + "=";
	var decodedCookie = decodeURIComponent(document.cookie);
	var ca = decodedCookie.split(';');
	for ( var i = 0; i < ca.length; i++) {
		var c = ca[i];
		while (c.charAt(0) == ' ') {
			c = c.substring(1);
		}
		if (c.indexOf(name) == 0) {
			return c.substring(name.length, c.length);
		}
	}
	return "";
}

//$(document).keyup(function(e) {
//	if (e.keyCode == 27) {
//		clearBoundarySelection();
//	}
//});