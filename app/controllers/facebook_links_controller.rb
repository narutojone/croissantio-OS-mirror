class FacebookLinksController < ApplicationController
  before_action :setup, only: %i[show edit update destroy]
  before_action :logged_in_user?, except: [:show]
  before_action :is_admin?, except: [:show]
  require "facebook/messenger"
  include Facebook::Messenger

  def index
    @action = 'New'
    @FacebookLinks = FacebookLink.all
    @FacebookLink = FacebookLink.new
  end

  def create
    @FacebookLinks = FacebookLink.all
    @FacebookLink = FacebookLink.new(link_params)
    if @FacebookLink.save
      redirect_to facebook_links_path
    else
      flash[:danger] = 'Something went wrong!'
      render :index
    end
  end

  def edit
    @action = 'Edit'
    render :index
  end

  def update
    @action = 'Edit'
    if @FacebookLink.update(link_params)
      flash[:success] = 'Link succesfully updated!'
      render :index
    else
      flash[:danger] = 'Something went wrong!'
      render :index
    end
  end

  def destroy
    if @FacebookLink.destroy
      redirect_to facebook_links_path
      flash[:success] = 'FacebookLink succesfully deleted!'
    else
      flash[:danger] = 'Something went wrong'
      redirect_to facebook_links_path
    end
  end

  def instant_message
  end

  def send_instant_message
    FacebookId.all.each do |recipient|
      Bot.deliver({
        recipient: {"id": recipient.fb_id},
        message: {
          text: params[:message]
        }
      }, access_token: ENV["ACCESS_TOKEN"])
	  end
  end

  private

  def link_params
    params.require(:facebook_link).permit(:link, :sent, :title, :desc)
  end

  def setup
    @FacebookLink = FacebookLink.find(params[:id])
    @FacebookLinks = FacebookLink.all
  end
end
