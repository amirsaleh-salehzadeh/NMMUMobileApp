
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png" href="favicon.png">
<link rel="stylesheet" href="style.css">
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/webrtc-adapter/3.3.3/adapter.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.1.10/vue.min.js"></script>
<script type="text/javascript"
	src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>
<script src="../../js/jquery.min.js"></script>
<script type="text/javascript" src="../../js/location/camera/awe-v8.js"></script>
<script type="text/javascript"
	src="../../js/location/camera/awe-loader.js"></script>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

#container {
	position: absolute;
	left: 0;
	top: 0;
	bottom: 0;
	right: 0;
	overflow: hidden;
}

#debugCanvas {
	position: absolute;
	z-index: 999;
	opacity: 0.5;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

#barcodeDescription {
	display: none;
	margin: 0 auto;
	background: rgba(0, 69, 124, 0.66);
	padding: 22px;
	border: 3px solid #9b221f;
	border-radius: 20px/50px;
	background-clip: padding-box;
	color: white;
	text-align: left;
	position: absolute;
	z-index: 1000;
	text-align: left;
	margin: 0 auto;
}

.heading {
	font-size: 16pt;
	font-weight: bold;
}

.locationText {
	font-size: 12pt;
	font-weight: bold;
}

#destination {
	color: #00FF00;
	font-size: 18pt;
	text-shadow: 2px 2px #fff;
	font-style: italic;
}
</style>
</head>
<body>
	<div id="barcodeDescription">
		<span class="heading">Room: </span><span class="locationText"
			id="destination">209</span><br> <span class="heading">Level:
		</span><span class="locationText">2</span><br> <span class="heading">Building:
		</span><span class="locationText">Embizweni</span><br> <span
			class="heading">Campus: </span><span class="locationText">South
			Campus</span> <br> <span class="heading">Location: </span><span
			class="locationText">Nelson Mandela University</span>
	</div>
	<div id="app">
		<div class="compass">
			<div class="arrow"></div>
			<div class="disc" id="compassDiscImg"></div>
		</div>
		<div class="orientation-data" style="display: none;">
			<div>
				<span id="tiltFB"></span>
			</div>
			<div>
				<span id="tiltLR" ></span>
			</div>
			<div>
				<span id="direction"></span>
			</div>
		</div>
		<input type="hidden" id="destId"
			value="<%=request.getParameter("destinationId")%>"> <input
			type="hidden" id="pathTypeId"
			value="<%=request.getParameter("pathType")%>">
		<div class="sidebar" style="display: none;">
			<section class="cameras">
			<h2>Cameras</h2>
			<ul>
				<li v-if="cameras.length === 0" class="empty">No cameras found</li>
				<li v-for="camera in cameras"><span
					v-if="camera.id == activeCameraId" :title="formatName(camera.name)"
					class="active">{{ formatName(camera.name) }}</span> <span
					v-if="camera.id != activeCameraId" :title="formatName(camera.name)">
						<a @click.stop="selectCamera(camera)">{{
							formatName(camera.name) }}</a>
				</span></li>
			</ul>
			</section>
			<section class="scans">
			<h2>Scans</h2>
			<ul v-if="scans.length === 0">
				<li class="empty">No scans yet</li>
			</ul>
			<transition-group name="scans" tag="ul">
			<li v-for="scan in scans" :key="scan.date" :title="scan.content">{{
				scan.content }}</li>
			</transition-group> </section>
		</div>
		<div class="preview-container">
			<video id="preview" ></video>
		</div>
	</div>
	<script type="text/javascript" src="app.js"></script>
</body>
</html>
