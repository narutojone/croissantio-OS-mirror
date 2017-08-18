class BotController < ApplicationController
	def create
		i = 0
		params[:links].each do |link|
			if !FacebookLink.exists?(link: link[i.to_s][0])
				FacebookLink.create(link: link[i.to_s][0], title: link[i.to_s][1], sent: false)
			end
			i =+ 1
		end
	end
end
