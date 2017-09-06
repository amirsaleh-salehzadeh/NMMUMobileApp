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
						scanPeriod : 5,
						continuous : true,
						captureImage : false,
						backgroundScan : false,
						refractoryPeriod : 1000
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
// startAR();
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

function getBCodeInfo(x) {
	$("#arrivalMessageContent").html("");
	$.ajax({
				url : "REST/GetLocationWS/GetBarcodeForLocation?locationId="
						+ x,
				cache : true,
				success : function(data) {
// $("#barcodeDescription").css("display", "block");
// $("#barcodeDescription").fadeIn(3000);
// $.each(data,function(k, l) {
// $("#barcodeDescription").html("");
								$("#arrivalMessageContent").append(
												'<span class="heading">'
														+ data['t']
														+ ': </span><span class="locationText">'
														+ data['n']
														+ '</span><br>');
								var barcodePosition = getGoogleMapPosition(data['g']);
// marker.setMap(null);
								marker.setPosition(barcodePosition);
								map.panTo(barcodePosition);
								map.setCenter(barcodePosition);
								if (data['id'] == x && getCookie("TripPathGPSCookie") != "") {
									var nextDestId = getCookie("TripPathIdsCookie").split(
											"_");
									var tmpStr = "";
									for ( var int = 0; int < nextDestId.length; int++) {
										if (x == nextDestId[int]) {
											if (int == 0)
												tmpStr = nextDestId[int];
											else
												tmpStr += ","
														+ nextDestGPS[int];
										}
									}
										removeTheNextDestination();
								}
// });

					return presentLocation(data['p']);
				}
	,error: function (xhr, ajaxOptions, thrownError) {
        alert(xhr.status);
        alert(thrownError);
      }
			});

}
function presentLocation(x) {
	arrivalMessagePopupOpen();
	selectMapMode();
	$("#arrivalMessageContent").append(
			'<span class="heading">' + x['t']
					+ ': </span><span class="locationText">' + x['n']
					+ '</span><br>');
	if (x.p != null){
		presentLocation(x['p']);
		}else{
			$("#arrivalMessageContent").html('<img src="/NMMUWebApp/WebContent/images/map-markers/buildingss.png">' 
					
					+ $("#arrivalMessageContent").html());
		}
	
}

function hideInfoDiv() {
	$("#barcodeDescription").fadeOut(3000);
}
function getTheBarcodeAR(content) {
	getBCodeInfo(content);
// arrivalMessagePopupOpen();
// $("#barcodeDescription").css("display", "block").trigger('create');
// $("#barcodeDescription").fadeIn(3000);
// window.setInterval(hideInfoDiv, 5000);
}
