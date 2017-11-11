var dataURI;
function getDataURI(){
	return dataURI;
}

////var basic = $('#main-cropper').croppie({
//var basic = $('#iconCropDiv').croppie({
//	viewport: { width: 128, height: 128 },
//	boundary: { width: 200, height: 200 },
//	showZoomer: false
//});
//basic.croppie('bind', {
//    url: 'images/NMMU_logo.png'
//});

function createCroppie() {
	$("#main-cropper").append("<span>Use the scroll wheel of your mouse to resize the image</span>");
	var basic = $('#main-cropper').croppie({
		viewport: { width: 128, height: 128 },
		boundary: { width: 200, height: 200 },
		showZoomer: false
	});
	basic.croppie('bind', {
	    url: 'images/NMMU_logo.png'
	});
}

function readFile(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
    	$('#main-cropper').croppie('bind', {
        url: e.target.result
      });
      //$('.actionDone').toggle();
      //$('.actionUpload').toggle();
    };

    reader.readAsDataURL(input.files[0]);
  }
  else {
      swal("Sorry - you're browser doesn't support the FileReader API");
  }
}
function callReadFile(){
	//alert("Hi");
}

//$('.actionUpload input').on('change', function () {readFile(this); });

$("#upload").change(function () {
	$("#main-cropper").empty();
	$("#iconCropDiv").empty();
	createCroppie();
	readFile(this);
	});

//$('#upload').on('click', function () {
//	createCroppie();
//	$("#iconCropDiv").empty();
//	readFile(this);
//	});

$('#cropIcon').on('click', function (ev) {
	$('#main-cropper').croppie('result', {
		type: 'canvas',
		size: 'viewport',
		format: 'png'
	}).then(function (resp) {
		$("#iconCropDiv").append("<span>The Cropped Icon</span><br>");
		$("#iconCropDiv").append("<img id=\"croppedIcon\" src=\"\" alt=\"\"/>");
		this.picture = $("#croppedIcon");
		this.picture.attr('src', resp);
		var img = document.getElementById("croppedIcon");
		var x = document.getElementById("croppedIcon").src;
		dataURI = x;
	    $("#icon").val(x);
	});
	$("#main-cropper").empty();
	alert("The Icon has been cropped");
});

//$("#savePlan").click(function(e) {
//	//alert(getDataURL());
//	$("#plan").val(getDataURI());
//});