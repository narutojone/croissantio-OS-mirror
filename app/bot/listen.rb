	require "facebook/messenger"
	include Facebook::Messenger
	require 'net/http'
	require 'json'

	Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

	def get_sender_profile(sender)
		uri = URI("https://graph.facebook.com/v2.6/#{sender['id']}")
		params = {access_token: ENV['ACCESS_TOKEN'], fields: 'first_name'}
		uri.query = URI.encode_www_form(params)
		res = Net::HTTP.get_response(uri)
		params = JSON.parse res.body
		return params
	end

	Facebook::Messenger::Profile.set({
		get_started: {
			payload: 'GET_STARTED_PAYLOAD'
		}
	}, access_token: ENV['ACCESS_TOKEN'])


	Bot.on :postback do |postback|
		if postback.payload == 'SUBSCRIBE_TO_BOT'
			if !FacebookId.exists?(fb_id: postback.sender["id"])
				FacebookId.create(fb_id: postback.sender["id"])
				Bot.deliver({
					recipient: postback.sender,
					message: {
						text: "Successfully subsribed"
					}
				}, access_token: ENV["ACCESS_TOKEN"])
			else
				Bot.deliver({
					recipient: postback.sender,
					message: {
						text: "Already subsribed"
					}
				}, access_token: ENV["ACCESS_TOKEN"])
			end
		end
		if postback.payload == 'GET_STARTED_PAYLOAD'
			first_name = get_sender_profile(postback.sender)["first_name"]
			Bot.deliver({
				recipient: postback.sender,
				message: {
					text:
					"Hello #{first_name} 🚀"
				}
			}, access_token: ENV["ACCESS_TOKEN"])
			Bot.deliver({
				recipient: postback.sender,
				message: {
					text: "Growth Bakery is a solo B2B SaaS Marketing & Growth consultancy founded in 2013 by Maxime Salomon in Paris, France that uses a data-driven approach to customer acquisition."
				}
			}, access_token: ENV["ACCESS_TOKEN"])
			Bot.deliver({
				recipient: postback.sender,
				message: {
					text:
					"But enough about Growth Bakery…"
				}
			}, access_token: ENV["ACCESS_TOKEN"])
			Bot.deliver({
				recipient: postback.sender,
				message: {
					text:
					"I’m a messenger bot created by Maxime to help you grow your B2B SaaS business!"
				}
			}, access_token: ENV["ACCESS_TOKEN"])
			Bot.deliver({
				recipient: postback.sender,
				message: {
					text: "What would you like to do?"
				}
			}, access_token: ENV["ACCESS_TOKEN"])
			Bot.deliver({
				recipient: postback.sender,
				message: {
					attachment: {
						type: "template",
						payload: {
							template_type: 'generic',
							elements: [
								{
									title: 'Receive marketing & growth resources daily?',
									buttons: [
										{
											type: "postback",
											title: "Subscribe",
											payload: "SUBSCRIBE_TO_BOT"
										}
									]
								},
								{
									title: 'Read Growth Bakery latest blog post?',
									buttons: [
										{
											type: "web_url",
											url: "https://growthbakery.com/fsdfasd",
											title: "Read Article"
										}
									]
								},
								{
									title: 'Request a Free 30-min consulting call with Maxime?',
									buttons: [
										{
											type: "web_url",
											url: "https://growthbakery.com/services",
											title: "Request Call"
										}
									]
								},
							]
						}
					}
				}
			}, access_token: ENV["ACCESS_TOKEN"])
		end
	end