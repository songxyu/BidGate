//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function() {
	// called when whole home page is opend with order list(No ajax)

	fnOrderListInit();
	fnMsgArea();

	$('#testbtn').click(function() {

		$("#dialog_area").overlay({
			top : 260,
			mask : {
				color : '#ebecff',
				loadSpeed : 200,
				opacity : 0.9
			},
			closeOnClick : true,
			load : true
		});
	});

	$("#quickview_dialog").overlay({
		top : 100,
		mask : {
			color : '#333',
			loadSpeed : 200,
			opacity : 0.6
		},
		closeOnClick : true,
		load : false
	});

	$(".quickViewButton").on('click', function() {
		$("#quickview_dialog").overlay().load();
	});

	/*
	 $(".home_slides").slidesjs({
	 width: 1200,
	 height: 420,
	 play: {
	 active: false,
	 interval: 8000,
	 effect: "fade",
	 auto: true,
	 swap: false,
	 restartDelay: 2500
	 },
	 navigation: {
	 active: false
	 },
	 pagination: {
	 active: false
	 }
	 });*/

	/*
	 $(".home_slides").responsiveSlides({
	 auto: true,
	 speed: 800,
	 fade: true,
	 timeOut: 4000,
	 nav: true,
	 maxWidth: 1200

	 });*/

});

