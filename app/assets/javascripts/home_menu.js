$(document).ready(function() {

	var $home_menu = $(".home-nav-menu");
	
	$home_menu.jMenu({
		openClick: false,
		ulWidth: 'auto',
		TimeBeforeOpening: 100,
		TimeBeforeClosing: 11,
		animateText: false,
		paddingText: 1,
		effects: {
			effectSpeedOpen: 150,
			effectSpeedClose: 150,
			effectTypeOpen: 'slide',
			effectTypeClose: 'slide',
			effectOpen: 'swing',
			effectClose: 'swing'
		}
		
	});
	


}); 