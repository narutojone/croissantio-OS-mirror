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
    $(".trumbowyg-editor, #editor2").on("input", function() {
      value = $(".trumbowyg-editor").html();
      $("#article_body").val(value);
    })
    $(".trumbowyg-editor").height(500)
  }

  // Load article in wysiwyg editor from database
  function loadArticle() {
    $(".trumbowyg-editor").html($("#article_body").val())
  }
