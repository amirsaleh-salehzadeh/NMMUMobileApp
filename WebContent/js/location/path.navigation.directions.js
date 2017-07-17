function getAngleDirection(angle) {
	angle = parseFloat(angle);
	var arrowGif = document.getElementById("directionShow");
	arrowGif.style.webkitTransform = "rotate(" + angle + "deg)";
	arrowGif.style.MozTransform = "rotate(" + angle + "deg)";
	arrowGif.style.transform = "rotate(" + angle + "deg)";
	if (parseFloat(-10) <= angle && angle <= parseFloat(10))
		return "keep going straight on the same direction";
	else if (angle < parseFloat(-10))
		return "turn left";
	else if (angle > parseFloat(10))
		return "turn right";

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

function getDistanceLeft(distance) {
	var Kilometres = Math.floor(distance / 1000);
	var Metres = Math.round(distance - (Kilometres * 1000));
	var res = "";
	if (Kilometres != 0)
		res = Kilometres + " kilometer(s) and " + Metres + " meter(s)";
	else
		res = Metres + " meter(s)";
	return res;
}