function getAngleDirection(angle) {
	angle = parseFloat(angle);
	if (parseFloat(-10) <= angle && angle <= parseFloat(10))
		return "keep going straight on the same direction";
	else if (angle < parseFloat(-10))
		return "turn left";
	else if (angle > parseFloat(10))
		return "turn right";
}