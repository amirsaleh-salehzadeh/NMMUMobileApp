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
			} else {
				$(this).removeClass("pathTypeIconSelected");
				var i = pathTypeIds.indexOf(id);
				if (i != -1) {
					pathTypeIds.splice(i, 1);
				}
			}
			$(this).trigger("create");
		}
	});
	$("#pathTypePopup").trigger("create");
	$("#pathTypeIds").val(pathTypeIds.join(","));
}

function showPathTypeMenu() {
	$('#pathTypePopup').css("position", "absolute");
	$('#pathTypePopup').css("left", event.pageX + 'px');
	$('#pathTypePopup').css("top", event.pageY + 'px');
	$('#pathTypePopup').trigger("create");
	$('#pathTypePopup').fadeIn();
}
