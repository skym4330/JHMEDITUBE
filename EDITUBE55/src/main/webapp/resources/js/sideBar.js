
$(document).ready( function() {

//  $('.side > a').click( function() {
////    $('.side').find('.current').removeClass('current');
//    $(this).addClass('current');    
//  });

  var x = $('.side').width();
  var margin = '50px 0 0 '+ x +'px';
  var width = $(window).width() - x;
  $('#main').css({
    margin: margin,
    width: width
  });
  
  $(window).resize(function() {
    var x = $('.side').width();
    var margin = '50px 0 0 '+ x +'px';
    var width = $(window).width() - x;
    $('#main').css({
      margin: margin,
      width: width
    });
  });  
});