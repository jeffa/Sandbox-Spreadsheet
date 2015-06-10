function fetch_table() {

    var params = $.param([
        {name: "data",      value: document.config.data.value},
        {name: "style",     value: document.config.style.value},

        {name: "matrix",    value: document.config.matrix.checked},
        {name: "tgroups",   value: document.config.tgroups.checked},
        {name: "headless",  value: document.config.headless.checked},
        {name: "flip",      value: document.config.flip.checked},
        {name: "pinhead",   value: document.config.pinhead.checked},

        {name: "theta",     value: document.config.theta.value},
        {name: "indent",    value: document.config.indent.value},
        {name: "encodes",   value: document.config.encodes.value},
        {name: "any",       value: document.config.any.value},
        {name: "caption",   value: document.config.caption.value},
    ]);

    var url  = '/table' + '?' + params;
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
