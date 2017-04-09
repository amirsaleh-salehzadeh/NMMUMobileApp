$(document).ready(function () {
	$("input.AMSpaginationBTN").click(function(){
		$("input.AMSpaginationBTN").each(function(){
			if($(this).prop('disabled')==true){
				$(this).prop('disabled', false).trigger("create");
				$(this).button("refresh");
			}
		});
		$(this).prop('disabled', true).trigger("create");
		$(this).button("refresh");
		var page = $(this).attr('title');
		if($("#hiddenPage").length <=0)
			$('form#dataFormMainPage').prepend('<input name="page" type="hidden" id="hiddenPage" value="" />');
		$("input#hiddenPage").attr("value",page);
		$('#listForm').ajaxSubmit( function(data){
			fillTheGrid(data);
		});
		return false;
 	});
	$("input.AMSpaginationMainBTN").click(function(){
		var current;
		$("input.AMSpaginationBTN").each(function(){
			if($(this).prop('disabled')==true){
				var title = $(this).attr("value");
				current = parseInt(title);
				$(this).prop('disabled', false).trigger("create");
				$(this).button("refresh");
				$("input.AMSpaginationBTN").each(function(){
					if($(this).prop('disabled')==true){
						$(this).prop('disabled', false).trigger("create");
						$(this).button("refresh");
					}
				});
				if($(this).attr("title")== "Previous"){
					$("#hrefed"+(next-1)).prop('disabled', true).trigger("create");
					$("#hrefed"+(next-1)).button("refresh");
				}
				if($(this).attr("title")== "Next"){
					$("#hrefed"+(next+1)).prop('disabled', true).trigger("create");
					$("#hrefed"+(next+1)).button("refresh");
				}
			}
		});
		return false;
 	});
});

function callAGrid(url){
		$.ajax({
			url : url,
			type : "POST",
			data: $("#dataFormMainPage").serialize(),
			dataType : "html"
		}).done(function(data) {
			fillTheGrid(data);
		}).fail(function(jqXHR, textStatus, errorThrown) {
			$("#gridContents").html("Error!! File is not loaded");
		});
}
function fillTheGrid(data){
	$("#gridRows").html("");
	$("#gridRows").append(data).trigger("create");
	$("#rolesGrid").table("refresh");
}