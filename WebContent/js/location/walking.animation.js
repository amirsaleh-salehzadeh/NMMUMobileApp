var NavWidth = $(window).width();
var NavHeight = $(window).height();
var x = NavWidth / 2;
var y = NavHeight / 2;
var rotation = 0;
var crit = 0;
function walk() {
	var random = Math.floor((Math.random() * 360));
	while ((rotation - 90) - random > 45 || (rotation - 90) - random < -45) {
		random = Math.floor((Math.random() * 360));
		if (x + Math.cos((random / 180) * Math.PI) * 50 < 0
				|| y + Math.sin((random / 180) * Math.PI) * 50 < 0
				|| x + Math.cos((random / 180) * Math.PI) * 50 > NavWidth
				|| y + Math.sin((random / 180) * Math.PI) * 50 > NavHeight) {
			random += 180;
			break;
		}
		if (crit > 10) {
			break;
		}

		crit++;
	}
	crit = 0;
	x = x + Math.cos((random / 180) * Math.PI) * 50;
	y = y + Math.sin((random / 180) * Math.PI) * 50;
	rotation = random + 90;
	var footprint = document.createElement('img');
	footprint.setAttribute("src",
			"http://www.thecreator.fr/files/footprints-29.svg");
	footprint.style.position = "absolute";
	footprint.style.left = x + "px";
	footprint.style.top = y + "px";
	footprint.className = "footprint";
	footprint.style.webkitTransform = "rotate(" + rotation + "deg)";
	document.body.appendChild(footprint);
}
setInterval(function() {
	walk();
}, 1000);