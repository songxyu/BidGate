
$(document).ready(function(){

$('.addExtProp').bind('click', function(event) {
	// alert('a');
	// get current selected category
	var cate_id = 3;// $("input[type='radio', name='category']").val();
	if (!cate_id) {
	//	cate_id = $("input[type='radio', name='parent_category']").val();
	}

	alert(cate_id);

	$.ajax({
		url : '/props_by_category', //Note the my_controller and action here, i.e. change accordingly
		type : 'get',
		data : {
			'category_id' : cate_id
		}
	}).done(function(data) {
		alert(JSON.stringify(data));
	}).fail(function(jqXHR, textStatus) {
		alert("Request failed: " + textStatus);
	});
});

});