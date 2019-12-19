$(document).ready(function() {
  $(".top-left").animate({top: "+=120px"}, "slow")
  $(".bottom-left").animate({bottom: "+=120px"}, "slow")
  $(".top-right").animate({top: "+=120px"}, "slow")
  $(".bottom-right").animate({bottom: "120px"}, "slow")
  $(".top-left").animate({left: "+=400px"}, "slow")
  $(".bottom-left").animate({left: "+=400px"}, "slow")
  $(".top-right").animate({right: "+=400px"}, "slow")
  $(".bottom-right").animate({right: "+=400px"}, "slow")

  $(window).scroll(function(){
    $('#header').addClass('fixed-header');
  });
});


window.sr= ScrollReveal();
/*sr.reveal('.navbar', {
  duration: 2000,
  origin: 'bottom',
});*/
sr.reveal('.showcase-left', {
  duration: 2000,
  origin: 'left',
  distance: '300px'
});

sr.reveal('.showcase-bottom', {
  duration: 2000,
  origin: 'bottom',
  distance: '300px'
});

sr.reveal('.showcase-top', {
  duration: 2000,
  origin: 'top',
  distance: '300px'
});

sr.reveal('.showcase-right', {
  duration: 2000,
  origin: 'right',
  distance: '300px'
});

sr.reveal('.showcase-btn', {
  duration: 2000,
  delay: 2000,
  origin: 'right',
  distance: '300px'
});

sr.reveal('.order-are', {
  duration: 2000,
  origin: 'top',
});

sr.reveal('.info-left', {
  duration: 2000,
  origin: 'bottom'
});

sr.reveal('.info-right', {
  duration: 2000,
  origin: 'bottom',
  distance: '300px'
});

sr.reveal('.info-right a', {
  duration: 2000,
  origin: 'bottom',
  delay: 1000,
  distance: '300px'
});

sr.reveal('.info2-left', {
  duration: 2000,
  origin: 'left',
  distance: '300px'
});

sr.reveal('.info2-right', {
  duration: 2000,
  origin: 'right',
  distance: '300px'
});

