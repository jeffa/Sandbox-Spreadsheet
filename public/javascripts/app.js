function load() { }

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
