require.config({
    paths: {
        "app": "../app"
    }
});
require([
    'jquery',
    'splunkjs/mvc',
    'splunkjs/mvc/simplexml/ready!'
], function($, mvc){
    
    $("#health").on("click", ".single-value", function(event) {
        location.href="/app/SplunkAppForXD/service_health";
    } );
    
});

require(['jquery'], function($){
	$(function() {
            
            // Hide the parent row (this is only needed once)
            $("#appNote").closest(".dashboard-row").hide();
            
	    //$('#chartApps').find("h3").after('<div class="info"> Note: test</div>');
            $("#appNote").prependTo($("#chartApps .panel-body")).find("h3").hide();
            

	});
});