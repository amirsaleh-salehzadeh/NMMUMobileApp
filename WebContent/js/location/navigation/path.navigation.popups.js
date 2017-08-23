var is_keyboard = false;
var is_landscape = false;
var initial_screen_size = window.innerHeight;

/* Android */
window.addEventListener("resize", function() {
	is_keyboard = (window.innerHeight < initial_screen_size);
	is_landscape = (screen.height < screen.width);
	updateViews();
}, false);

function errorMessagePopupOpen(content) {
	$("#errorMessageContent").html(content).trigger("create");
	$('#popupErrorMessage').popup();
	$('#popupErrorMessage').popup({
		history : false,
		transition : "turn"
	});
	$('#popupErrorMessage').popup('open').trigger('create');
	blurTrue();
}

function arrivalMessagePopupOpen() {
	$('#popupArrivalMessage').popup().trigger('create');
	$('#popupArrivalMessage').popup({
		history : false,
		transition : "turn"
	});
	$('#popupArrivalMessage').popup('open').trigger('create');
	blurTrue();
}

function searchResultPopupOpen(headerText) {
	 searchFieldDivClearBTN();
	if (headerText.indexOf("tart") != -1) {
		$("#departureButtonGroup").css("display", "block").trigger("create");
		$("#destinationButtonGroup").css("display", "none")
				.trigger("create");
		$("#destinationDefVal").html(
				headerText + "<br/><span id='destinationNameHeader'>To "
						+ $("#destinationName").html() + "</span>"
						);
		$("#searchField").attr("placeholder", "Departure");
		$("#searchPopupHeaderIcon").attr("src", "images/icons/departure.png");
		$("#destinationDefVal").css("cssText","color: #22b800 !important");
		$("#popupSearchResult").css("cssText","border-color: #22b800 !important").trigger("create");
	} else {
		$("#destinationButtonGroup").css("display", "block").trigger(
				"create");
		$("#departureButtonGroup").css("display", "none").trigger("create");
		$("#destinationDefVal").html(headerText);
		$("#searchField").attr("placeholder", "Destination");
		$("#searchPopupHeaderIcon").attr("src", "images/icons/destination.png");
		$("#destinationDefVal").css("color","color: #0091FF !important");
		$("#popupSearchResult").css("cssText","border-color: #0091FF !important").trigger("create");
		
	}
//	$('#popupSearchResult').css({
//		'height' : $(window).height() * 0.95
//	});
//
//	$('#popupSearchResult').css({
//		'width' : $(window).width() * 0.98
//	});
	$('#popupSearchResult').popup().trigger('create');
	$('#popupSearchResult').popup({
		history : false,
		transition : "turn"
	});
	$('#popupSearchResult').popup('open').trigger('create');
	if ($("#locationInfoDiv").css('display') != 'none')
		hideBottomPanel();
	$('#map_canvas').addClass('off');
	$('#searchField').trigger("create");
	$('#searchField').trigger("focus");
}

//$("#searchField").bind("focus", function() {
//	is_keyboard = true;
//	updateViews();
//});
//
//$("#searchField").bind("blur", function() {
//	is_keyboard = false;
//	updateViews();
//});

function updateViews() {
	if (is_keyboard) {
		$("#popupSearchResult").height(window.innerHeight - 30);
	} else {
		$("#popupSearchResult").height(window.innerHeight - 30);
	}

}