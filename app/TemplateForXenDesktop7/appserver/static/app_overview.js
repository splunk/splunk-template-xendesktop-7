require.config({
    paths: {
        "app": "../app"
    }
});

require(['jquery'], function($){
	$(function() {
            
            $("#appNote").prependTo($("#chartApps .panel-body")).find("h3").hide();
            
	});
});