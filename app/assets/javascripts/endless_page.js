var page = 1;

function load_page(page_number) {
    $.ajax({url: "/", type: "GET", data: {page: page_number}, dataType: "json"})
	.fail(function(){
	    console.log("Fetch failed");
	})
	.done(function(data){
	    console.log("Successful fetch");

	    _.each(data, function(ad){


	    });
	})
	.always(function(){
	});
}

function is_near_to_end() {
    return distance_to_bottom() < 200;
}

function distance_to_bottom(argument) {
    return page_height() - (window.pageYOffset + self.innerHeight);
}


function page_height() {
    return Math.max(document.body.scrollHeight, document.body.offsetHeight);
}

function check_scroll_position (){

    if (is_near_to_end()){
	load_page(page);
	page++;
    }
    else {
	setTimeout("check_scroll_position()", 1000);
    }
}


//$(check_scroll_position);
