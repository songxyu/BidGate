var fnOrderListInit = function() {

	$('.orders_container').shapeshift();

	var $arr_bid_progressbar = $(".bid_progressbar");
	$.each($arr_bid_progressbar, function(index, elem) {
		var prog_val = parseInt($(elem).data("progressval"));
			
		if (prog_val<100){
			$(elem).css("height", "10px");
			$(elem).find(".ui-widget-header").css("height", "10px");
		}else{			
			var $label = $(elem).next(".progress_label");			
			$label.find("span").text("成功竞拍!");
			$label.find("img").css("display","inline");
			$label.css("height", "25px").css("position", "relative").css("top", "-25px");
		}
		
		$(elem).progressbar({
			value : prog_val
		});
	});

};


var fnMsgArea = function(){
	$(".msg_area").click(function(){
		$(this).remove();
	});

};
