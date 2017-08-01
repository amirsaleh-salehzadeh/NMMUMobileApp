function getAngleDirection(angle) {
	if (angle < 0)
		angle = 360 + angle;
//	var arrowGif = document.getElementById("arrowDirId");
//	arrowGif.style.webkitTransform = "rotate(" + angle + "deg)";
//	arrowGif.style.MozTransform = "rotate(" + angle + "deg)";
//	arrowGif.style.transform = "rotate(" + angle + "deg)";
	if (parseFloat(-10) <= angle && angle <= parseFloat(10))
		return "keep going straight on the same direction";
	else if (angle < parseFloat(-10))
		return "turn left";
	else if (angle > parseFloat(10))
		return "turn right";

}

function getDistanceLeft(distance) {
	var Kilometres = Math.floor(distance / 1000);
	var Metres = Math.round(distance - (Kilometres * 1000));
	var res = "";
	if (Kilometres != 0)
		res = Kilometres + "." + Metres + " (Km) ";
	else
		res = Metres + " (m) ";
	return res;
}

function getTimeLeft(distance) {
	var Hours = 0;
	var Minutes = 0;
	var Seconds = 0;
	if (speed == undefined)
		speed = 0.001;
	if (speed > 0) {
		var TotalTime = (distance / 1000) / speed;
		Hours = Math.floor(TotalTime);
		Minutes = Math.floor((TotalTime - Hours) * 60);
		Seconds = Math.round((TotalTime - Hours - Minutes) * 60);
	}
	var String = " ";
	if (Hours > 0)
		String += Hours + "': ";
	String += Minutes + "\": " + Seconds + " s ";
	return String;
}

function getTripInfo() {
	var nextDestName = getCookie("TripPathLocationsCookie").split("_")[0];
	$("#currentLocationInf").html(nextDestName);
	$("#currentLocationInfoContainer").trigger("create");
	var destName = getCookie("TripPathLocationsCookie").split("_");
	$("#destinationInf").html(destName[destName.length - 1]);
	$("#distanceLeftInf").html(getDistanceLeft(distanceToDestination) + " to ");
	$("#arrivalTimeInf").html(getTimeLeft(distanceToDestination));
}
(function() {
	var lastTime = 0;
	var vendors = [ 'ms', 'moz', 'webkit', 'o' ];
	for ( var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x) {
		window.requestAnimationFrame = window[vendors[x]
				+ 'RequestAnimationFrame'];
		window.cancelAnimationFrame = window[vendors[x]
				+ 'CancelAnimationFrame']
				|| window[vendors[x] + 'CancelRequestAnimationFrame'];
	}

	if (!window.requestAnimationFrame)
		window.requestAnimationFrame = function(callback, element) {
			var currTime = new Date().getTime();
			var timeToCall = Math.max(0, 16 - (currTime - lastTime));
			var id = window.setTimeout(function() {
				callback(currTime + timeToCall);
			}, timeToCall);
			lastTime = currTime + timeToCall;
			return id;
		};

	if (!window.cancelAnimationFrame)
		window.cancelAnimationFrame = function(id) {
			clearTimeout(id);
		};
}());

// function drawCanvasDirection(){
var canvas;
var myImage = new Image();
var back = new Image();
var ctx;
function displayImage(angle) {
	var ctx = document.getElementById('directionCanvas').getContext('2d');
	var startPointX = 50;
	var startPointY = 100;
	var endPointX = 50 * Math.cos(angle) + 50;
	var endPointY = 50 * Math.sin(angle) + 50;
	var quadPointX = 50;
	var quadPointY = 50;
	ctx.strokeStyle = "rgb(12, 28, 44)";
	ctx.lineWidth = 7;
	ctx.lineCap = "round";
	var arrowAngle = Math.atan2(quadPointX - endPointX, quadPointY - endPointY)
			+ Math.PI;
	var arrowWidth = 11;

	ctx.beginPath();
	ctx.moveTo(startPointX, startPointY);
	ctx.quadraticCurveTo(quadPointX, quadPointY, endPointX, endPointY);
	// ctx.lineTo(endPointX, endPointY);

	ctx.moveTo(endPointX - (arrowWidth * Math.sin(arrowAngle - Math.PI / 6)),
			endPointY - (arrowWidth * Math.cos(arrowAngle - Math.PI / 6)));

	ctx.lineTo(endPointX, endPointY);

	ctx.lineTo(endPointX - (arrowWidth * Math.sin(arrowAngle + Math.PI / 6)),
			endPointY - (arrowWidth * Math.cos(arrowAngle + Math.PI / 6)));

	ctx.stroke();
	ctx.closePath();
}
displayImage(48);