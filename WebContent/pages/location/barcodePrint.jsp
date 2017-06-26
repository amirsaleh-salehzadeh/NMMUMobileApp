<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="../../js/jquery.min.js"></script>
<script>
	$(document)
			.ready(
					function() {
						$
								.ajax({
									url : "../../REST/GetLocationWS/GetBarcodeForLocation?locationId="
											+
<%=request.getParameter("locationId")%>
	,
									cache : false,
									success : function(data) {
										// 										alert($("#headerContainer").css("height"));
										$
												.each(
														data,
														function(k, l) {
															if (k == 'g')
																$(
																		"#barcodeContainer")
																		.html(
																				'<img style="overflow: hidden;" src="'+l + '">');
															$("#Description")
																	.html("");
															$("#Description")
																	.append(
																			'<span class="heading">'
																					+ data['t']
																					+ ': </span><span class="locationText">'
																					+ data['n']
																					+ '</span><br>');
														});
										return presentLocation(data['p']);
										// 										$("#barcodeContainer").css("top", $("#headerContainer").css("height"));
									}
								});
					});
	function presentLocation(x) {
// 		$.each(x, function(k, l) {
			$("#Description").append(
					'<span class="heading">' + x['t']
							+ ': </span><span class="locationText">' + x['n']
							+ '</span><br>');
// 		});
		if (x.p != null)
			presentLocation(x['p']);
	}
</script>
<style type="text/css">
#printPage {
	height: 100%;
	width: 100%;
	display: block;
	position: absolute;
}

#Description {
	padding-top: 13px;
}

.heading {
	font-weight: bold;
}

#barcodeContainer {
	
}
</style>
</head>
<body>
	<div id="printPage">
		<div id="headerContainer">
			<div style="display: inline-block;" id="ARMarker">
				<img src="../../images/mini_logo.png" alt="marker"
					style="width: 111px; height: 111px;" />
			</div>
			<div style="display: inline-block; vertical-align: top;"
				id="Description">
				<span class="heading">Room: </span><span class="locationText">209</span><br>
				<span class="heading">Level: </span><span class="locationText">2</span><br>
				<span class="heading">Building: </span><span class="locationText">Embizweni</span><br>
				<span class="heading">Campus: </span><span class="locationText">South
					Campus</span> <br> <span class="heading">Location: </span><span
					class="locationText">Nelson Mandela University</span>
			</div>
		</div>
		<div
			style="display: inline; overflow: hidden; left: -100px; top: 33px; z-index: -1; position: absolute;"
			id="barcodeContainer"></div>
	</div>
</body>
</html>