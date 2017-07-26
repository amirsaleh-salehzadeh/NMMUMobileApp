function getAngleDirection(angle) {
	angle = parseFloat(angle)-90;
	var arrowGif = document.getElementById("arrowDirId");
	arrowGif.style.webkitTransform = "rotate(" + angle + "deg)";
	arrowGif.style.MozTransform = "rotate(" + angle + "deg)";
	arrowGif.style.transform = "rotate(" + angle + "deg)";
	console.log(angle);
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
		res = Kilometres + "." + Metres + " (Km). ";
	else
		res = Metres + " (m). ";
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
	String += Minutes + "\": " + Seconds + " s. ";
	return String;
}

function getTripInfo() {
	var nextDestName = getCookie("TripPathLocationsCookie").split("_")[0];
	$("#currentLocationInf").html(nextDestName);
//	$("#speedInf").html(speed + " Km/h. ");
//	$("#seaLevelInf").html(Math.round(altitude) + " meter(s) above sea.");
	var destName = getCookie("TripPathLocationsCookie").split("_");
	$("#destinationInf").html(destName[destName.length - 1]);
//	$("#distanceLeftInf").html(getDistanceLeft(distanceToDestination));
	$("#arrivalTimeInf").html(getTimeLeft(distanceToDestination));
}
