HT.Homepage = function() {};

HT.Homepage.prototype.runSlideshow = function() {
  // clearInterval(slideshow);
  $('#baby-pictures-container > div:gt(0)').hide();
  HT.Globals.slideshow = setInterval(function(){
    $('#baby-pictures-container :first-child')
      .fadeOut(1000)
      .next('div')
      .fadeIn(1000)
      .end()
      .appendTo('#baby-pictures-container');
  }, 5000);
};

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

$(document).on("page:change", function() {
  clearInterval(HT.Globals.slideshow);
  var homepage = new HT.Homepage();
  homepage.runSlideshow();
});
