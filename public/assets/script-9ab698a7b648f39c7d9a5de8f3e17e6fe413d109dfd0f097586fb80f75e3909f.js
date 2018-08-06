(function($) {
    $(function() {
        // Focus state for append/prepend inputs
        $('.input-prepend, .input-append').on('focus', 'input', function() {
            $(this).closest('.control-group, form').addClass('focus');
        }).on('blur', 'input', function() {
            $(this).closest('.control-group, form').removeClass('focus');
        });
    });
    $(window).load(function() {
        $('html').addClass('loaded');
        $(window).resize().scroll();
    });
})(jQuery);

  // Switching between index view & create/edit view
  function createForm() {
    $(".table-fade").slideUp()
    $(".create-form").fadeIn()
  }

  function closeForm() {
    $(".create-form").slideUp()
    $(".table-fade").slideDown()
  }

  // Update hidden field
  function getText() {
    $(".trumbowyg-editor, #editor2").on("input DOMSubtreeModified click", function() {
      value = $(".trumbowyg-editor").html();
      $("#article_body").val(value);
    })
    $(".trumbowyg-editor").height(500)
  }


  // Load article in wysiwyg editor from database
  function loadArticle() {
    $(".trumbowyg-editor").html($("#article_body").val())
  }

function toggleMenu(){
  $('a.hamburger-toggle').on("click", function(){
    console.log("click")
    var candidate     = $(this),
    data          = candidate.attr('data-toggle-class'),
    dataArray     = [],
    toggleClass   = '',
    toggleElement = '';
    dataArray = data.split(";");

    if(dataArray.length === 2){
      toggleElement = dataArray[0];
      toggleClass   = dataArray[1];
      candidate.toggleClass('toggled-class');
      $(toggleElement).toggleClass(toggleClass);
      };
  });
}

function populateDots() {
  var x = 0;
  var y = 0;
  for (var i = 0; i < 16; i++) {
    $('.js--dots').append("<span style='top:" + x + "px' data-aos='zoom-in' class='hero-draft__dot'></span>")
    x+=13
  }
  for (var i = 0; i < 17; i++) {
    $('.js--more-dots').append("<span style='top:" + y + "px' data-aos='zoom-in' class='hero-draft__dot'></span>")
    y+=17
  }
}

function trackFieldChanges() {
  var originalValue = $("#article_body").val();
  var changedValue = $("#article_body").val();
  $(".trumbowyg-editor").on('DOMSubtreeModified', function() {
    changedValue = $(".trumbowyg-editor").html();
  });
  $('.js--check-field').on('click', function() {
    if (originalValue == changedValue) {
      return true 
    } else {
      var bool = confirm('Your changes will not be saved - proceed?');
      if (bool == true) {
        return true
      } else {
        return false
      }
    }
  })
}

function toggleBoxes() {
  $('.js--option').on('click', function() {
    var target = $(this).data("target")
    $('.js--symbol').html("+")
    $(this).children('.js--symbol').html("&minus;")
    $(".js--content").removeClass('active')
    $("div").find(`[data-id='${target}']`).addClass('active')
  })
}

function selectOption() {
  $('.js--select').on('click', function() {
    $('.js--tools').removeClass("_active")
    $('.js--select').removeClass("_active")
    $('.js--line-to-select').attr('class','hero-draft__selected-line js--line-to-select');
    $(this).addClass("_active")
    var classToAdd = $(this).data("id")
    $('.js--line-to-select').addClass("_" + classToAdd)
    $('.js--tools-' + classToAdd).addClass("_active")
  })
}

function changeBtn() {
  $(window).scroll(function() {
    if ($(window).scrollTop() >= $(".js--change-point").offset().top + 60) {
      $(".js--activate-input").addClass("_color_blue")
    } else {
      $(".js--activate-input").removeClass("_color_blue")
    }
  })
}

function setInputFocus() {
  $('.js--activate-input').on('click', function() {
    $('.js--email-input').focus();
    $('html, body').animate({
      scrollTop: $(".js--email-input").offset().top - 200
    }, 500);
  })
}


function fixHeader() {
  $(window).scroll(function(){
    if ($(window).scrollTop() >= 10) {
       $('.js--fix-header').addClass('_fixed');
    }
    else {
      $('.js--fix-header').removeClass('_fixed');
    }
});
}

function showMessage() {
  $('#ck_subscribe_form').submit(function(event) {
    setTimeout(function() {$('.form__success').show()}, 1300)
  })
}

function submitMessageForm() {
  $('.js--open-modal').on('click', function() {
    if ($('#send-message-input').val()) {
      $('.modal-body').text($('#send-message-input').val())
      $('.js--send-message').on('click', function() {
        $('#send-message-form').trigger('submit')
        $('#verificationModal').modal('hide');
      })
    } else {
      alert('Fill in the form')
      return false
    }
  })
}
;
