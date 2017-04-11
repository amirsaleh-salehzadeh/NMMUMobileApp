$(document).ready(function () {
	$("input.AMSpaginationBTN").click(function(){
		var page = $(this).attr('title');
		if($("#hiddenPage").length <=0)
			$('form#dataFilterGridMainPage').prepend('');
		$("input#hiddenPage").attr("value",page);
		$('form#dataFilterGridMainPage').ajaxSubmit(function(data){
			refreshGrid(data);
		});
		return false;
 	});
	$("input.AMSpaginationMainBTN").click(function(){
		if($(this).attr("title")== "Previous"){
			if(parseInt($("input#hiddenPage").val())>=1){
				$("input#hiddenPage").attr("value", parseInt($("input#hiddenPage").val())-1);
				$('form#dataFilterGridMainPage').ajaxSubmit(function(data){
					refreshGrid(data);
				});
			}
		}
		if($(this).attr("title")== "Next"){
			$("input#hiddenPage").attr("value", parseInt($("input#hiddenPage").val())+1);
			$('form#dataFilterGridMainPage').ajaxSubmit(function(data){
				refreshGrid(data);
			});
		}
		if($(this).attr("title")== "First"){
			$("input#hiddenPage").attr("value", 0);
			$('form#dataFilterGridMainPage').ajaxSubmit(function(data){
				refreshGrid(data);
			});
		}
		if($(this).attr("title")== "Last"){
			$("input#hiddenPage").attr("value", $(this).attr("value"));
			$('form#dataFilterGridMainPage').ajaxSubmit(function(data){
				refreshGrid(data);
			});
		}
		return false;
 	});
});