class TopicsController < ApplicationController
  include TopicsHelper
  before_action :setup, only: [:show, :edit, :update, :destroy]
  before_filter :logged_in_user?, except: [:show]
  before_filter :is_admin?, except: [:show]


  def index
    @action = 'New'
    @topics = Topic.all
    @topic = Topic.new
  end

  def show
    @articles = Article.includes(:topics).where(topics: {id: @topic.id})
  end

  def create
    @topics = Topic.all
    @topic = Topic.new(topic_params)
    set_slug_for_topic(@topic)
    if @topic.save
      redirect_to topics_path
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
    new_topic_params = update_slug_for_topic(topic_params)
    if @topic.update(new_topic_params)
      flash[:success] = 'Topic succesfully updated!'
      render :index
    else
      flash[:danger] = 'Something went wrong!'
      render :index
    end
  end

  def destroy
    if @topic.destroy
      redirect_to topics_path
      flash[:success] = 'Topic succesfully deleted!'
    else
      flash[:danger] = 'Something went wrong'
      redirect_to topics_path
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :slug)
  end

  def set_slug_for_topic(topic) # Set & Update slugs for topics
    topic.slug = topic_params[:name].delete("\'").parameterize
    topic.save!
  end

  def update_slug_for_topic(topic_params) # Add updated slugs to params (not passed through form)
    topic_params[:slug] = topic_params[:name].delete("\'").parameterize
    topic_params
  end

  def setup
    @topic = Topic.find_by(slug: params[:id].parameterize)
    @topics = Topic.all
  end
end
