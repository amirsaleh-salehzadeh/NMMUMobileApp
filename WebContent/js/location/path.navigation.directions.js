function getAngleDirection(angle) {
	angle = parseFloat(angle);
	if (parseFloat(-10) <= angle && angle <= parseFloat(10))
		return "keep going straight on the same direction";
	else if (angle < parseFloat(-10))
		return "turn left";
	else if (angle > parseFloat(10))
		return "turn right";
	console.log("hi>>>" + angle);
	var arrowGif = document.getElementById("arrowDirId");
	arrowGif.style.webkitTransform = "rotate(" + angle + "deg)";
	arrowGif.style.MozTransform = "rotate(" + angle + "deg)";
	arrowGif.style.transform = "rotate(" + angle + "deg)";
}

function getTripInfo() {
	var nextDestName = getCookie("TripPathLocationsCookie").split(",")[0];
	$("#currentLocationInf").html(nextDestName);
	$("#speedInf").html(speed + " Km/h. ");
	$("#seaLevelInf").html(Math.round(altitude) + " meter(s) above sea.");
	var destName = getCookie("TripPathLocationsCookie").split(",");
	$("#destinationInf").html(destName[destName.length - 1]);
	$("#distanceLeftInf").html(getDistanceLeft(distanceToDestination));
	$("#arrivalTimeInf").html(getTimeLeft(distanceToDestination));
}