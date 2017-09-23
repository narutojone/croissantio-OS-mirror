// <!-- Initialize Algolia -->
var client = algoliasearch("J97XEMUI7C", "ec96a3adcb4bf3ef61b276cc5a3790d7");
var index = client.initIndex('Resource');
window.index = index

// <!-- Submit form when selecting a new filter  -->
$("#search-form").on("submit", function() {
  val = $(".date-range").text()
  if (val == "All Time") {
    val = moment().subtract(20, 'years').format('MMMM D, YYYY') + " - " + moment().format('MMMM D, YYYY')
    $("#daterange").val(val)
  } else {
    $("#daterange").val(val)
  }
})

;
