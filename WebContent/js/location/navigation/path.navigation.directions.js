function getAngleDirection(angle) {
	if (angle < 0)
		angle = 360 + angle;
	// var arrowGif = document.getElementById("arrowDirId");
	// arrowGif.style.webkitTransform = "rotate(" + angle + "deg)";
	// arrowGif.style.MozTransform = "rotate(" + angle + "deg)";
	// arrowGif.style.transform = "rotate(" + angle + "deg)";
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
	// $("#currentLocationInf").html(nextDestName);
	$("#currentLocationInfoContainer").trigger("create");
	var destName = getCookie("TripPathLocationsCookie").split("_");
	$("#destinationDescriptionInput").val(destName[destName.length - 1]);
	$("#distanceLeftInf").html(getDistanceLeft(distanceToDestination));
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
var ctx = document.getElementById('directionCanvas').getContext('2d');
var canvas = document.getElementById('directionCanvas');
// function drawCanvasDirection(){
function displayImage(angle) {
//	ctx.clearRect(0, 0, document.getElementById('directionCanvas').width,
//			document.getElementById('directionCanvas').height);
	var startPointX = 0, startPointY = 0, endPointX = 0, endPointY = 0, quadPointX = 0, quadPointY = 0;
	if (0 <= angle && angle < 45) {
		startPointX = 50;
		startPointY = 100;
		endPointX = 50 + (angle * 1.1);
		endPointY = 10;
		quadPointX = 50;
		quadPointY = 50;
	} else if (45 <= angle && angle < 90) {
		startPointX = 50;
		startPointY = 100;
		endPointX = 100;
		endPointY = ((angle - 45) * 1.1);
		quadPointX = 50;
		quadPointY = 50;
	} else if (90 <= angle && angle < 135) {
		startPointX = 50 - ((angle - 90) * 0.55);
		startPointY = 100;
		endPointX = 100;
		endPointY = ((angle - 45) * 1.1);
		quadPointX = 50;
		quadPointY = 50;// - ((angle - 45) * 1.1)
	} else if (135 <= angle && angle <= 180) {
		startPointX = 25;
		startPointY = 100;
		endPointX = 100 - ((angle - 135) * 1.1);
		endPointY = 100;
		quadPointX = 50;
		quadPointY = 0;
	} else if (180 < angle && angle < 225) {
		startPointX = 75;
		startPointY = 100;
		endPointX = 50 - ((angle - 180));
		endPointY = 100;
		quadPointX = 50;
		quadPointY = 0;
	} else if (225 <= angle && angle < 270) {
		startPointX = 75 - ((angle - 225) * 0.55);
		startPointY = 100;
		endPointX = 10;
		endPointY = 100 - ((angle - 225));
		quadPointX = 50;
		quadPointY = 50;// - ((angle - 225) * 1.1)
	} else if (270 <= angle && angle < 315) {
		startPointX = 50;
		startPointY = 100;
		endPointX = 10;
		endPointY = 50 - ((angle - 270) * 1.1);
		quadPointX = 50;
		quadPointY = 50;
	} else if (315 <= angle && angle <= 360) {
		startPointX = 50;
		startPointY = 100;
		endPointX = ((angle - 315));
		endPointY = 10;
		quadPointX = 50;
		quadPointY = 50;
	}
	var pathstr = "M"+startPointX+","+startPointY+ " Q"+ quadPointX + ","+ quadPointY + ","+ quadPointX + ","+ quadPointY; 

	var path = arrowline( canvas, pathstr, 4000, { stroke: 'black', 'stroke-width': 8, 'fill-opacity': 0 } );
//	ctx.strokeStyle = "rgb(12, 28, 44)";
//	ctx.lineWidth = 7;
//	ctx.lineCap = "round";
//	var arrowAngle = Math.atan2(quadPointX - endPointX, quadPointY - endPointY)
//			+ Math.PI;
//	var arrowWidth = 11;
//	ctx.beginPath();
//	ctx.moveTo(startPointX, startPointY);
//	ctx.quadraticCurveTo(quadPointX, quadPointY, endPointX, endPointY);
//	// ctx.lineTo(endPointX, endPointY);
//
//	ctx.moveTo(endPointX - (arrowWidth * Math.sin(arrowAngle - Math.PI / 6)),
//			endPointY - (arrowWidth * Math.cos(arrowAngle - Math.PI / 6)));
//
//	ctx.lineTo(endPointX, endPointY);
//
//	ctx.lineTo(endPointX - (arrowWidth * Math.sin(arrowAngle + Math.PI / 6)),
//			endPointY - (arrowWidth * Math.cos(arrowAngle + Math.PI / 6)));
//
//	ctx.stroke();
//	ctx.closePath();
}

function arrowline( canvas, pathstr, duration, attr, callback )
{    
	ctx.clearRect(0, 0, document.getElementById('directionCanvas').width,
			document.getElementById('directionCanvas').height);
    var guide_path = canvas.path( pathstr ).attr( { stroke: "none", fill: "none" } );
    var path = canvas.path( guide_path.getSubpath( 0, 1 ) ).attr( attr );
    var total_length = guide_path.getTotalLength( guide_path );
    var start_time = new Date().getTime();
    var interval_length = 25;
    
    var interval_id = setInterval( function()
        {
            var elapsed_time = new Date().getTime() - start_time;
            var this_length = elapsed_time / duration * total_length;
            var subpathstr = guide_path.getSubpath( 0, this_length );
            attr.path = subpathstr;
            path.animate( attr, interval_length );
                                       
            if ( elapsed_time >= duration )
            {
                clearInterval( interval_id );
                if ( callback != undefined ) callback();
            }                                       
        }, interval_length );  
    return path;    
}
