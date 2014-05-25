var fnOrderListInit = function() {

	$('.orders_container').shapeshift();

	var $arr_bid_progressbar = $(".bid_progressbar");
	$.each($arr_bid_progressbar, function(index, elem) {
		var prog_val = parseInt($(elem).data("progressval"));
		var bid_status = parseInt($(elem).data("status"));

		if (bid_status == 1 || bid_status == 0) {
			$(elem).css("height", "10px");
			$(elem).find(".ui-widget-header").css("height", "10px");
		} else {
			var $label = $(elem).next(".progress_label");
			$label.find("img").css("display", "inline").css("height", "23px");
			$label.css("height", "25px").css("position", "relative").css("top", "-25px");

			if (bid_status == 2 || bid_status == 3) {
				prog_val = 100;
			}
		}

		$(elem).progressbar({
			value : prog_val
		});
	});

	// add by Song: quick view dialog
	$(".quickViewButton").on('click', function() {
		$("#quickview_dialog").overlay().load();
	});

};

var fnMsgArea = function() {
	$(".msg_area").click(function() {
		$(this).remove();
	});
};

var fnDisableDiv = function(selector) {
	$(selector).addClass("disabled");
};

var fnEnableDiv = function(selector) {
	$(selector).removeClass("disabled");
};

var fnRemoveMaskDiv = function(selector) {
	$(selector).find(".mask-layer").remove();
};

var fnMaskDiv = function(selector, newHeight) {
	if (!$(selector)[0])
		return;

	fnRemoveMaskDiv(selector);

	var height = newHeight || $(selector).height() + 50;
	// 20 for hack
	var width = $(selector).width();
	if (parseInt(height) <= 0 || parseInt(width) <= 0) {
		return;
	}

	var oPos = $(selector).position();
	//.offset(); ? // offsetLeft
	//alert( "oPos.left="+ oPos.left + ", oPos.top="+ oPos.top);

	var $div = $('<div  class="mask-layer" style="z-index: 9999; border:medium none; top: ' + oPos.top + 'px; left: ' + oPos.left + 'px' + '; background-color: #eee; position: absolute; opacity: 0.8;"></div>');
	$div.css('height', height + 'px');
	$div.css('width', width + 'px');

	$(selector).append($div);
};

