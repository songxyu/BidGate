//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready(function(){	
	// called when whole home page is opend with order list(No ajax)
    
	fnOrderListInit();
	fnMsgArea();
	
  	$('#testbtn').click(function(){
  		
  		$("#dialog_area").overlay({
		 top: 260,
		mask: {
         color: '#ebecff',
         loadSpeed: 200,
         opacity: 0.9
      	}, 
      	closeOnClick: true,
      	load: true
	});
  	});
  	
});

  
