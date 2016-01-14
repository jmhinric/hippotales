// responsive design
$(window).resize(function(){
  var width = $(window).width();
  if(width < 800){
    $('.Grid-cell').removeClass('u-size1of2');
    $('.Grid-cell').removeClass('u-size1of3');
    $('.Grid-cell').addClass('u-size1of1');
  } else {
    $('.Grid-cell').removeClass('u-size1of1');
    $('.subscribe-info').addClass('u-size1of2');
    $('.simple-step').addClass('u-size1of3');
    $('.quote').addClass('u-size1of2');
  }
})
.resize();