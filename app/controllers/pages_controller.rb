class PagesController < ApplicationController
   def home
   end

  def subscribe_to_list
    email = params[:email][:address]
    @mailchimp = Mailchimp::API.new(ENV['e9c7545f809158f28a9b319e56a9ca00-us7'])
    # Subscribe to list
    @mailchimp.lists.subscribe(ENV['30c2db17c3'], {'email' => email})
  end
end