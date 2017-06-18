class ContactformsController < ApplicationController
  def new
    @contactform = Contactform.new
  end

  def create
    @contactform = Contactform.new(params[:contactform])
    @contactform.services = @contactform.services.delete_if { |e| e == '0' }.collect { |e| e.tr!('_', ' '); e.capitalize }
    @contactform.request = request
    if @contactform.deliver
      flash[:notice] = "Thanks for your interest! I'll get in touch with you as soon as possible. Have a great day."
      redirect_to contact_path
    else
      flash[:error] = 'There was an error whilst sending your message!'
      render 'pages/contact'
    end
  end
end
