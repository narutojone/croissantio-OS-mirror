$('.js--fetch').on('click', function() {
	var info = []
	if ($( ".form-control option:selected" ).text() == 'newsletter' && $('#article_posted').is(":checked")) {
		$(".trumbowyg-editor").find("a").each(function() {
			info.push({link: $(this).attr("href"), title: $(this).html()})							
		})
		$.post("/fb/create-link",
			{
				links: info
			}
		);
	}
	return true
})
;
