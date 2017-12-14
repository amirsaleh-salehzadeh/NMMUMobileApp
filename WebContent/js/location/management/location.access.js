function getAllLocationsTree(parentId) {
		var url = "REST/GetLocationWS/GetAllLocationsForUser?parentLocationId="
				+ parentId + "&locationTypeId=&userName=NMMU";

		$
				.ajax({
					url : url,
					cache : false,
					async : true,
					beforeSend : function() {
						ShowLoadingScreen("Loading Locations");
					},
					success : function(data) {
						str = "";
						$
								.each(
										data,
										function(k, l) {
											if ((l.locationType.locationTypeId == 2)
													|| (l.locationType.locationTypeId == 3)
													|| (l.locationType.locationTypeId == 7)) {
												str = "<li><div class='tf-div'>"
														+ '<input type="checkbox" name="'+l.locationName +'" id="'+ l.locationID +'" data-mini="true">'
														+ l.locationName
														+ "</div><ul id='loc"+l.locationID+"'></ul></li>";
												$("#loc" + parentId)
														.append(str);

											}
											//		alert(l.locationName + "  " + l.parent.locationName);

											getAllLocationsTree(l.locationID);

										});
						initiateTree();
					},
					complete : function() {
						HideLoadingScreen();
					},
					error : function(xhr, ajaxOptions, thrownError) {
						alert(xhr.status);
						alert(thrownError);
						alert("getAllLocationsTree");
					}

				});
	}

	function initiateTree() {
		var tree = new treefilter($("#loc360"), {
			// OPTIONS
			searcher : $("input#my-search")
		});
		// 	alert("done");
	}
	function ShowLoadingScreen(loadingContent) {
		if (loadingContent == null) {
			loadingContent = "Please Wait";
		}
		alert("Now");
		$("#loadingOverlay").css("display", "block");
		$("#loadingContent").css("display", "block");
		$(".markerLoading").css('display', 'block').trigger("create");
		$("#loadingContent").html("Loading. . ." + "</br>" + loadingContent);
	}
	function HideLoadingScreen() {

		$("#loadingOverlay").css("display", "none");
		$(".markerLoading").css('display', 'none');
		$("#loadingContent").css("display", "none");
	}
