(function($) {
    $.fn.wizard = function(options) {
        options = $.extend({
            submitButton: "",
        }, options);

        var element = $(this).find("form");

        var steps = $(element).find("fieldset");
        var count = steps.size();
        var submit_button = $(element).find("input[type=submit]");
	var nextName = $(this).data("next");
	var prevName = $(this).data("prev");
	var btnclass = $(this).data("btnclass");
	var stepsname = $(this).data("steps-name");
	var disableclass = $(this).data("disabledclass") || "disabled";
	var wizardbuttons = $("#wizardbuttons");
	var current_step = 1;

	var self = this;

        $(submit_button).addClass(disableclass);


        $(element).before("<ul id='steps' class='steps row'></ul>");

	steps.each(function(i){
            var name = $(this).find("legend").html();
            $("#steps").append("<li id='stepDesc" + i + "' class='stepdesc'><span class='step-title'>" + stepsname + " " + (i + 1) + "</span><span>" + name + "</span></li>");

	});

        steps.each(function(i) {
	    var stepsheight = $("#steps").height().toString();
	    var parentwidth = element.parent().width();
	    var pl = element.parent().css("padding-left");
	    var pr = element.parent().css("padding-right");

            $(this).wrap("<div id='step" + i + "' class='stepdiv' style='width: " + (parentwidth - parseInt(pl)).toString() + "px; top: " + stepsheight + "px; right: " + pr + "px;'></div>");

	    $("#step" + i).hide();

        });

	if (wizardbuttons.length < 1) {
	    $(element).append("<div id='wizardbuttons'></div>");
	    wizardbuttons = $("#wizardbuttons");
	}

	if ($(this).data("step") === undefined) {
	    $(this).data("step", current_step);
	    $("#step0").show();

	}
	else {
	    current_step = $(this).data("step");
	    $("#step" + (current_step -1).toString()).show();
	}

	// Setup wizard buttons section
	set_padding();
	wizardbuttons.prepend("<div id='prevbtn' class='stepbutton prev " + btnclass +"'>" + prevName + "</div>");
	wizardbuttons.append("<div id='nextbtn' class='stepbutton next " + btnclass +"'>" + nextName + "</div>");
	move_buttons(wizardbuttons);
	update_buttons_status();

	$("#prevbtn").on("click", function(){
	    if (current_step > 1) {
		$(self).data("step", current_step - 1);
		$("#step" + (current_step - 1)).hide();
		$("#step" + (current_step - 2)).show();
		current_step = current_step - 1;
		move_buttons(wizardbuttons);
		update_buttons_status();
	    }
	});

	$("#nextbtn").on("click", function(){
	    if (current_step < count) {
		$(self).data("step", current_step + 1);
		$("#step" + (current_step - 1)).hide();
		$("#step" + (current_step)).show();
		current_step = current_step + 1;
		move_buttons(wizardbuttons);
		update_buttons_status();
	    }
	});

	function update_buttons_status() {
	    if (current_step == 1) {
		submit_button.addClass(disableclass);
		submit_button.attr('disabled', true);
		$("#prevbtn").addClass(disableclass);
		$("#nextbtn").removeClass(disableclass);
	    } else if (current_step == count) {
		submit_button.removeClass(disableclass);
		submit_button.attr('disabled', false);
		$("#prevbtn").removeClass(disableclass);
		$("#nextbtn").addClass(disableclass);
	    } else {
		submit_button.addClass(disableclass);
		submit_button.attr('disabled', true);
		$("#prevbtn").removeClass(disableclass);
		$("#nextbtn").removeClass(disableclass);
	    }

	}
	function move_buttons(i) {
	    var height = $("#step" + (current_step -1).toString()).height();
	    var top = parseInt($("#steps").height());
	    var margin = height - top + 20;

	    i.css("margin-top", margin);
	}

	function set_padding(){
	    var pr = $("#steps").parent().css("padding-right");
	    var pl = $("#steps").parent().css("padding-left");
	    wizardbuttons.css("padding-right", pr);
	}

    }
})(jQuery);
