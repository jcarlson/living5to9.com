//= require shadowbox

$("#details").hide();
$(".photo .image")
        .mouseenter(function() {$("#details").fadeIn(250);})
        .mouseleave(function() {$("#details").fadeOut(250);}
);

$(Shadowbox.init);