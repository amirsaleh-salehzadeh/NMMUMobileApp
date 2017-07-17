function userMedia() {
	return navigator.getUserMedia = navigator.getUserMedia
			|| navigator.webkitGetUserMedia || navigator.mozGetUserMedia
			|| navigator.msGetUserMedia || null;
}

var cameraObjs = [];
var cameraObj = undefined;
function gotDevices(deviceInfos) {
	  for (var i = 0; i !== deviceInfos.length; ++i) {
	    var deviceInfo = deviceInfos[i];
	    if (deviceInfo.kind === 'videoinput') {
	    	cameraObjs.push(deviceInfo);
	    } else {
	      console.log('Found ome other kind of source/device: ', deviceInfo);
	    }
	  }
	}

	function getStream() {
	  if (window.stream) {
	    window.stream.getTracks().forEach(function(track) {
	      track.stop();
	    });
	  }
	  cameraObj = cameraObjs[0]; 
	  if(cameraObjs.length>1){
		  cameraObj = cameraObjs[1];
	  }
	  var constraints = {
	    video: {
	      optional: [{
	        sourceId: cameraObj.deviceId
	      }]
	    }
	  };
	  navigator.mediaDevices.getUserMedia(constraints).
	      then(gotStream).catch(handleError);
	}

	function gotStream(stream) {
	  window.stream = stream; // make stream available to console
	  document.getElementById('videoContent').srcObject = stream;
	  track = stream.getVideoTracks()[0];
		// Start the video
	  document.getElementById('videoContent').play();
	  $('#videoContent').width(parseInt($(window).width()));
	}

	function handleError(error) {
	  console.log('Error: ', error);
	}

var track;
function startCamera() {
 startScanner();
}

function stopCamera() {
	cameraView = undefined;
	if(scanner != undefined)
		scanner.stop();
	$('#videoContent').src = "";
}

function selectDualMode() {
	$("#zoomSettings").css("display", "block");
	$("#cameraView").css("display", "absolute");
	$("#mapView").css("display", "block");
	$('#cameraView').height($(window).height() / 4);
	$('#videoContent').height($(window).height() / 4);
	$('#cameraView').width($(window).width() / 4);
	$('#videoContent').width($(window).width() / 4);
	document.getElementById('videoContent').style.height = '100%';
	document.getElementById('videoContent').style.width = '100%';
	stopCamera();
	startCamera();
	findMyLocation();
}

// function selectCameraMode() {
// $("#cameraView").css("display", "block");
// $("#mapView").css("display", "none");
// $('#cameraView').height($(window).height());
// $("#zoomSettings").css("display", "none");
//	
// document.getElementById('videoContent').style.height = '100%';
// document.getElementById('videoContent').style.width = '100%';
// google.maps.event.trigger(map, "resize");
// startCamera();
// findMyLocation();
// }

function selectMapMode() {
	$("#zoomSettings").css("display", "block");
	$("#cameraView").css("display", "none");
	$("#mapView").css("display", "block");
	$('#mapView').height($(window).height());
	$('#map_canvas').height($(window).height());
	google.maps.event.trigger(map, "resize");
	stopCamera();
	findMyLocation();
}