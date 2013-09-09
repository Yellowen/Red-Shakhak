(function($) {
    $.fn.wizard = function(options) {
        options = $.extend({
            submitButton: "",
        }, options);

        var element = $(this).find("form");

        var steps = $(element).find("fieldset");
        var count = steps.size();
        var submmitButtonName = "#" + options.submitButton;
	var nextName = $(this).data("next");
	var prevName = $(this).data("prev");
	var btnclass = $(this).data("btnclass");
	var stepsname = $(this).data("steps-name");

        $(submmitButtonName).hide();


        $(element).before("<ul id='steps' class='steps row'></ul>");

        steps.each(function(i) {
            $(this).wrap("<div id='step" + i + "' class='step'></div>");
            $(this).append("<p id='step" + i + "commands'></p>");


            var name = $(this).find("legend").html();
            $("#steps").append("<li id='stepDesc" + i + "' class='stepdesc'><span class='step-title'>" + stepsname + " " + (i + 1) + "</span><span>" + name + "</span></li>");

            if (i == 0) {
                createNextButton(i);
                selectStep(i);
            }
            else if (i == count - 1) {
                $("#step" + i).hide();
                createPrevButton(i);
            }
            else {
                $("#step" + i).hide();
                createPrevButton(i);
                createNextButton(i);
            }
        });

        function createPrevButton(i) {
            var stepName = "step" + i;
            $("#" + stepName + "commands").append("<div id='" + stepName + "Prev' class='stepbutton prev " + btnclass +"'>" + prevName + "</div>");

            $("#" + stepName + "Prev").bind("click", function(e) {
                $("#" + stepName).hide();
                $("#step" + (i - 1)).show();
                $(submmitButtonName).hide();
                selectStep(i - 1);
            });
        }

        function createNextButton(i) {
            var stepName = "step" + i;
            $("#" + stepName + "commands").append("<div id='" + stepName + "Next' class='step button next " + btnclass +"'>" + nextName + "</div>");

            $("#" + stepName + "Next").bind("click", function(e) {
                $("#" + stepName).hide();
                $("#step" + (i + 1)).show();
                if (i + 2 == count)
                    $(submmitButtonName).show();
                selectStep(i + 1);
            });
        }

        function selectStep(i) {
            $("#steps li").removeClass("current");
            $("#stepDesc" + i).addClass("current");
        }

    }
})(jQuery);
