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


var fnRemoveMaskDiv = function(selector){
	$(selector).find(".mask-layer").remove(); 
};

var fnMaskDiv = function(selector, newHeight){
  if( !$(selector)[0] )
  	return;
  	
  	fnRemoveMaskDiv(selector);
  
  var height = newHeight  || $(selector).height() + 50; // 20 for hack
  var width =  $(selector).width();
  if(parseInt(height)<=0 || parseInt(width)<=0) {
    return;
  }
  
  var oPos = $(selector).position(); //.offset(); ? // offsetLeft
  //alert( "oPos.left="+ oPos.left + ", oPos.top="+ oPos.top);
  
  var $div = $('<div  class="mask-layer" style="z-index: 9999; border:medium none; top: '+ oPos.top +'px; left: '+ oPos.left +'px' +'; background-color: #eee; position: absolute; opacity: 0.8;"></div>');
  $div.css('height', height + 'px');
  $div.css('width', width+'px'); 

  $(selector).append($div); 
};


