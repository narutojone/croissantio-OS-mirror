class BotController < ApplicationController
	def create
		@links = []
		params["links"].permit!.to_hash.map { |key, value| @links.push(value)}
		@links.each do |msg|
			if !FacebookLink.exists?(link: msg["link"])
				FacebookLink.create(link: msg["link"], title: msg["title"], sent: false)
			end
		end
	end
end
