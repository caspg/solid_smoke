$(document).ready ( function () {
// --------------------------------------------------------
// New movie form
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
// New review form
// --------------------------------------------------------
    $('#new_review').validate({
        rules: {
            'review[title]': {
                required: true  
            },
            'review[content]': {
                required: true,
                minlength: 10
            }
        },
        errorPlacement: function(error, element) {
            if(element.attr("name") == "review[title]") {
                $(".title div").prepend(error);                
            };
            if (element.attr("name") == "review[content]") {
                $(".content div").prepend(error);  
            };
        }
    });
});
