//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function() {
	// called when whole home page is opend with order list(No ajax)

	fnOrderListInit();
	fnMsgArea();

	$("#quickview_dialog").overlay({
		top : 100,
		mask : {
			color : '#333',
			loadSpeed : 50,
			opacity : 0.6
		},
		closeOnClick : true,
		load : false
	});
	
	$("#communication_dialog").overlay({
		top : 100,
		mask : {
			color : '#333',
			loadSpeed : 100,
			opacity : 0.6
		},
		closeOnClick : true,
		load : false
	});
	
	$("#order_bid_dialog").overlay({
		top : 100,
		mask : {
			color : '#333',
			loadSpeed : 100,
			opacity : 0.6
		},
		closeOnClick : true,
		load : false
	});


	$("#order-preview-dialog").overlay({
		top : 100,
		mask : {
			color : '#333',
			loadSpeed : 100,
			opacity : 0.6
		},
		closeOnClick : true,
		load : false
	});

});

