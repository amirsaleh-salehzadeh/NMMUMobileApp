function setPathTypeButtonIcon() {
	$(".pathTypeIcon").each(function() {
		var pathTypeId = $(this).attr("alt");
		if (pathTypeId == "1")
			$(this).attr("src", "images/icons/pathType/grass.png");
		else if (pathTypeId == "2") {
			$(this).attr("src", "images/icons/pathType/normalSpeed.png");
		} else if (pathTypeId == "3") {
			$(this).attr("src", "images/icons/pathType/stairs.png");
		} else if (pathTypeId == "4")
			$(this).attr("src", "images/icons/pathType/elevator.png");
		else if (pathTypeId == "5")
			$(this).attr("src", "images/icons/pathType/car.png");
		else if (pathTypeId == "6")
			$(this).attr("src", "images/icons/pathType/wheelchair.png");
		else if (pathTypeId == "7")
			$(this).attr("src", "images/icons/pathType/escalator.png");
		else if (pathTypeId == "8")
			$(this).attr("src", "images/icons/pathType/bicycle.png");
		else
			$(this).attr("src", "images/icons/pathType/cursor-pointer.png");
	});
}

function selectIcon(id) {
	$(".pathTypeIcon").each(function() {
		var pathTypeId = $(this).attr("alt");
		if (pathTypeId == id) {
			if (!$(this).hasClass("pathTypeIconSelected")) {
				$(this).addClass("pathTypeIconSelected");
				pathTypeIds.push(id);
			}
			$(this).trigger("create");
		}
	});
	$("#pathTypePopup").trigger("create");
	$("#pathTypeIds").val(pathTypeIds.join(","));
}

function showPathTypeMenu() {
	$(".pathTypeIcon").each(function() {
		if ($(this).hasClass("pathTypeIconSelected")) {
			$(this).removeClass("pathTypeIconSelected");
		}
		$(this).trigger("create");
	});
	pathTypeIds = [];
	$("#pathTypePopup").trigger("create");
	$("#pathTypeIds").val(pathTypeIds.join(","));
	$('#pathTypePopup').css("position", "absolute");
	$('#pathTypePopup').css("left", event.pageX +'px');
	$('#pathTypePopup').css("top", event.pageY + 'px');
	$('#pathTypePopup').trigger("create");
	var left = event.pageX - Math.round($("#pathTypePopup").width() / 2);
	if ((event.pageX + $("#pathTypePopup").width()) >= $(window).width())
		left = $(window).width() - $("#pathTypePopup").width();
	if (left <= 0)
		left = 0;
	$('#pathTypePopup').css("left", left +'px');
	$('#pathTypePopup').trigger("create");
	$('#pathTypePopup').fadeIn();
}
