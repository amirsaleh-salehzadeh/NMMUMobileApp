<html>
<style type="text/css">
body {
  -moz-user-select: none;
  -khtml-user-select: none;
  -webkit-user-select: none;
  user-select: none;
  -ms-user-select : none
}
</style>
<script type="text/javascript">
	function callAnAction(url) {
		$('#gridMenuSetting').popup("destroy");
		$.ajax({
			url : url,
			cache : false,
			success : function(data) {
				$("#mainBodyContents").html(data);
				$(document).trigger("create");
				$(".ui-popup-active").css("display", "none");
				refreshGrid();
				return true;
			}
		});
	}
	function saveTheForm() {
		var url = $("#dataFilterGridMainPage").attr("action");
		url += "?" + $("#dataFilterGridMainPage").serialize();
		$.ajax({
			url : url,
			cache : false,
			success : function(data) {
				$("#mainBodyContents").html(data);
				$(document).trigger("create");
				$(".ui-popup-active").css("display", "none");
				refreshGrid();
				return true;
			}
		});
	}
	function deleteAnItem(ids, reqCode) {
		$("#reqCode").val(reqCode);
		$("#deleteID").val(ids);
		var url = $("#dataFilterGridMainPage").attr("action");
		url += "?" + $("#dataFilterGridMainPage").serialize();
		$.ajax({
			url : url,
			cache : false,
			success : function(data) {
				$("#mainBodyContents").html(data);
				$(document).trigger("create");
				$(".ui-popup-active").css("display", "none");
				$("input.AMSpaginationBTN").each(function() {
					if ($(this).attr('title') == $("#hiddenPage").val()) {
						$(this).prop('disabled', true).trigger("create");
						$(this).button("refresh");
					}
				});
				refreshGrid();
				return true;
			}
		});
	}
	function deleteSelectedItems(reqCode) {
		var ids = $('.gridCheckBoxes:checked').map(function() {
			return $(this).attr("id");
		}).get().join(',');
		deleteAnItem(ids, reqCode);
	}
</script>
<div class='ui-loader ui-overlay-shadow ui-body-e ui-corner-all'
	id='errorMessage'>
	<h1>Sorry, what was incorrect. Please try again.</h1>
</div>
<ul class="jqm-list ui-alt-icon ui-nodisc-icon">
	<li data-filtertext="demos homepage" data-icon="home"><a
		href=".././">Home</a></li>
	<li data-role="collapsible" data-enhanced="true"
		data-collapsed-icon="carat-d" data-expanded-icon="carat-u"
		data-iconpos="right" data-inset="false"
		class="ui-collapsible ui-collapsible-themed-content ui-collapsible-collapsed">
		<h3 class="ui-collapsible-heading ui-collapsible-heading-collapsed">
			<a href="#"
				class="ui-collapsible-heading-toggle ui-btn ui-btn-icon-right ui-btn-inherit ui-icon-carat-d">
				Administrator<span class="ui-collapsible-heading-status">
					click to expand contents</span>
			</a>
		</h3>
		<div
			class="ui-collapsible-content ui-body-inherit ui-collapsible-content-collapsed"
			aria-hidden="true">
			<ul>
				<li
					data-filtertext="form checkboxradio widget radio input radio buttons controlgroups"><a
					href="t_user.do?reqCode=userManagement"
					data-ajax="false">User Management</a></li>
				<li
					data-filtertext="form checkboxradio widget checkbox input checkboxes controlgroups"><a
					href="t_security.do?reqCode=roleManagement"
					data-ajax="false">Role Management</a></li>
				<li
					data-filtertext="form checkboxradio widget radio input radio buttons controlgroups"><a
					href="t_security.do?reqCode=groupManagement" data-ajax="false">Group
						Management</a></li>
			</ul>
		</div>
	</li>
	<li data-filtertext="introduction overview getting started"><a
		href="../intro/" data-ajax="false">Location</a></li>
</ul>
</html>