require.config({
    paths: {
        "app": "../app"
    }
});

require([
    'underscore',
    'jquery',
    'splunkjs/mvc',
    'splunkjs/mvc/tableview',
    'splunkjs/mvc/simplexml/ready!'
], function(_, $, mvc, TableView) {
    
    var healthRenderer = TableView.BaseCellRenderer.extend({
        canRender: function(cell) {
            return cell.field === 'range';
        },
        render: function($td, cell) {
            $("#tblHealth").removeClass("low").removeClass("severe").addClass(cell.value);
        }
    });
    
    mvc.Components.get('tblHealth').getVisualization(function(tableView){
        tableView.table.addCellRenderer(new healthRenderer());
        tableView.table.render();
    });
});