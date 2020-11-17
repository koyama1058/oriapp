$(window).on('scroll', function (){
  let elem = $('#left_move');
  elem.each(function () {
    let elemOffset = $(this).offset().top;
    let scrollPos = $(window).scrollTop();
    let wh = $(window).height();
    if(scrollPos > elemOffset - wh + (wh / 2) ){
      $('#left_move').animate({
            'marginLeft': '200px'
          },1000);
    }
  });
});

$(window).on('scroll', function (){
  let elem = $('#right_move');
  elem.each(function () {
    let elemOffset = $(this).offset().top;
    let scrollPos = $(window).scrollTop();
    let wh = $(window).height();
    if(scrollPos > elemOffset - wh + (wh / 2) ){
      $('#right_move').animate({
            'marginRight': '200px'
          },1000);
    }
  });
});

// $(window).on('scroll', function (){
//   let elem = $('.card');
//   elem.each(function () {
//     let elemOffset = $(this).offset().top;
//     let scrollPos = $(window).scrollTop();
//     let wh = $(window).height();
//     if(scrollPos > elemOffset - wh + (wh / 2) ){
//       $('.card').animate({
//             'marginRight': '200px'
//           },1000);
//     }
//   });
// });

$(window).on('scroll', function (){
  let elem = $('.card');
  elem.each(function () {
    let elemOffset = $(this).offset().top;
    let scrollPos = $(window).scrollTop();
    let wh = $(window).height();
    if(scrollPos > elemOffset - wh + (wh / 2) ){
      $('.card').fadeIn(1000)
    }
  });
});