task :send_newsletter => :environment do
	require "facebook/messenger"
	include Facebook::Messenger
	Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
	@link = FacebookLink.where(sent: false).first
	FacebookId.all.each do |recipient|
		Bot.deliver({
			recipient: {"id": recipient.fb_id},
			message: {"attachment":{
				"type":"template",
				"payload":{
					"template_type":"generic",
					"elements":[
					{
						"title":"Welcome to Peter\'s Hats",
						"subtitle":"We\'ve got the right hat for everyone.",
						"default_action": {
						"type": "web_url",
						"url": "https://peterssendreceiveapp.ngrok.io/view?item=103",
						},
						"buttons":[
						{
							"type":"web_url",
							"url":"https://petersfancybrownhats.com",
							"title":"View Website"
						}          
						]      
					}
					]
				}
				}
			}
		}, access_token: ENV["ACCESS_TOKEN"])
	end
end