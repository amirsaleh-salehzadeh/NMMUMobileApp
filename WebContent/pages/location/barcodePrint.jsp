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
						$("#barcodeContainer")
								.html(
										'<object style="width: 333px; height: 333px; overflow: hidden;" data="https://api.qrserver.com/v1/create-qr-code/?size=333x333&data='
												+
<%=request.getParameter("locationId")%>
	+ '">');
					});
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

.heading{
font-weight: bold;
}
</style>
</head>
<body>
	<div id="printPage">
		<div id="headerContainer">
			<div style="display: inline-block;" id="ARMarker">
				<img src="../../images/64.png" alt="marker"
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
			style="display: inline; overflow: hidden; width: 100%; height: 100%;"
			id="barcodeContainer"></div>
	</div>
</body>
</html>