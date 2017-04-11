// <!-- Initialize Algolia -->
var client = algoliasearch("J97XEMUI7C", "ec96a3adcb4bf3ef61b276cc5a3790d7");
var index = client.initIndex('Resource');
window.index = index
$('#aa-search-input').autocomplete({
  hint: true
}, [{
  source: $.fn.autocomplete.sources.hits(index, {
    hitsPerPage: 10
  }),
  //value to be displayed in input control after user's suggestion selection
  displayKey: 'title',
  //hash of templates used when rendering dataset
  templates: {
    //'suggestion' templating function used to render a single suggestion
    suggestion: function(suggestion) {
      // console.log(suggestion)
      title = (suggestion.title)
      if (grade != null && title != null) {
        return '<span>' + title + '</span>';
      } else {
        return '<span> Nothing found </span>';
      }
    }
  }
}]);

// <!-- Submit form when selecting a new filter  -->
$(".manual-filter").on("change", function() {
  val = $(".date-range").text()
  if (val == "All Time") {
    val = moment().subtract(20, 'years').format('MMMM D, YYYY') + " - " + moment().format('MMMM D, YYYY')
    $("#daterange").val(val)
  } else {
    $("#daterange").val(val)
  }
  $("#search-form").submit()
})

// <!-- Submit form when selecting a new daterange + add the value to a hidden form -->
window.onload = function() {
  $(".date-range").on("DOMSubtreeModified", function() {
    val = $(".date-range").text()
    $("#daterange").val(val)
    $("#search-form").submit()
  })
}

// <!-- Append suggestions to article list as typing happens -->
$("#aa-search-input").on("input", function() {
  $("#article-list").empty()
  if ($("#aa-search-input").val() == "") {
    $(".category-search").show()
  } else {
    $(".category-search").hide()
  }
  index.search($('#aa-search-input').val(), function(err, content) {
    array = content.hits.slice(0, 10)
    addResourcesToList(array, true)
  });
})

// <!-- Some weird stuff that was showing up on page load that shouldn't be there. It's display: hidden but it should pop up when clicked, so that's why I place this here. -->
$("#reportrange").on("click", function() {
  $(".ranges").show()
  $(".daterangepicker.dropdown-menu.ltr.opensleft").show()
})

// <!-- Duh -->
function capitalizeFirstLetter(string) {
  return string.charAt(0).toUpperCase() + string.slice(1);
}

function addResourcesToList(array, live = false){
  for (var i = 0; i < array.length; i++) {
    title = array[i].title
    grade = array[i].grade
    description = array[i].description
    date = array[i].date
    resource_type = array[i].resource_type
    slug = array[i].slug
    link = array[i].link
    author = array[i].author
    categories = array[i].category_name
    var html = "";
    html += "<div class=\"masonry__item resource_card\">";
    html += "							<h4 class=\"resource-title\">";
    html += "							<a href=\"" + link + "?utm_campaign=TGBSearch&utm_medium=referral&utm_source=GrowthBakery.com" + "\">" + title + "<\/a>";
    html += "					<\/h4>";
    html += "							<span>";
    html += "								<strong>" + moment(date).format('MMMM Do YYYY') + "";
    html += "									|";
    html += "									" + author + "";
    html += "									|";
    html += "									" + capitalizeFirstLetter(resource_type) + "";
    html += "									|";
    html += "									" + grade + "";
    html += "									stars";
    html += "									|";
    html += "									" + categories + "";
    html += "								<\/strong>";
    html += "							<\/span>";
    html += "							<div>";
    html += "								<p class=\"resource-description\">";
    html += "									" + description + "";
    html += "								<\/p>";
    html += "							<\/div>";
    html += "						<\/div>";
    $("#article-list").append(html)
  }

  if ($("#aa-search-input").val() == "" && live == true) {
    $("#article-list").empty()
  }
}

$(".category-link").on("click", function(e) {
  e.preventDefault()
  $("#article-list").empty()
  $(".category-search").hide()
  category = $(this).text().toLowerCase().trim()
  $.ajax({
    type: "GET",
    dataType: "json",
    url: "/search/"+ category + "",
    success: function(data) {
      addResourcesToList(data)
    }
  })
  $("#category_filter").val(category)
})
