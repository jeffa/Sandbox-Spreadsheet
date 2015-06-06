function load_table() {
    fetch_table();

    // enter key "submits" the form
    $(document).keydown(function(e) {
        switch(e.which) {
            case 13:
            fetch_results();
            default: return;
        }
        e.preventDefault();
    });
}

function fetch_table() {

    var params = $.param([
        {name: "data",  value: document.config.data.value},
        {name: "style", value: document.config.style.value},
    ]);

    var url  = '/' + '?' + params;

    //$('#myTab a[href="#' + page + '"]').tab('show');
    _ajaxGET( url, '#spreadsheet' );
}

function _ajaxGET( url, id, err ) {

    if (!err) {
        err = '<div class="alert alert-error">'
            + '<button type="button" class="close" data-dismiss="alert">&times;</button>'
            + '<strong>Error!</strong>'
            + ' Ajax call failed: ' 
            + url 
            + '</div>'
    }

    $.ajax( {
        url: url,
        type: 'GET',
        success: function( data, status, xhr ) {
            $( id ).html( xhr.responseText );
        },
        error: function( xhr, status, error ) {
            $( id ).html( err );
        }
    });
}
