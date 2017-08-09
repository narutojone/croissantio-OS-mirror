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

$('.js--res-dropdown').on('click', function() {
  $('.res-dropdown').toggle("fast")
})
;
