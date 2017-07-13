function userMedia() {
	return navigator.getUserMedia = navigator.getUserMedia
			|| navigator.webkitGetUserMedia || navigator.mozGetUserMedia
			|| navigator.msGetUserMedia || null;
}
var track;
function startCamera() {
	var backCamId ="";
	  var constraints =null;
	if (userMedia() && track == undefined) {
		navigator.mediaDevices.enumerateDevices()
		  .then(function(devices) {
		    devices.forEach(function(device) {
		    	constraints = {
		  				video : true,
		  				audio : false
		  			};
		    	if(device.kind.indexOf('video')>=0){
		      if(device.label.indexOf('back')>=0){
		    	  backCamId = device.deviceId;  
		  			constraints = {
		  				audio : false,
		  				video: {
		  				    optional: [{sourceId: backCamId}]
		  				  }
		  			};
		      }
		    }
		    });
		  }).then(function(){
			  var media = navigator.getUserMedia(constraints, function(stream) {
		  			var v = document.getElementById('videoContent');
		  			// URL Object is different in WebKit
		  			var url = window.URL || window.webkitURL;

		  			// create the url and set the source of the video element
		  			v.src = url ? url.createObjectURL(stream) : stream;
		  			track = stream.getVideoTracks()[0];
		  			// Start the video
		  			v.play();
		  		}, function(error) {
		  			console.log("ERROR");
		  			console.log(error);
		  		});
		  }).catch(function(err) {
		    console.log(err.name + ": " + error.message);
		  });
	} else {
		console.log("KO");
	}
}

function stopCamera() {
	track.stop();
	track = null;
	$('#videoContent').src = "";
}

function selectDualMode() {
	$("#cameraView").css("display", "block");
	$("#mapView").css("display", "block");
	$('#cameraView').height($(window).height() / 2);
	$('#map_canvas').height($(window).height() / 2);
	$('#mapView').height($(window).height() / 2);
	$('#videoContent').height($(window).height() / 2);
	document.getElementById('videoContent').style.height = '100%';
	document.getElementById('videoContent').style.width = '100%';
	google.maps.event.trigger(map, "resize");
	startCamera();
	findMyLocation();
}

function selectCameraMode() {
	$("#cameraView").css("display", "block");
	$("#mapView").css("display", "none");
	$('#cameraView').height($(window).height());
	document.getElementById('videoContent').style.height = '100%';
	document.getElementById('videoContent').style.width = '100%';
	google.maps.event.trigger(map, "resize");
	startCamera();
	findMyLocation();
}

function selectMapMode() {
	$("#cameraView").css("display", "none");
	$("#mapView").css("display", "block");
	$('#mapView').height($(window).height());
	$('#map_canvas').height($(window).height());
	google.maps.event.trigger(map, "resize");
	stopCamera();
	findMyLocation();
}