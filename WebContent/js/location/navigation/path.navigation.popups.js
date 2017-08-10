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
	$("#searchPopupHeader").html(headerText);
	getLocationTypePanel();
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
	hideBottomPanel();
	$('#map_canvas').toggleClass('off');
	$('#searchField').trigger("create");
	$('#searchField').trigger("focus");
}