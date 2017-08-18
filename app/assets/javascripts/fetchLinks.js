$('.js--fetch').on('click', function() {
	var links = []
	if ($( ".form-control option:selected" ).text() == 'newsletter' && $('#article_posted').is(":checked")) {
		$(".trumbowyg-editor").find("a").each(function() {
			links.push([$(this).attr("href"), $(this).html()])
								
		})
		$.post("/fb/create-link",
				{
					links: links
				},
				function(){
					console.log('Links have been created')
				});
	}
	return true
})