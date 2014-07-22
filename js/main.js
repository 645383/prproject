$(document).ready(function() {
	$('#what-growth').noUiSlider({
		start: 150,
		connect: "lower",
		range: {
		  'min': 100,
		  'max': 250
		}
	});
	$('.noUi-handle.noUi-handle-lower').html("<div>sfsdf</div>");
});