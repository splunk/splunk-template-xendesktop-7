require(['jquery'], function($){
    $(function() {
		// When the DOM is ready, move the modal buttons where we want them to be displayed
                
		$("#chartProcQueueLen .panel-head").find("h3").after($("#btnProcQueueLenDesc"));
		$("#chartPctProcTime .panel-head").find("h3").after($("#btnPctProcTimeDesc"));
	});
});