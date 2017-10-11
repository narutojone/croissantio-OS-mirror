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

function openPopover() {
  console.log("The script has been loaded")
  $('.js--open-popover').click(function() {
    console.log("The button has been clicked")
    $('.js--home-popover').toggle()
  })
}
;
