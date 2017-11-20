var is_keyboard = false;
var is_landscape = false;
var initial_screen_size = window.innerHeight;
var popupopen;

/* Android */
window.addEventListener("resize", function() {
	is_keyboard = (window.innerHeight < initial_screen_size);
	is_landscape = (screen.height < screen.width);
	updateViews();
}, false);

document.onkeydown = KeyPress;
function KeyPress(e) {
	var eventKeys = window.event ? event : e;
	if (popupopen == false) {
		if (eventKeys.keyCode == 27) {
			return false;
		}
	} else {
		if (eventKeys.keyCode == 27) {
			closePopup();
		}
	}
}

function closePopup() {
	popupopen = false;
	hideBottomPanel();
	$('#popupErrorMessage').css("display", "none");
	$('#popupArrivalMessage').popup('close');
	$('#popupSearchResult').popup('close');
	// blurFalse();
}

function errorMessagePopupOpen(content) {
	$("#errorMessageContent").html(content);
	popupopen = true;
	hideBottomPanel();
	$('#popupErrorMessage').css("height", $(window).height());
	$('#popupErrorMessage').css("display", "block");
}

function arrivalMessagePopupOpen() {
	$('#popupArrivalMessage').popup().trigger('create');
	$('#popupArrivalMessage').popup({
		history : false,
		transition : "turn"
	});
	$('#popupArrivalMessage').popup('open').trigger('create');
	popupopen = true;
}

function searchResultPopupOpen(headerText) {
	if (headerText.indexOf("ROM") != -1) {
		if (isLocationAvailable) {
			$("#departureButtonGroup").css("display", "block")
					.trigger("create");
			$("#destinationButtonGroup").css("display", "none").trigger(
					"create");
		}
		$("#destinationDefVal")
				.html(
						headerText
								+ "<br/><span id='destinationNameHeader' style='display: none;'>To "
								+ $("#destinationName").html() + "</span>");
		$("#searchField").attr("placeholder", "Departure");
		$("#searchPopupHeaderIcon").attr("src", "images/icons/departure.png");
		$("#destinationDefVal").css("cssText",
				"background-color: #22b800 !important").trigger("create");
		$("#popupSearchResult").css("cssText",
				"border-color: #22b800 !important").trigger("create");
	} else {
		$("#destinationButtonGroup").css("display", "block").trigger("create");
		$("#departureButtonGroup").css("display", "none").trigger("create");
		$("#destinationDefVal").html(headerText);
		$("#searchField").attr("placeholder", "Destination");
		$("#searchPopupHeaderIcon").attr("src", "images/icons/destination.png");
		$("#destinationDefVal").css("cssText",
				"background-color: #0091FF !important").trigger("create");
		$("#popupSearchResult").css("cssText",
				"border-color: #0091FF !important").trigger("create");
	}
	if (markerDepart != null)
		markerDepart.setMap(null);
	$('#popupSearchResult').popup().trigger('create');
	$('#popupSearchResult').popup({
		history : false,
		transition : "turn"
	});
	$('#popupSearchResult').popup('open').trigger('create');
	searchFieldDivClearBTN();
	// if ($("#locationInfoDiv").css('display') != 'none')
	hideBottomPanel();
	// $('#map_canvas').addClass('off');
	$('#searchField').trigger("create");
	$('#searchField').trigger("focus");
	popupopen = true;
}

// $("#searchField").bind("focus", function() {
// is_keyboard = true;
// updateViews();
// });
//
// $("#searchField").bind("blur", function() {
// is_keyboard = false;
// updateViews();
// });

function updateViews() {
	if (is_keyboard) {
		$("#popupSearchResult").height(window.innerHeight - 30);
	} else {
		$("#popupSearchResult").height(window.innerHeight - 30);
	}

}