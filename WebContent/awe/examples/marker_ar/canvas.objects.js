function Line(x1, y1, x2, y2) {
	this.x1 = x1;
	this.y1 = y1;
	this.x2 = x2;
	this.y2 = y2;
}
$(function() {
	// arrowToDown();
	// arrowToUp();
	// arrowToLeft();
	// arrowToRight();
});

function arrowToUp() {
	var canvas = document.getElementById("canvas");
	var context = canvas.getContext("2d");
	canvas.height = 88;
	canvas.width = 66;
	Line.prototype.drawWithArrowheads = function(ctx) {
		ctx.fillStyle = "#00FF00";
		ctx.lineWidth = 1;

		var startRadians = Math.atan((this.y2 - this.y1) / (this.x2 - this.x1));
		startRadians += ((this.x2 > this.x1) ? -90 : 90) * Math.PI / 180;
		this.drawArrowhead(ctx, this.x1, this.y1 - 11, startRadians);

		startRadians = Math.atan((this.y2 - this.y1) / (this.x2 - this.x1));
		startRadians += ((this.x2 > this.x1) ? -90 : 90) * Math.PI / 180;
		this.drawArrowhead(ctx, this.x1, this.y1 - 22, startRadians);

		startRadians = Math.atan((this.y2 - this.y1) / (this.x2 - this.x1));
		startRadians += ((this.x2 > this.x1) ? -90 : 90) * Math.PI / 180;
		this.drawArrowhead(ctx, this.x1, this.y1, startRadians);
	}
	Line.prototype.drawArrowhead = function(ctx, x, y, radians) {
		ctx.save();
		ctx.beginPath();
		ctx.translate(x, y);
		ctx.rotate(radians);
		ctx.moveTo(0, 0);
		ctx.lineTo(33, 66);
		ctx.lineTo(-33, 66);
		ctx.closePath();
		ctx.restore();
		ctx.fill();
	}
	var line = new Line(33, 22, 33, 22);
	line.drawWithArrowheads(context);
}

function arrowToRight() {
	var canvas = document.getElementById("canvas");
	var context = canvas.getContext("2d");
	canvas.height = 66;
	canvas.width = 88;
	Line.prototype.drawWithArrowheads = function(ctx) {
		ctx.strokeStyle = "blue";
		ctx.fillStyle = "#F300FF";
		ctx.lineWidth = 1;
		var startRadians = Math.atan((this.y2 - this.y1) / (this.x2 - this.x1));
		startRadians += ((this.x2 > this.x1) ? -90 : 90) * Math.PI / 180;
		this.drawArrowhead(ctx, this.x1 + 11, this.y1, startRadians);

		startRadians = Math.atan((this.y2 - this.y1) / (this.x2 - this.x1));
		startRadians += ((this.x2 > this.x1) ? -90 : 90) * Math.PI / 180;
		this.drawArrowhead(ctx, this.x1 + 22, this.y1, startRadians);

		startRadians = Math.atan((this.y2 - this.y1) / (this.x2 - this.x1));
		startRadians += ((this.x2 > this.x1) ? -90 : 90) * Math.PI / 180;
		this.drawArrowhead(ctx, this.x1, this.y1, startRadians);
	}
	Line.prototype.drawArrowhead = function(ctx, x, y, radians) {
		ctx.save();
		ctx.beginPath();
		ctx.translate(x, y);
		ctx.rotate(radians);
		ctx.moveTo(0, 0);
		ctx.lineTo(66, 33);
		ctx.lineTo(0, 66);
		ctx.closePath();
		ctx.restore();
		ctx.fill();
	}
	var line = new Line(0, 0, 0, 0);
	line.drawWithArrowheads(context);
}

function arrowToLeft() {
	var canvas = document.getElementById("canvas");
	var context = canvas.getContext("2d");
	canvas.height = 66;
	canvas.width = 88;
	Line.prototype.drawWithArrowheads = function(ctx) {
		ctx.fillStyle = "#FF8300";
		ctx.lineWidth = 1;
		var startRadians = Math.atan((this.y2 - this.y1) / (this.x2 - this.x1));
		startRadians += ((this.x2 > this.x1) ? -90 : 90) * Math.PI / 180;
		this.drawArrowhead(ctx, this.x1 + 11, this.y1, startRadians);

		startRadians = Math.atan((this.y2 - this.y1) / (this.x2 - this.x1));
		startRadians += ((this.x2 > this.x1) ? -90 : 90) * Math.PI / 180;
		this.drawArrowhead(ctx, this.x1 + 22, this.y1, startRadians);

		startRadians = Math.atan((this.y2 - this.y1) / (this.x2 - this.x1));
		startRadians += ((this.x2 > this.x1) ? -90 : 90) * Math.PI / 180;
		this.drawArrowhead(ctx, this.x1, this.y1, startRadians);
	}
	Line.prototype.drawArrowhead = function(ctx, x, y, radians) {
		ctx.save();
		ctx.beginPath();
		ctx.translate(x, y);
		ctx.rotate(radians);
		ctx.moveTo(0, 33);
		ctx.lineTo(66, 66);
		ctx.lineTo(66, 0);
		ctx.closePath();
		ctx.restore();
		ctx.fill();
	}
	var line = new Line(0, 0, 0, 0);
	line.drawWithArrowheads(context);
}

function arrowToDown() {
	var canvas = document.getElementById("canvas");
	var context = canvas.getContext("2d");
	canvas.height = 88;
	canvas.width = 66;
	Line.prototype.drawWithArrowheads = function(ctx) {
		ctx.strokeStyle = "blue";
		ctx.fillStyle = "#0083FF";
		ctx.lineWidth = 1;
		var startRadians = Math.atan((this.y2 - this.y1) / (this.x2 - this.x1));
		startRadians += ((this.x2 > this.x1) ? -90 : 90) * Math.PI / 180;
		this.drawArrowhead(ctx, this.x1, this.y1 - 11, startRadians);

		startRadians = Math.atan((this.y2 - this.y1) / (this.x2 - this.x1));
		startRadians += ((this.x2 > this.x1) ? -90 : 90) * Math.PI / 180;
		this.drawArrowhead(ctx, this.x1, this.y1 - 22, startRadians);

		startRadians = Math.atan((this.y2 - this.y1) / (this.x2 - this.x1));
		startRadians += ((this.x2 > this.x1) ? -90 : 90) * Math.PI / 180;
		this.drawArrowhead(ctx, this.x1, this.y1, startRadians);
	}
	Line.prototype.drawArrowhead = function(ctx, x, y, radians) {
		ctx.save();
		ctx.beginPath();
		ctx.translate(x, y);
		ctx.rotate(radians);
		ctx.moveTo(0, 66);
		ctx.lineTo(33, 0);
		ctx.lineTo(-33, 0);
		ctx.closePath();
		ctx.restore();
		ctx.fill();
	}
	var line = new Line(33, 22, 33, 22);
	line.drawWithArrowheads(context);
}