<html>
<script type="text/javascript">
	function callAnAction(url) {
		$.ajax({
			url : url,
			cache : false,
			success : function(data) {
				$("#mainBodyContents").html(data);
				$("#mainBodyContents").trigger("create");
				$(".ui-popup-active").css("display", "none");
				return false;
			}
		});
	}
	function refreshGrid() {
		$('form#dataFilterGridMainPage').ajaxSubmit(function(data){
			$("#gridContainer").html(data);
			$("#gridContainer").trigger("create");
			$("input.AMSpaginationBTN").each(function() {
				if ($(this).attr('title') == $("#hiddenPage").val()) {
					$(this).prop('disabled', true).trigger("create");
					$(this).button("refresh");
				}
			});
		});
	}
	function saveTheForm() {
		$('form#dataFilterGridMainPage').ajaxSubmit(function(data){
			$("#mainBodyContents").html(data);
			$("#mainBodyContents").trigger("create");
		});
	}
</script>
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
					onclick="callAnAction('#');" href="#" data-ajax="false">User
						Management</a></li>
				<li
					data-filtertext="form checkboxradio widget checkbox input checkboxes controlgroups"><a
					href="#"
					onclick="callAnAction('security.do?reqCode=roleManagement');"
					data-ajax="false">Role Management</a></li>
				<li
					data-filtertext="form checkboxradio widget radio input radio buttons controlgroups"><a
					onclick="callAnAction('#');" href="#" data-ajax="false">Group
						Management</a></li>
			</ul>
		</div>
	</li>
	<li data-filtertext="introduction overview getting started"><a
		href="../intro/" data-ajax="false">Location</a></li>
</ul>
</html>