require "facebook/messenger"
include Facebook::Messenger
Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Facebook::Messenger::Profile.set({
  get_started: {
    payload: 'GET_STARTED_PAYLOAD'
  }
}, access_token: ENV['ACCESS_TOKEN'])

Bot.on :message do |message|
  Bot.deliver({
    recipient: message.sender,
    message: {
      text: 'Hello!'
    }
  }, access_token: ENV["ACCESS_TOKEN"])
end

Bot.on :postback do |postback|
  if !FacebookId.exists?(fb_id: postback.sender["id"]) 
  	FacebookId.create(fb_id: postback.sender["id"])
  end
  if postback.payload == 'GET_STARTED_PAYLOAD'
	Bot.deliver({
    recipient: postback.sender,
    message: {
      text: 'Hello!'
    }
  }, access_token: ENV["ACCESS_TOKEN"])
  end
end