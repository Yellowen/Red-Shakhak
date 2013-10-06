var page = 1;

function load_page(page_number) {
    var advertises = new Advertises();
    $("#mainloading").fadeIn(300);
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
            fix_ad_info_position();
            fist_page_ads_tooltip();
            //api.set({"attr": "data-tip", "content.title": "<%= _('category') %>"});
            //api = $(document).find('.tag-icon').qtip('api');
            //api.set({"attr": "data-tip", "content.title": "<%= _('tag') %>"});
            $("#mainloading").fadeOut(300);
	},
	error: function(){
            console.log("Failed");
            // TODO: Show some flash here
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
    if ($("#adbox").length) {
	if (is_near_to_end()){
            load_page(page);
            page++;
            setTimeout("check_scroll_position()", 1000);

	}
	else {
            setTimeout("check_scroll_position()", 1000);
	}
    }
    else {
    }
}


$(check_scroll_position);
