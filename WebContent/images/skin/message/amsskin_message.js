var browser = navigator.appName;
var ExtraSpace     = 10;
var WindowLeftEdge = 0 ; 
var WindowTopEdge = 0 ;
var WindowWidth = 0 ;
var WindowHeight = 0 ;
var WindowRightEdge = 0 ;
var WindowBottomEdge = 0 ; 

$(document).ready(function(){
//	if ( $("#messageDiv #messageTable #messageContainer #errorDescription").html() !== ""  || 
//		 $("#messageDiv #messageTable #messageContainer #successDescription").html() !== "") {
		createTransparentBg4Message();
//		$("#messageDiv").css('visibility','visible');	
//		$("#bgDiv4Message").click(function(){
//			$("#bgDiv4Message").remove();
//			$("#messageDiv").css('visibility','hidden');
//		});
//		$("#messageDiv").click(function(){
//			$("#bgDiv4Message").remove();
//			$("#messageDiv").css('visibility','hidden');
//		});
		
//	}
	$("#popupErrorMessage").trigger("create");
	$("#popupErrorMessage").popup("open");
});


jQuery.fn.getMessage = function(options) {
	this.settings = $.extend({
		messageDesc: '',
		toBeHighlightedDOM: '',
		color: 'red'
	}, options || {});
	createMessage(this.settings);	
};


function createMessage(settings) {
	alert(1);
	$(".viewTitles").removeClass('focusedElementOnError');
	createTransparentBg4Message();
	$("#messageContainer").empty();
	$("#messageContainer").append('<label id="errorDescription" style="color: ' + settings.color + ';">'+ settings.messageDesc +'</label>');
	$("#messageDiv").css('visibility','visible');
	if (settings.toBeHighlightedDOM !== '') {
		var doms = 	settings.toBeHighlightedDOM.split(",");
		for (var i = 0 ; i < doms.length ; i = i+1) {
			$(doms[i]).addClass('focusedElementOnError');
		}
	}
	$("#bgDiv4Message").click(function(){
		$("#bgDiv4Message").remove();
		$("#messageDiv").css('visibility','hidden');
	});
	$("#messageDiv").click(function(){
		$("#bgDiv4Message").remove();
		$("#messageDiv").css('visibility','hidden');
	});
}


createTransparentBg4Message = function(){
	calculateDimensions();
	var bgObj = document.createElement("div"); 
	bgObj.setAttribute('id','bgDiv4Message'); 
	bgObj.style.position="fixed"; 
	bgObj.style.top="0"; 
	bgObj.style.background="#cccccc"; 
	bgObj.style.filter="progid:DXImageTransform.Microsoft.Alpha(style=3,opacity=25,finishOpacity=75"; 
	bgObj.style.opacity="0.6"; 
	bgObj.style.left="0"; 
	bgObj.style.width= (WindowRightEdge + 250) + "px"; 
	bgObj.style.height= (WindowBottomEdge + 250) + "px"; 
	bgObj.style.zIndex = "999";
	document.body.appendChild(bgObj); 
};

function calculateDimensions() {
	if (browser.indexOf('Microsoft') != -1 ) {	
		WindowLeftEdge = document.body.scrollLeft;
		WindowTopEdge  = document.body.scrollTop;
		WindowWidth    = document.body.clientWidth;
		WindowHeight   = document.body.clientHeight;
		WindowRightEdge  = (WindowLeftEdge + WindowWidth) - ExtraSpace;
		WindowBottomEdge = (WindowTopEdge + WindowHeight) - ExtraSpace;
	} else if (browser.indexOf('Netscape') != -1) {
		WindowLeftEdge = document.body.scrollLeft;
		WindowTopEdge  = document.body.scrollTop;
		WindowWidth    = document.body.clientWidth;
		WindowHeight   = document.body.clientHeight;
		WindowRightEdge  = (WindowLeftEdge + WindowWidth) - ExtraSpace;
		WindowBottomEdge = (WindowTopEdge + WindowHeight) - ExtraSpace;
	}
}


