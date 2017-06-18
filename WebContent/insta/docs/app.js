function getTheTripAR(content){
	$.ajax({
		url : url,
		cache : false,
		success : function(data) {
			$("#mainBodyContents").html(data).trigger("create");
			// $(document).trigger("create");
			$(".ui-popup-active").css("display", "none");
			refreshPlaceHolders();
			if ($("#reqCodeGrid").val() != undefined) {
				refreshGrid();
			}
			return true;
		}
	});
}
var destin = document.getElementById("destId");
function getTheBarcodeAR(content){
	if(destin.value == "null"|| destin.value == "" || destin.value == null)
		destin.value= 0;
//	alert(content);
//	var jsonObj = $.parseJSON(content);
	$.ajax({
		url : "../../REST/GetLocationWS/GetALocation?locationId=" + content + "&pathType=" + $("#pathTypeId").val(),
		cache : false,
		success : function(data) {
			alert(data.locationName);
			return true;
		}
	});
}
var app = new Vue({
  el: '#app',
  data: {
    scanner: null,
    activeCameraId: null,
    cameras: [],
    scans: []
  },
  mounted: function () {
    var self = this;
    self.scanner = new Instascan.Scanner({ video: document.getElementById('preview'), scanPeriod: 5});
    self.scanner.addListener('scan', function (content, image) {
    	if(destin.value!="null"&& destin.value != "" && destin.value != null && destin.value != '0'){
    		getTheTripAR(content);
    	}else{
    		getTheBarcodeAR(content);}
      self.scans.unshift({ date: +(Date.now()), content: content });
    });
    Instascan.Camera.getCameras().then(function (cameras) {
      self.cameras = cameras;
      if(cameras.length > 1){
    	  for ( var i = 0; i < cameras.length; i++) {
			if(cameras[i].name.indexOf("back")>=0||cameras[i].name.indexOf("rear")>=0){
				 self.activeCameraId = cameras[i].id;
			        self.scanner.start(cameras[i]);
			};
		};
      }else if (cameras.length > 0) {
          self.activeCameraId = cameras[0].id;
          self.scanner.start(cameras[0]);
        } else {
        console.error('No cameras found.');
      }
    }).catch(function (e) {
      console.error(e);
    });
  },
  methods: {
    formatName: function (name) {
      return name || '(unknown)';
    },
    selectCamera: function (camera) {
      this.activeCameraId = camera.id;
      this.scanner.start(camera);
    }
  }
});
document
.addEventListener(
		"DOMContentLoaded",
		function(event) {

			if (window.DeviceOrientationEvent) {
				window.addEventListener('deviceorientation',
						function(eventData) {
							// gamma: Tilting the device from left to right. Tilting the device to the right will result in a positive value.
							// gamma: Het kantelen van links naar rechts in graden. Naar rechts kantelen zal een positieve waarde geven.
							var tiltLR = eventData.gamma;

							// beta: Tilting the device from the front to the back. Tilting the device to the front will result in a positive value.
							// beta: Het kantelen van voor naar achteren in graden. Naar voren kantelen zal een positieve waarde geven.
							var tiltFB = eventData.beta;

							// alpha: The direction the compass of the device aims to in degrees.
							// alpha: De richting waarin de kompas van het apparaat heen wijst in graden.
							var dir = eventData.alpha

							// Call the function to use the data on the page.
							// Roep de functie op om de data op de pagina te gebruiken.
							deviceOrientationHandler(tiltLR,
									tiltFB, dir);
						}, false);
			} 
			;

			function deviceOrientationHandler(tiltLR, tiltFB, dir) {
				document.getElementById("tiltLR").innerHTML = Math
						.ceil(tiltLR);
				document.getElementById("tiltFB").innerHTML = Math
						.ceil(tiltFB);
				document.getElementById("direction").innerHTML = Math
						.ceil(dir);

				// Rotate the disc of the compass.
				// Laat de kompas schijf draaien.
				var compassDisc = document
						.getElementById("compassDiscImg");
				compassDisc.style.webkitTransform = "rotate(" + dir
						+ "deg)";
				compassDisc.style.MozTransform = "rotate(" + dir
						+ "deg)";
				compassDisc.style.transform = "rotate(" + dir
						+ "deg)";
			}

		});
