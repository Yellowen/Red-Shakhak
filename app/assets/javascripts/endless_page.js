var page = 1;

function load_page(page_number) {
    var advertises = new Advertises();

    advertises.fetch({
	data: {page: page},
	success: function(data, res, opts){
	    var $container = $('#adbox');
	    var elems = [];
	    var fragment = document.createDocumentFragment();

	    data.each(function(x){
 		var template = $(_.template($("#boxtemplate").html(), {ad: x}));
		elems.push($(template).get(0));
		$container.append(template).masonry("appended", template);

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
	setTimeout("check_scroll_position()", 1000);

    }
    else {
	setTimeout("check_scroll_position()", 1000);
    }
}


$(check_scroll_position);
