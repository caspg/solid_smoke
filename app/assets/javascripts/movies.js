$(document).ready ( function () {
// -------------------------------------------
// Search input validation - field can't be blank.
// -------------------------------------------
    $(document).on("click", "#search", function () {
    	var title = $("#title").val();
    	if (title.length == 0) {
    		$(".valid-alert").remove();
    		$(".form").append('<div class="valid-alert">Movie title has to be filled out.</div>');
    		return false
    	};
    });
// -------------------------------------------
// Sort movie index with ajax.
// -------------------------------------------
    $(".movie-index").on("click", ".sort-opt a", function() {
    	$.getScript(this.href);
    	return false;
    });
// -------------------------------------------
// Max length of plot input in new movie form.
// -------------------------------------------
    $(".new-movie-page #movie_plot").keyup(function() {
        var plot_input = $("#movie_plot").val().length;
        var max = 1200;
        if (plot_input >= max) {
            $("#plot-lenght").text("You've reached the limit.");
        } else if (plot_input == 0) {
            $("#plot-lenght").html("Min 50 and max 1200 characters.");
        } else {
            var char_left = max - plot_input;
            $("#plot-lenght").html("characters: " + plot_input + "/" + char_left);
        }; 
    });
// --------------------------------------------------------
// New movie form validation with
// --------------------------------------------------------
    $("#new_movie").validate({     
        rules: {
            "movie[plot]": {
                required: true,
                minlength: 50
            },
            "movie[title]": {
                required: true,
                minlength: 2    
            },
            "movie[year]": {
                required: true,
                minlength: 4    
            },
        },
        errorPlacement: function(error, element) {
            if(element.attr("name") == "movie[title]") {
                $(".title").prepend(error);                
            };
            if (element.attr("name") == "movie[year]") {
                $(".year").prepend(error);  
            };
            if (element.attr("name") == "movie[plot]") {
                $(".plot").append(error);  
            };
        }
    });
});

