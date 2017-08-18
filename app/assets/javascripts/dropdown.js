$('.js--res-dropdown').on('click', function() {
  $('.res-dropdown').show("fast")
  $(".main-container").mouseenter(function() {      
    $('.res-dropdown').hide("fast");
});
})