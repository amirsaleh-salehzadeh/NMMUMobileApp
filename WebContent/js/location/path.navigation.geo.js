var watchAccelerometerID, alpha, beta, gamma;

function startAccelerometer() {
    var options = { frequency: 100 };
    watchAccelerometerID = navigator.accelerometer.watchAcceleration(onAccelerometerSuccess, onAccelerometerError, options);
}

function stopAccelerometer() {
    if (watchAccelerometerID) {
        navigator.accelerometer.clearWatch(watchAccelerometerID);
        watchAccelerometerID = null;
    }
}

function onAccelerometerSuccess(acceleration) {
	var element = document.getElementById('accl');
    element.innerHTML = 'Acceleration X: ' + acceleration.x + '<br />' +
                        'Acceleration Y: ' + acceleration.y + '<br />' +
                        'Acceleration Z: ' + acceleration.z ;
}

function onAccelerometerError() {
    document.getElementById('log').innerHTML += "onError.";
}

function handleOrientation(event) {
	alpha = event.alpha;
	beta = event.beta; // In degree in the range [-180,180]
	gamma = event.gamma;// In degree in the range [-90,90]

//	var strings = "alpha : " + alpha + "\n";
//	strings += "beta : " + beta + "\n";
//	strings += "gamma: " + gamma + "\n >>>> X: "
//			+ compassHeading(alpha, beta, gamma);// +
}

window.addEventListener('deviceorientation', handleOrientation, true);

function compassHeading(alpha, beta, gamma) {

	// Convert degrees to radians
	var alphaRad = alpha * (Math.PI / 180);
	var betaRad = beta * (Math.PI / 180);
	var gammaRad = gamma * (Math.PI / 180);

	// Calculate equation components
	var cA = Math.cos(alphaRad);
	var sA = Math.sin(alphaRad);
	var cB = Math.cos(betaRad);
	var sB = Math.sin(betaRad);
	var cG = Math.cos(gammaRad);
	var sG = Math.sin(gammaRad);

	// Calculate A, B, C rotation components
	var rA = -cA * sG - sA * sB * cG;
	var rB = -sA * sG + cA * sB * cG;
	var rC = -cB * cG;

	// Calculate compass heading
	var compassHeading = Math.atan(rA / rB);

	// Convert from half unit circle to whole unit circle
	if (rB < 0) {
		compassHeading += Math.PI;
	} else if (rA < 0) {
		compassHeading += 2 * Math.PI;
	}

	// Convert radians to degrees
	compassHeading *= 180 / Math.PI;

	return compassHeading;

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

