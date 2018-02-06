
$(document).ready(function() {
  // main
  $('.js--res-dropdown').on('click', function () {
    $('.res-dropdown').show("fast")
    $(".main-container").mouseenter(function () {
      $('.res-dropdown').hide("fast");
    });
  })
  // mobile
  $('.js--focus-input').click(function() {
    if ($('.js--mobile-nav').hasClass('_opened')) {
      $('.js--mobile-nav').removeClass('_opened')
      $('.js--email-input').focus();
      $('html, body').animate({
        scrollTop: $(".js--email-input").offset().top
      }, 500);
    }
  })
  $('.js--open-menu').click(function() {
    if (!$('.js--mobile-nav').hasClass('_opened')) {
      $('.js--mobile-nav').addClass('_opened')
    }
  })
  $('.js--close-menu').click(function() {
    if ($('.js--mobile-nav').hasClass('_opened')) {
      $('.js--mobile-nav').removeClass('_opened')
    }
  })

  $('.js--open-mob-list').click(function() {
    if ($('.js--mob-list').hasClass('_opened')) {
      $('.js--mob-list').removeClass('_opened')
      $('.js--arrow-animate').removeClass('_animate')
    } else {
      $('.js--mob-list').addClass('_opened')
      $('.js--arrow-animate').addClass('_animate')
    }
  })
})
;
