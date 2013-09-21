
$(function (){

    var es_cost = $("#es-cost");
    var es_cost_per_day = $("#es-cost-per-day");
    var es_credit = $("#es-credit");

    function humanize(val){
	// TODO: separate integer using ,
	return val;
    }

    function update_show_for_days(cost, sfd){
	var res;
	if (cost == 0) {
	    res = 0;
	}
	else {
	    res = parseInt(cost/sfd);
	}
	console.log(cost);
	console.log(sfd);
	console.log(res);

	$(es_cost_per_day).data("value", res);
	$(es_cost_per_day).find("h1").html(humanize(res));
    }

    $("#advertise_show_for_days").on("input", function(event){
	console.log("sfd changed");
	var value = $(this).val();
	var cost = $("#advertise_cost").val();
	// TODO: handle invalid type value
	update_show_for_days(cost, value);

    });
    $("#advertise_cost").on("input", function(event){
	console.log("cost changed");
	var value = $(this).val();
	var sfd = $("#advertise_show_for_days").val();
	// TODO: handle invalid type value
	update_show_for_days(value, sfd);$
    });
});
