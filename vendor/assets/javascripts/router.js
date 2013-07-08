var AppRouter = Backbone.Router.extend({
    routes: {
	//'some': 'someshit',
	'*actions': 'default_action'
    }
});

var router = new AppRouter();

/*router.on('route:', function(){
    require(['views/menu/list'], function(View){
	var view = new View();
	view.render();
    });

});*/

router.on('default_action', function(actions){
    console.log('No route:' +  actions);
});

Backbone.history.start();
