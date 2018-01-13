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

function closePopup() {
	popupopen = false;
	hideBottomPanel();
	$('#popupErrorMessage').css("display", "none");
	$('#popupArrivalMessage').popup('close');
	$('#popupSearchResult').popup('close');
	$('#popupSelectDeparture').popup('close');
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

function searchResultPopupOpen() {
	if (markerDepart != null)
		markerDepart.setMap(null);
	$('#popupSearchResult').popup().trigger('create');
	$('#popupSearchResult').popup({
		history : false,
		transition : "turn"
	});
	setTimeout(function() {
		$('#popupSearchResult').popup('open').trigger('create');
	}, 300);
	searchFieldDivClearBTN();
	hideBottomPanel();
	popupopen = true;
}

function searchResultPopupOpenForDeparture(){
	$("#popupSelectDeparture").on("popupafterclose", function() {
		setTimeout(function() {
			searchResultPopupOpen();
		}, 100);
	});
	$("#popupSelectDeparture").popup("close");
}

function selectDeparturePopupOpen() {
	if (markerDepart != null)
		markerDepart.setMap(null);
	$('#popupSelectDeparture').popup().trigger('create');
	$('#popupSelectDeparture').popup({
		history : false,
		transition : "turn"
	});
	$('#popupSelectDeparture').popup('open').trigger('create');
}

function updateViews() {
	if (is_keyboard) {
		$("#popupSearchResult").height(window.innerHeight - 30);
	} else {
		$("#popupSearchResult").height(window.innerHeight - 30);
	}

}