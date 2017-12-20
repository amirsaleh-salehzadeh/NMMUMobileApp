function setPathInfoNew() {
	$("#actionBarMessage").html(
			"Place the start point on an intersection or entrance");
	$(".pathTypeIcon").each(function() {
		if ($(this).hasClass("pathTypeIconSelected")) {
			$(this).removeClass("pathTypeIconSelected");
		}
		$(this).trigger("create");
	});
	$("#editPathTypePopup").css("position", "absolute").trigger("create");
	$("#editPathTypePopup").css(
			"top",
			parseInt($(".jqm-header").height())
					+ parseInt($("#locPathModeRadiobtn").height() + 3) + 'px');
	setTimeout(function() {
		$("#editPathTypePopup").trigger('create').popup('open');
	}, 100);
}

function setAPathTypeNew() {
	$("#actionBarMessage").html("Place set the path types");
	$("#actionBarNextButton").attr("onclick", "createNew(1)").trigger("create");
	$("#actionBarBackButton").attr("onclick", "createNew(0)");
	// $(".locationSaveNextButton").attr("onclick", "createNew(3)").trigger(
	// "create");
	$("#actionBarNextButton").removeClass("disabledBTN").trigger("create");
	$("#actionBarBackButton").removeClass("disabledBTN").trigger("create");
	$(".pathTypeIcon").each(function() {
		if ($(this).hasClass("pathTypeIconSelected")) {
			$(this).removeClass("pathTypeIconSelected");
		}
		$(this).trigger("create");
	});
	$("#editPathTypePopup").css("position", "absolute").trigger("create");
	$("#editPathTypePopup").css(
			"top",
			parseInt($(".jqm-header").height())
					+ parseInt($("#locPathModeRadiobtn").height() + 3) + 'px');
	setTimeout(function() {
		$("#editPathTypePopup").trigger('create').popup('open');
	}, 100);
}
