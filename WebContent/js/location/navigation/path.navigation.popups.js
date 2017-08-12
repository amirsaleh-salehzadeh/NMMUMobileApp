function errorMessagePopupOpen(content) {
	$("#errorMessageContent").html(content).trigger("create");
	$('#popupErrorMessage').popup();
	$('#popupErrorMessage').popup({
		history : false,
		transition : "turn"
	});
	$('#popupErrorMessage').popup('open').trigger('create');
	$('#map_canvas').toggleClass('off');
}

function arrivalMessagePopupOpen() {
	$('#popupArrivalMessage').popup().trigger('create');
	$('#popupArrivalMessage').popup({
		history : false,
		transition : "turn"
	});
	$('#popupArrivalMessage').popup('open').trigger('create');
	$('#map_canvas').toggleClass('off');
}

function searchResultPopupOpen(headerText) {
	if (headerText.indexOf("rom") != -1) {
		$("#departureButtonGroup").css("display", "block").trigger("create");
		$("#popupSearchResultCloseBTN").css("display", "none")
				.trigger("create");
		$("#searchPopupHeader").html(
				"<span id='destinationNameHeader'>To "
						+ $("#destinationName").html() + "</span><br/>"
						+ headerText);
	} else {
		$("#popupSearchResultCloseBTN").css("display", "block").trigger(
				"create");
		$("#departureButtonGroup").css("display", "none").trigger("create");
		$("#searchPopupHeader").html(headerText);
	}
	$('#popupSearchResult').css({
		'height' : $(window).height() * 0.95
	});

	$('#popupSearchResult').css({
		'width' : $(window).width() * 0.98
	});
	$('#popupSearchResult').popup().trigger('create');
	$('#popupSearchResult').popup({
		history : false,
		transition : "turn"
	});
	$('#popupSearchResult').popup('open').trigger('create');
	if ($("#locationInfoDiv").css('display') != 'none')
		hideBottomPanel();
	$('#map_canvas').toggleClass('off');
	$('#searchField').trigger("create");
	$('#searchField').trigger("focus");
}