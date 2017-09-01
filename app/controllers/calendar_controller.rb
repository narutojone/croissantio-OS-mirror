class CalendarController < ApplicationController

  def new_event(time, first_name, number)
	cal = Google::Calendar.new(:client_id     => ENV['CLIENT_ID'],
                           :client_secret => ENV['CLIENT_SECRET'],
                           :calendar      => 'superbia.lux@gmail.com',
                           :redirect_url  => "urn:ietf:wg:oauth:2.0:oob" # this is what Google uses for 'applications'
                           )
	if AppSetting.first.refresh_token.blank?
		if AppSetting.first.access_token.blank?
			puts cal.authorize_url 
		else
			AppSetting.first.update(refresh_token: cal.login_with_auth_code(AppSetting.first.access_token))
		end
	else
		@auth = AppSetting.first.refresh_token
		cal.login_with_refresh_token(@auth)

		event = cal.create_event do |e|
			e.title = "#{first_name}: #{number}"
			e.start_time = time.to_time
			e.end_time = time.to_time + 1800 # seconds * min
		end

		puts event
		
	end
  end
end