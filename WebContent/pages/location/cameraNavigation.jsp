<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Basic QR-code reader example - Version 1.0.1</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="css/camera/reset.css">
<link rel="stylesheet" href="css/camera/styles.css">
<script src="js/location/camera/photobooth.min.js"></script>

<script type="text/javascript" src="js/location/camera/qr/grid.js"></script>
<script type="text/javascript" src="js/location/camera/qr/version.js"></script>
<script type="text/javascript" src="js/location/camera/qr/detector.js"></script>
<script type="text/javascript" src="js/location/camera/qr/formatinf.js"></script>
<script type="text/javascript" src="js/location/camera/qr/errorlevel.js"></script>
<script type="text/javascript" src="js/location/camera/qr/bitmat.js"></script>
<script type="text/javascript" src="js/location/camera/qr/datablock.js"></script>
<script type="text/javascript" src="js/location/camera/qr/bmparser.js"></script>
<script type="text/javascript" src="js/location/camera/qr/datamask.js"></script>
<script type="text/javascript" src="js/location/camera/qr/rsdecoder.js"></script>
<script type="text/javascript" src="js/location/camera/qr/gf256poly.js"></script>
<script type="text/javascript" src="js/location/camera/qr/gf256.js"></script>
<script type="text/javascript" src="js/location/camera/qr/decoder.js"></script>
<script type="text/javascript" src="js/location/camera/qr/qrcode.js"></script>
<script type="text/javascript" src="js/location/camera/qr/findpat.js"></script>
<script type="text/javascript" src="js/location/camera/qr/alignpat.js"></script>
<script type="text/javascript" src="js/location/camera/qr/databr.js"></script>

<script src="js/location/camera/effects.js"></script>
</head>
<body>

	<div class="pageWrapper">

		<div class="boxWrapper">
			<div id="example"></div>
		</div>

		<div class="button">
			<a id="button">Scan QR code</a>
		</div>

		<div class="boxWrapper auto">
			<div id="hiddenImg"></div>
			<div id="qrContent">
				<p>Result will be here.</p>
			</div>
		</div>

	</div>


	<script src="js/location/camera/effects_saycheese.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			go();
		});
	</script>
</body>
</html>
