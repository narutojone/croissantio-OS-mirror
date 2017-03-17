class ContactformsController < ApplicationController
  def new
    @contactform = Contactform.new
  end

  def create
    @contactform = Contactform.new(params[:contactform])
    @contactform.request = request
    if @contactform.deliver
      flash[:notice] = "Your message was succesfully send!"
      redirect_to contact_path
    else
      flash.now[:error] = "There was an error whilst sending your message!"
      render "pages/contact"
    end
  end
end
