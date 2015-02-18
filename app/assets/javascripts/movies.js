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
// Display number of characters of plot's input
// -------------------------------------------
    // Test if #movie_plot element exists
    if ($("#movie_plot").length) {
        var plot_input = $("#movie_plot").val().length;
        if ( plot_input == 0) {
            $("#plot-lenght").text("You've reached the limit.");
        } else  {
            var max = 1200;
            var char_left = max - plot_input;
            $("#plot-lenght").html("characters: " + plot_input + "/" + max);
        };
    };
    $(".new-movie-page #movie_plot").keyup(function() {
        var plot_input = $("#movie_plot").val().length;
        var max = 1200;
        if (plot_input >= max) {
            $("#plot-lenght").text("You've reached the limit.");
        } else if (plot_input == 0) {
            $("#plot-lenght").html("Min 50 and max 1200 characters.");
        } else {
            var char_left = max - plot_input;
            $("#plot-lenght").html("characters: " + plot_input + "/" + max);
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
// --------------------------------------------------------
// Hide downvoted review
// --------------------------------------------------------
    $(".downvoted .rev-title td").prepend("<h5><em>This review was downvoted. Click if you want display it.</em></h5>");
    $(document).on("click", ".downvoted", function() {
        $(".downvoted .rev-content .content").toggle("slow");
        $(".downvoted .rev-title h4").toggle("slow");
        $(".downvoted .rev-title h5").toggle("slow");
    });
// --------------------------------------------------------
// Toggle new comment's form
// --------------------------------------------------------
    $(".review").on("click", ".toggle-new-comment", function() {
        $(this).closest(".review").next(".comments").children(".new-comment").toggle();
    });
// --------------------------------------------------------
// Hide/show comments except - last is always visible
// --------------------------------------------------------
    $(".comments").on("click", ".toggle-comments a", function() {
        $(this).parent().siblings(".comment:not(:last-of-type)").slideToggle();
        // change link text from 'show comments' to 'hide comments'
        $(this).children("span").toggle();
        $(this).find(".caret-reversed").css("display", "inline-block")
    });
// --------------------------------------------------------
// Ratings - jQuery Raty
// --------------------------------------------------------
    $.fn.raty.defaults.path = '/images/';
    $('#raty-stars').raty({
        scoreName: 'movie_rating[score]',
        score: function() {
            return $(this).attr('data-score');
        }
    });
    $('#raty-stars').on('click', 'img', function() {
        $('form#new_movie_rating').submit();
        $('form.edit_movie_rating').submit();
    });
    $('#raty-stars-guest').raty({
        click: function() {
            alert('You need to login before vote.')
            return false
        }
    });
});
