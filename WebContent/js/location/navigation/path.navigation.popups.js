function errorMessagePopupOpen(content) {
	$("#errorMessageContent").html(content).trigger("create");
	$('#popupErrorMessage').popup();
	$('#popupErrorMessage').popup({
		history : false,
		transition : "turn"
	});
	$('#popupErrorMessage').popup('open').trigger('create');
	// $('#popupErrorMessage').trigger('updatelayout');
	$('#map_canvas').toggleClass('off');
}

function arrivalMessagePopupOpen() {
	$('#popupArrivalMessage').popup().trigger('create');
	$('#popupArrivalMessage').popup({
		history : false,
		transition : "turn"
	});
	$('#popupArrivalMessage').popup('open').trigger('create');
	// $('#popupErrorMessage').trigger('updatelayout');
	$('#map_canvas').toggleClass('off');
}

function searchResultPopupOpen() {
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
	// $('#popupErrorMessage').trigger('updatelayout');
	if ($("#locationInfoDiv").css('display') != 'none') {
		$("#locationInfoDiv").animate({
			bottom : "-=13%"
		}, 1500);
		setTimeout(function() {
			$("#locationInfoDiv").css('display', 'none').trigger("create");
		}, 1500);
		$("#zoomSettings").animate({
			bottom : 11
		}, 1500);
	}
	$('#map_canvas').toggleClass('off');
	$('#searchField').trigger("create");
	$('#searchField').trigger("focus");

}