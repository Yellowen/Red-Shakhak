var page = 1;

function load_page(page_number) {
    var a = new Advertises();

    a.fetch({
	data: {page: page},
	success: function(data, res, opts){
	    console.log(">>>>>>>>>>>>>");
	    console.log(data);
	    var $container = $('#adbox');

	    data.each(function(x){
		console.log("<div class='box box1x1 employee'><div class='palette innerbox'>" + x.get("title") + " " + x.get("cost_per_day") + "</div></div>");
		console.log(x);

		//$container.masonry( 'addItems', "<div class='box box1x1 employee'><div class='palette innerbox'>" + x.title + " " + x.cost_per_day + "</div></div>");
	    });
	},
	error: function(){
	    console.log("failed");

	}
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
