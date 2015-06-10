$(function(){

    $('#control').knobKnob({
        snap : 0,
        value: 0,
        turn : function(ratio){
            document.config.theta.value = parseInt( 360 * ratio / 90 ) * 90;
            fetch_table();
        }
    });

});
