function userMedia(){
    return navigator.getUserMedia = navigator.getUserMedia ||
    navigator.webkitGetUserMedia ||
    navigator.mozGetUserMedia ||
    navigator.msGetUserMedia || null;
}
var media;
function startCamera(){
	if( userMedia() ){

        var constraints = {
            video: true,
            audio:false
        };

        media = navigator.getUserMedia(constraints, function(stream){
            var v = document.getElementById('videoContent');
            // URL Object is different in WebKit
            var url = window.URL || window.webkitURL;

            // create the url and set the source of the video element
            v.src = url ? url.createObjectURL(stream) : stream;

            // Start the video
            v.play();
        }, function(error){
            console.log("ERROR");
            console.log(error);
        });
    } else {
        console.log("KO");
    }
}

function stopCamera(){
	if( userMedia() ){
        media.stop();
    } else {
        console.log("KO");
    }
}

function selectDualMode(){
	$("#cameraView").css("display", "block");
	$("#mapView").css("display", "block");
    $('#cameraView').height( $(window).height() / 2 );
    $('#map_canvas').height( $(window).height() / 2 );
    $('#mapView').height( $(window).height() / 2 );
    $('#videoContent').height( $(window).height() / 2 );
	document.getElementById('videoContent').style.height = '100%';
	document.getElementById('videoContent').style.width = '100%';
	google.maps.event.trigger(map, "resize");
    startCamera();
    findMyLocation();
}

function selectCameraMode(){
	$("#cameraView").css("display", "block");
	$("#mapView").css("display", "none");
    $('#cameraView').height( $(window).height());
	document.getElementById('videoContent').style.height = '100%';
	document.getElementById('videoContent').style.width = '100%';
	google.maps.event.trigger(map, "resize");
    startCamera();
    findMyLocation();
}

function selectMapMode(){
	$("#cameraView").css("display", "none");
	$("#mapView").css("display", "block");
    $('#mapView').height( $(window).height());
    $('#map_canvas').height( $(window).height());
	document.getElementById('videoContent').stop();
	google.maps.event.trigger(map, "resize");
    startCamera();
    findMyLocation();
}