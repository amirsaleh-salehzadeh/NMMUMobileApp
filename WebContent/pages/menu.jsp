<html>
<script type="text/javascript">
	function callAnAction(url) {
		var s = url.indexOf("reqCode=");
		var e = url.lastIndexOf("&");
		var reqCode;
		if (e <= 0)
			reqCode = url.substring(s + 8);
		else
			reqCode = url.substring(s + 8, e);
		$.ajax({
			url : url,
			cache : false,
			success : function(data) {
				$("#mainBodyContents").html(data);
				$("#mainBodyContents").trigger("create");
				$("#mainBodyMenuSettingBTN").attr("href",
						"#" + reqCode + "PopupSettingMenu");
				$(".ui-popup-active").css("display", "none");
				return false;
			}
		});

	}
	function refreshGrid() {
		$('form#dataFilterGridMainPage').ajaxSubmit(function(data) {
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
		$('form#dataFilterGridMainPage').ajaxSubmit(function(data) {
			$("#mainBodyContents").html(data);
			$("#mainBodyContents").trigger("create");
		});
	}
	function deleteAnItem(id, reqCode) {
		$("#reqCode").val(reqCode);
		$("#deleteID").val(id);
		$('form#dataFilterGridMainPage').ajaxSubmit(function(data) {
			$("#reqCode").val("roleGrid");
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
	function checkAllCheckBoxes(checkBox) {
		if ($(checkBox).attr("checked") == "checked") {
			$(".gridCheckBoxes").each(function() {
				$(this).attr("checked", "checked");
			});
		} else {
			$(".gridCheckBoxes").each(function() {
				$(this).attr("checked", false);
			});
		}
	}
	function deleteSelectedItems() {
		var ids = $('.gridCheckBoxes:checked').map(function() {
			return $(this).attr("id");
		}).get().join(',');
		deleteAnItem(ids, 'deleteRole');

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
					onclick="callAnAction('user.do?reqCode=userManagement');" href="#"
					data-ajax="false">User Management</a></li>
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