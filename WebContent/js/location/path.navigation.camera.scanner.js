var cameraView = undefined;
var scanner = undefined;
function startScanner() {
	cameraView = new Vue(
			{
				el : '#cameraView',
				data : {
					scanner : null,
					activeCameraId : null,
					cameras : [],
					scans : []
				},
				mounted : function() {
					var self = this;
					self.scanner = new Instascan.Scanner({
						video : document.getElementById('videoContent'),
						scanPeriod : 1,
						continuous : true,
						captureImage : false,
						backgroundScan : false,
						refractoryPeriod : 5000
					});
					scanner = self.scanner;
					self.scanner.addListener('scan', function(content, image) {
						getTheBarcodeAR(content);
						self.scans.unshift({
							date : +(Date.now()),
							content : content
						});
					});
					Instascan.Camera
							.getCameras()
							.then(
									function(cameras) {
										self.cameras = cameras;
										if (cameras.length > 1) {
											for ( var i = 0; i < cameras.length; i++) {
												if (cameras[i].name
														.indexOf("back") >= 0
														|| cameras[i].name
																.indexOf("rear") >= 0) {
													self.activeCameraId = cameras[i].id;
													self.scanner
															.start(cameras[i]);
												}
												;
											}
											;
										} else if (cameras.length > 0) {
											self.activeCameraId = cameras[0].id;
											self.scanner.start(cameras[0]);
										} else {
											console.error('No cameras found.');
										}
									}).catch(function (e) {
										 console.error(e);
									 });
				},
				methods : {
					formatName : function(name) {
						return name || '(unknown)';
					},
					selectCamera : function(camera) {
						this.activeCameraId = camera.id;
						this.scanner.start(camera);
					}
				}
			});
}
document.addEventListener("DOMContentLoaded", function(event) {
	if (window.DeviceOrientationEvent) {
		window.addEventListener('deviceorientation', function(eventData) {
			var tiltLR = eventData.gamma;
			var tiltFB = eventData.beta;
			var dir = eventData.alpha;
			deviceOrientationHandler(tiltLR, tiltFB, dir);
		}, false);
	}
	;

	function deviceOrientationHandler(tiltLR, tiltFB, dir) {
		document.getElementById("tiltLR").innerHTML = Math.ceil(tiltLR);
		document.getElementById("tiltFB").innerHTML = Math.ceil(tiltFB);
		document.getElementById("direction").innerHTML = Math.ceil(dir);

		var compassDisc = document.getElementById("compassDiscImg");
		compassDisc.style.webkitTransform = "rotate(" + dir + "deg)";
		compassDisc.style.MozTransform = "rotate(" + dir + "deg)";
		compassDisc.style.transform = "rotate(" + dir + "deg)";
	}

});

function getBCodeInfo(x) {
	$
			.ajax({
				url : "REST/GetLocationWS/GetBarcodeForLocation?locationId="
						+ x,
				cache : true,
				success : function(data) {
					$("#barcodeDescription").css("display", "block");
					$("#barcodeDescription").fadeIn(3000);
					$.each(data,function(k, l) {
								$("#barcodeDescription").html("");
								$("#barcodeDescription").append(
												'<span class="heading">'
														+ data['t']
														+ ': </span><span class="locationText">'
														+ data['n']
														+ '</span><br>');
								var barcodePosition = new google.maps.LatLng(
										parseFloat(data['g']
										.split(',')[0]),
								parseFloat(data['g']
										.split(',')[1]));
								if (data['id'] == x) {
									map.setCenter();
									var nextDestGPS = getCookie(
											"TripPathGPSCookie").split(
											"_");
									var tmpStr = "";
									for ( var int = 0; int < nextDestGPS.length; int++) {
										if (x == nextDestGPS[i]) {
											if (int == 0)
												tmpStr = nextDestGPS[int];
											else
												tmpStr += "_"
														+ nextDestGPS[int];
										}
									}
									var headingTo2st = google.maps.geometry.spherical
											.computeHeading(
													nextPosition,
													secondNextPosition);
									angleToNextDestination = headingTo2st
											- headingTo1st;
									heading = angleToNextDestination;
									tmpPathCoor.push(pointPath);
									tmpPathCoor.push(nextPosition);
									distanceToNextPosition = google.maps.geometry.spherical
											.computeDistanceBetween(
													pointPath,
													nextPosition);
									if (distanceToNextPosition <= 5) {
										removeTheNextDestination();
									}
								}
							});

					return presentLocation(data['p']);
				}
			});

}
function presentLocation(x) {
	$("#barcodeDescription").append(
			'<span class="heading">' + x['t']
					+ ': </span><span class="locationText">' + x['n']
					+ '</span><br>');
	if (x.p != null)
		presentLocation(x['p']);
}

function hideInfoDiv() {
	$("#barcodeDescription").fadeOut(3000);
}
function getTheBarcodeAR(content) {
	getBCodeInfo(content);
	$("#barcodeDescription").css("display", "block").trigger('create');
	$("#barcodeDescription").fadeIn(3000);
	window.setInterval(hideInfoDiv, 5000);
}
