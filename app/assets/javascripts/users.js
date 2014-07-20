var fn_users_BindVerifyButtonClick = function() {
	// company verify
	$('#btn_verify_company').bind('click', function() {

		var acc_num = $("#company_account_num").val();
		var lgl_person = $("#company_legal_person").val();
		if (acc_num && acc_num != "" && lgl_person != "") {
			$.ajax({
				url : '/company/verify',
				type : 'GET',
				data : {
					'account_num' : acc_num,
					'legal_person' : lgl_person
				}
			}).done(function(data) {
				//alert(JSON.stringify(data));
			}).fail(function(jqXHR, textStatus) {
				//alert("Request failed: " + textStatus);
			});
		} else {
			var comp_name = $("#company_name").val();
			var comp_license = $("#company_license_image").val();
			var comp_lp = $("#company_legal_person").val();
			var comp_addr = $("#company_register_address").val();
			if (comp_name != "" && comp_license != "") {
				$.ajax({
					url : '/company/verify',
					type : 'GET',
					data : {
						'name' : comp_name,
						'license_image' : comp_license,
						'legal_person' : comp_lp,
						'register_address' : comp_addr
					}
				}).done(function(data) {

					//alert(JSON.stringify(data));
				}).fail(function(jqXHR, textStatus) {
					//alert("Request failed: " + textStatus);
				});
			} else {
				// TODO: error msg display
				$("#vefiry_msg_area").html("Fill required info!");
			}

		}
	});
};

var fn_users_bindRegMethodsEvents = function() {
	var fnGetPartailForm = function(sRegMethd) {
		$.ajax({
			url : '/user_new_partial', //Note the my_controller and action here, i.e. change accordingly
			type : 'get',
			data : {
				"reg_method" : sRegMethd // used to check in reg_ajax.... .js.erb
			}
		}).done(function(data) {
			fn_users_BindVerifyButtonClick();
			fnDisableDiv("#reg-user-info-area");

		}).fail(function(jqXHR, textStatus) {
			//alert("Request failed: " + textStatus);
		});
	};

	$('input[type=radio][name=registerMethod]').change(function() {
		// if (this.value == 'unreg') {
		// fnGetPartailForm('unreg');
		// } else if (this.value == 'reged') {
		// fnGetPartailForm('reged');
		// }
		fnGetPartailForm(this.value);
	});
};

// logon related
var fn_users_bindLogonEvents = function() {
	if ($(".logon-content").length > 0) {
		var $enterItem = $('.enter-item');
		var $placeholderItem = $('.placeholder');

		$enterItem.focus(function() {
			$(this).next(".placeholder").addClass('hide');
		});

		$enterItem.blur(function() {
			var val = $(this).val();
			if (!val || val == "") {
				$(this).next(".placeholder").removeClass('hide');
			}
		});
	}
};

// run when reg page renders
$(document).ready(function() {
	// fn_users_bindRegMethodsEvents();
	// fn_users_BindVerifyButtonClick();
	// fnDisableDiv("#reg-user-info-area");

	fn_users_bindLogonEvents();

	// logon dialog overlay configuration
	$("#dialog_logon").overlay({
		top : 100,
		mask : {
			color : '#111',
			loadSpeed : 50,
			opacity : 0.2
		},
		closeOnClick : true,
		load : false

	});

	var $role_selected = $(".userBasicInfo .role_selection");
	$role_selected.click(function() {
		var isSelected = $(this).hasClass("selected");
		$role_selected.removeClass("selected");
		if (!isSelected) {
			$(this).addClass("selected");
		}
	});

});
