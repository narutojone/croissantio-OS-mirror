// <!-- Initialize Algolia -->
var client = algoliasearch("J97XEMUI7C", "ec96a3adcb4bf3ef61b276cc5a3790d7");
var index = client.initIndex('Resource');
window.index = index
$('#aa-search-input').autocomplete({
	hint: true
}, [
	{
		source: $.fn.autocomplete.sources.hits(index, {hitsPerPage: 10}),
		//value to be displayed in input control after user's suggestion selection
		displayKey: 'title',
		//hash of templates used when rendering dataset
		templates: {
			//'suggestion' templating function used to render a single suggestion
			suggestion: function (suggestion) {
				// console.log(suggestion)
				title = (suggestion.title)
				if (grade != null && title != null) {
					return '<span>' + title + '</span>';
				} else {
					return '<span> Nothing found </span>';
				}
			}
		}
	}
]);

// <!-- Submit form when selecting a new filter  -->
$(".manual-filter").on("change", function () {
	val = $(".date-range").text()
	$("#daterange").val(val)
	$("#search-form").submit()
})

// <!-- Submit form when selecting a new daterange + add the value to a hidden form -->
window.onload = function () {
	$(".date-range").on("DOMSubtreeModified", function () {
		val = $(".date-range").text()
		$("#daterange").val(val)
		$("#search-form").submit()
	})
}

// <!-- Append suggestions to article list as typing happens -->
$("#aa-search-input").on("input", function () {
	$("#article-list").empty()
	index.search($('#aa-search-input').val(), function (err, content) {
		array = content.hits.slice(0, 10)
		for (var i = 0; i < array.length; i++) {
			title = array[i].title
			grade = array[i].grade
			description = array[i].description
			date = array[i].date
			resource_type = array[i].resource_type
			slug = array[i].slug
			link = array[i].link
			author = array[i].author
			var html = "";
			html += "<div class=\"masonry__item resource_card\">";
			html += "							<h4 class=\"resource-title\">";
			html += "							<a href=" + link + ">" + title + "<\/a>";
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
	});
})

// <!-- Some weird stuff that was showing up on page load that shouldn't be there. It's display: hidden but it should pop up when clicked, so that's why I place this here. -->
$("#reportrange").on("click", function () {
	$(".ranges").show()
	$(".daterangepicker.dropdown-menu.ltr.opensleft").show()
})

// <!-- Duh -->
function capitalizeFirstLetter(string) {
	return string.charAt(0).toUpperCase() + string.slice(1);
}
