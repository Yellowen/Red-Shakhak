function fix_ad_info_position(){

    // Set proper place for ad-info
    $(".box").find(".ad-info").css("padding-top", function(){

        var h = $(this).parent().parent().height();
        // bannerheight 1 is for 1x1 2x1 and 3x1 boxes
        var bannerheight = 1;
        if (h > document.baseunit) {
            bannerheight = 2;
        }
        return h / (3 * bannerheight);
    });
}

function fist_page_ads_tooltip(){
    // Grab all elements with a non-blank data-tooltip attr.
    var tooltip = $(document).find('[data-tip!=""]').qtip({
        content: {
            attr: 'data-tip',
            title: function(event, api) {
                // Retrieve content from data-title attribute of the toolbar elem
                return $(this).data('title');
            }
        },
        position: {
            my: 'bottom center',
            at: 'top center',
            viewport: $(window)
        },
        style: {
            classes: 'qtip-tipsy',
            tip: {
                corner: "bottom center"
            }
        }
    });

}

function setup_global_tooltip() {
    // Grab all elements with a non-blank data-tooltip attr.
    $('[data-texttip!=""]').qtip({
        content: {
            attr: 'data-texttip'
        },
        position: {
            my: "top center",
            at: "bottom center",
            viewport: $(window)
        },
        style: {
            classes: 'qtip-tipsy'
        }
    });

}

function show_loading_sign(){
    $("#mainloading").fadeIn(300);
}

function hide_loading_sign(){
    $("#mainloading").fadeOut(300);
}
