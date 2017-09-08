	require "facebook/messenger"
	include Facebook::Messenger
	require 'uri'
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

	def pick_timeslot(time)
		uri = URI("https://croissant.io/calendar/new-event")
		params = {access_token: ENV['ACCESS_TOKEN'], fields: 'first_name'}
		request = Net::HTTP::Post.new(uri.path)
		request["time"] = time
	end


	Facebook::Messenger::Profile.set({
		get_started: {
			payload: 'GET_STARTED_PAYLOAD'
		}
	}, access_token: ENV['ACCESS_TOKEN'])

Bot.on :message do |message|
	if message.text.include?('Phone - ')
		if @time
			@phone = message.text.sub('Phone -', '')
			Bot.deliver({
					recipient: message.sender,
					message: {
						attachment: {
							type: "template",
							payload: {
								template_type: 'generic',
								elements: [
									{
										title: "Name: #{@first_name}, Phone number: #{@phone}, Timeslot: #{@time}.
All Good?",
										buttons: [
											{
												type: "postback",
												title: "Request Call",
												payload: "REQUEST_CALL_CONFIRM"
											}
										]
									}
								]
							}
						}
					}
				}, access_token: ENV["ACCESS_TOKEN"])
		else
			Bot.deliver({
					recipient: message.sender,
					message: {
						text: "Set a timeslot first!"
					}
				}, access_token: ENV["ACCESS_TOKEN"])
		end
	end
		
	if message.text.include?('Timeslot -')
		@time = message.text.sub('Timeslot -', '')
		Bot.deliver({
					recipient: message.sender,
					message: {
						text: "Now tell me your phone number or skype ID.
Example: _Phone - +01 23456789_"
					}
				}, access_token: ENV["ACCESS_TOKEN"])
	end
end


	Bot.on :postback do |postback|
		if postback.payload == 'SUBSCRIBE_TO_BOT'
			fb_user = FacebookId.find_by(fb_id: postback.sender["id"])
			if !fb_user.subscribed
				fb_user.update(subscribed: true)
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
		if postback.payload == 'REQUEST_CALL'
				Bot.deliver({
					recipient: postback.sender,
					message: {
						text: "Pick a time slot according to the example below. 
Example: _Timeslot - 28/07/1999 15:15_"
					}
				}, access_token: ENV["ACCESS_TOKEN"])			
		end
		if postback.payload == 'REQUEST_CALL_CONFIRM'
			CalendarController.new.new_event(@time, @first_name, @phone )
				Bot.deliver({
					recipient: postback.sender,
					message: {
						text: "Thank you, Maxime will get to you soon!"
					}
				}, access_token: ENV["ACCESS_TOKEN"])
			@time = ''	
			@first_name = ''	
			@phone = ''
		end
		if postback.payload == 'GET_STARTED_PAYLOAD'
			@first_name = get_sender_profile(postback.sender)["first_name"]
			if !FacebookId.exists?(fb_id: postback.sender["id"])
				FacebookId.create(fb_id: postback.sender["id"])
			end
			Bot.deliver({
				recipient: postback.sender,
				message: {
					text: "Hello #{@first_name} 🚀"
				}
			}, access_token: ENV["ACCESS_TOKEN"])
			Bot.deliver({
				recipient: postback.sender,
				message: {
					text: "Croissant is a solo B2B SaaS Marketing & Growth consultancy founded in 2013 by Maxime Salomon in Paris, France that uses a data-driven approach to customer acquisition."
				}
			}, access_token: ENV["ACCESS_TOKEN"])
			Bot.deliver({
				recipient: postback.sender,
				message: {
					text:
					"But enough about Croissant…"
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
			@article = 'topkek'
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
									title: 'Read Croissant latest blog post?',
									buttons: [
										{
											type: "web_url",
											url: "https://croissant.io/#{@article}",
											title: "Read Article"
										}
									]
								},
								{
									title: 'Request a Free 30-min consulting call with Maxime?',
									buttons: [
										{
											type: "postback",
											title: "Request Call",
											payload: "REQUEST_CALL"
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