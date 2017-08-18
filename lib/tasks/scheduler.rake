task :send_newsletter => :environment do
	require "facebook/messenger"
	include Facebook::Messenger
	Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
	@link = FacebookLink.where(sent: false).last
	FacebookId.all.each do |recipient|
		Bot.deliver({
			recipient: {"id": recipient.fb_id},
			message: {"attachment":{
				"type":"template",
				"payload":{
					"template_type":"generic",
					"elements":[
					{
						"title": @link.title,
						"default_action": {
						"type": "web_url",
						"url": @link.link,
						},
						"buttons":[
						{
							"type":"web_url",
							"url": @link.link,
							"title":"View Resource"
						}          
						]      
					}
					]
				}
				}
			}
		}, access_token: ENV["ACCESS_TOKEN"])
		@link.update(sent: true)
	end
end