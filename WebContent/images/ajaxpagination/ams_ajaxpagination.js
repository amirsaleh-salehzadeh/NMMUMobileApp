$(document).ready(function () {
	$(".noHref").removeAttr("href");
	$(".paginate a[id^='hrefed']").bind("click", function(){
		var page = $(this).attr('id');
		page = page.substring(6);
		$('#listForm').prepend('<input name="page" dir="ltr" type="hidden" id="hiddenPage" value="" />');
		$("input#hiddenPage").attr("value",page);
		$('#listForm').ajaxSubmit( function(data){
			$("#"+$("#pagingAjaxContainer").val()).html(data);
		});
		return false;
 	});	
});