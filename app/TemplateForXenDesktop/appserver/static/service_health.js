require([
    'underscore',
    'jquery',
    'splunkjs/mvc',
    'splunkjs/mvc/tableview',
    'splunkjs/mvc/simplexml/ready!'
], function(_, $, mvc, TableView) {
    var CustomIconRenderer = TableView.BaseCellRenderer.extend({
        canRender: function(cell) {
            return cell.field === 'State';
        },
        render: function($td, cell) {
            var state = cell.value;
            
            var icon = state == "Running" ? 'check' : 'alert-circle';
            
            // Create the icon element and add it to the table cell
            $td.addClass('icon-inline').html(_.template('<%- text %> <i class="icon-<%-icon%>"></i>', {
                icon: icon,
                text: cell.value
            }));
        }
    });
    mvc.Components.get('tblHealth').getVisualization(function(tableView){
        // Register custom cell renderer
        tableView.table.addCellRenderer(new CustomIconRenderer());
        // Force the table to re-render
        tableView.table.render();
    });
});