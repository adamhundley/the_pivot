$(window).scroll(function(e){
  var $el = $('.map-container');
  var isPositionFixed = ($el.css('position') == 'fixed');
  if ($(this).scrollTop() > 375 && !isPositionFixed){
    $('.map-container').css({'position': 'fixed', 'top': '60px'});
  }
  if ($(this).scrollTop() < 375 && isPositionFixed)
  {
    $('.map-container').css({'position': 'static', 'top': '0px'});
  }
});
