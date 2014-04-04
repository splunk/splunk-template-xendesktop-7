require(['jquery'], function($){
    $(function() {
		// When the DOM is ready, move the modal buttons where we want them to be displayed
                
		$("#chartPctDiskTime .panel-head").find("h3").after($("#btnPctDiskTimeDesc"));
		$("#chartDiskQueueLen .panel-head").find("h3").after($("#btnDiskQueueLenDesc"));
	});
});