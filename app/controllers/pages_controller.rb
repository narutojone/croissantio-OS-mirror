class PagesController < ApplicationController
   def home
   end

  def subscribe_to_list
    email = params[:email][:address]
    @mailchimp = Mailchimp::API.new(ENV['MAILCHIMP_API_KEY'])
    # Subscribe to list
    @mailchimp.lists.subscribe(ENV['MAILCHIMP_LIST_ID'], {'email' => email})
  end
end