//= require lib/masonry.pkgd
//= require lib/documentcloud/underscore
//= require lib/documentcloud/backbone-min
//= require router
//= require models

_.templateSettings = {
    interpolate: /\{\{\=(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g
};

$(function(){
    var $container = $('#adbox');

    $container.masonry({
	columnWidth: 150,
	gutter: 2,
	isOriginLeft: false,
	itemSelector: '.box'
    });

    $("#filterbtn").on("click", function(event){
        event.preventDefault();
        $("#filter").slideToggle(300);

        if ($(this).hasClass("active")) {
            $(".top-nav a").removeClass("active");
        }
        else {
            $(this).addClass("active");
        }
    });
});
