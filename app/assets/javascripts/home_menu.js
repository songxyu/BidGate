$(document).ready(function() {

	var $home_menu = $(".home-nav-menu");
	if($home_menu.length>0){
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
	}

}); 


// common js for header menu


// common function to ajax navigation
function fnNavigateFromHeaderDropdown(naviFrom, naviToUrl){
    var $naviFromDropdown = $('.my-profile-link .ui-nav-dropdown-item' + naviFrom );
    $naviFromDropdown.unbind('click');
    $naviFromDropdown.bind('click', function (e) {
        e.preventDefault();

        $.ajax({
            url : naviToUrl,
            type : 'get',
            //dataType: 'json', // must use html, as response is: js and html src in approve_bid.js.erb
            data : { }
        }).done(function(data) {
            //$(this).tab('show');// not needed
        });
    });
};

fnNavigateFromHeaderDropdown('.dash-gen', 'dashboard/dashboard?breadcrumb_path_key=homepage%2Cdashboard');
