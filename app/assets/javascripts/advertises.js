$(function (){

    // Global Variables ---------------
    // We use these global variables to prevent jquery
    // to search dom each time

    // TODO: Is there any better way ?
    var es_cost = $("#es-cost");
    var es_cost_per_day = $("#es-cost-per-day");
    var es_credit = $("#es-credit");

    $(es_cost).find("h1").css("direction", "ltr");
    $(es_cost_per_day).find("h1").css("direction", "ltr");
    $(es_credit).find("h1").css("direction", "ltr");
    $("#credit").data("value", $("#credit").text());
    $("#credit").text(humanize(parseInt($("#credit").text())));

    // Functions -----------------------
    function humanize(val){
	return Humanize.intComma(val);
    }

    function check_range(element, value){
	var warn = parseInt($(element).data("warning"));
	var dang = parseInt($(element).data("danger"));

	if ((value <= warn) & (value > dang)) {

	    $(element).removeClass("box-noproblem")
		.removeClass("box-danger");

	    if (! $(element).hasClass("box-warning")) {
		$(element).addClass("box-warning");
	    }

	}

	else if (value <= dang) {
	    $(element).removeClass("box-noproblem")
		.removeClass("box-warning");

	    if (! $(element).hasClass("box-danger")) {
		$(element).addClass("box-danger");
	    }
	}
	else {
	    $(element).removeClass("box-warning")
		.removeClass("box-danger")
		.addClass("box-noproblem");

	}
    }
    function update_show_for_days(cost, sfd){
	var res;
	if (sfd == 0) {
	    res = 0;
	}
	else {
	    res = parseInt(cost/sfd);
	}

	$(es_cost_per_day).data("value", res);
	$(es_cost_per_day).find("h1").html(humanize(res));
	check_range(es_cost_per_day, res);
	return res;
    }

    function update_credit(cpd){
	var credit = parseInt($("#credit").data("value"));
	console.log(credit);
	credit = credit - cpd;
	$(es_credit).find("h1").html(humanize(credit));
	$(es_credit).data("value", credit);
	check_range(es_credit, credit);
    }

    function update_cost(cost) {
	$(es_cost).find("h1").html(humanize(cost));
	$(es_cost).data("value", cost);
	check_range(es_cost, cost);
    }


    $("#advertise_show_for_days").on("input", function(event){
	console.log("sfd changed");
	var value = $(this).val();
	var cost = $("#advertise_cost").val();
	// TODO: handle invalid type value
	var res = update_show_for_days(cost, value);
	update_credit(res);
	update_cost(cost);
    });
    $("#advertise_cost").on("input", function(event){
	console.log("cost changed");
	var value = $(this).val();
	var sfd = $("#advertise_show_for_days").val();
	// TODO: handle invalid type value
	var res = update_show_for_days(value, sfd);
	update_credit(res);
	update_cost(value);
    });
});
