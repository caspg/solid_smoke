$(document).ready ( function () {
    $(document).on("click", "#search", function () {
    	var title = $('#title').val();
    	if (title.length == 0) {
    		$('.valid-alert').remove();
    		$('.form').append('<div class="valid-alert">Movie title has to be filled out.</div>');
    		return false
    	};
    });
    $(".movie-index").on("click", ".sort-opt a", function() {
    	$.getScript(this.href);
    	return false;
    });
});
