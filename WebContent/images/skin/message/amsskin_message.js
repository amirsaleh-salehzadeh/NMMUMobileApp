var browser = navigator.appName;
var ExtraSpace = 10;
var WindowLeftEdge = 0;
var WindowTopEdge = 0;
var WindowWidth = 0;
var WindowHeight = 0;
var WindowRightEdge = 0;
var WindowBottomEdge = 0;

$(document).ready(function() {
	$('a.btn-ok, #dialog-overlay, #dialog-box').click(function() {
		$('#dialog-overlay, #dialog-box').hide();
		$("dialog-content").html("");
		return false;
	});
	$(window).resize(function() {
		if (!$('#dialog-box').is(':hidden'))
			popup();
	});
	if ($("#successDescription").html() != "" || $("#errorDescription").html() !="")
		popup();
});
$(document).ajaxComplete(function() {
	$('a.btn-ok, #dialog-overlay, #dialog-box').click(function() {
		$('#dialog-overlay, #dialog-box').hide();
		$("dialog-content").html("");
		return false;
	});
	$(window).resize(function() {
		if (!$('#dialog-box').is(':hidden'))
			popup();
	});
	if ($("#successDescription").html() != "" || $("#errorDescription").html() !="")
		popup();
});

function popup() {
	var maskHeight = $(window).height();
	var maskWidth = $(window).width();
	var dialogTop = (maskHeight / 3) - ($('#dialog-box').height());
	var dialogLeft = (maskWidth / 2) - ($('#dialog-box').width() / 2);
	$('#dialog-overlay').css({
		height : maskHeight,
		width : maskWidth
	}).show();
	$('#dialog-box').css({
		top : dialogTop,
		left : dialogLeft
	}).show();
}
