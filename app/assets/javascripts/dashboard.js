/**
    common js functions for dashboard pages
 */


function fnGenerateBidProgressBarForEveryDashboardOrder($dashboard_rightarea){
	console.log('fnGenerateBidProgressBarForEveryDashboardOrder()... ');
	if(!$dashboard_rightarea){
		console.error('$dashboard_rightarea is null!');
		return ;	
	}
	
    var $arr_bid_progressbar = $dashboard_rightarea.find(".bid_progressbar");
    $.each($arr_bid_progressbar, function(index, elem) {
        var prog_val = parseInt($(elem).data("progressval"));
        var bid_status = parseInt($(elem).data("status"));

        if (bid_status == 1 || bid_status == 0) {
            $(elem).css("height", "10px");
            $(elem).find(".ui-widget-header").css("height", "10px");
        }

        $(elem).progressbar({
            value : prog_val
        });
    });
}


// common function to refresh corresponding orders list when click the tab header
// e.g. fnRefreshListWhenClickTab('#tab-my-purchase-forpaid-orders', '/dashboard/dashboard_purchases_forpaid');
function fnBindEventToRefreshListWhenClickTab(tab_id, datalist_url){
    var $tabForpaidOrders = $('.right-area .tab-items '+tab_id);
    $tabForpaidOrders.unbind('click');
    $tabForpaidOrders.bind('click', function (e) {
        e.preventDefault();
		console.log('refresh order list for tab id= ', tab_id);
		
        $.ajax({
            url : datalist_url,
            type : 'get',
            //dataType: 'json', // must use html, as response is: js and html src in approve_bid.js.erb
            data : { }
        }).done(function(data) {
            //$(this).tab('show');// not needed
        });
    });
};



// common function to jump to the specified tab
// tabId: e.g. tab-my-purchase-forpaid-orders
function fnJumpToTabInDashboard(tabId){	
	if( tabId && tabId != ''){
		console.log('fnJumpToTabInDashboard(): tabId= ', tabId);
		var $tabItems = $('.right-area .tab-items');
		var $targetTab = $tabItems.find('#'+tabId);
		$targetTab.tab('show').trigger('click');
	}	
}



//**** left wrapper ********//
$(document).ready(function(){
		var $leftWrapperMenu = $(".left-wrapper .side-menu li");
		$leftWrapperMenu.on('click', function(e){
		$leftWrapperMenu.removeClass('active');
		$(this).addClass('active');
	});
	
});
