class ArticlesController < ApplicationController
  include TopicsHelper
  Rails.env.production? && (rescue_from ActiveRecord::RecordNotFound, :with => :render_404)
  before_action :setup, only: %i[show edit update destroy]
  before_action :logged_in_user?, except: [:show]
  before_action :is_admin?, except: [:show]

  def index
    @action = 'New'
    @articles = Article.all
    @article  = Article.new
  end

  def render_404
    render :template => "errors/show"
  end

  def show
    @relatedarticles = Article.includes(:topics).where(topics: { id: @article.topics.map(&:id) }).where.not(id: @article.id).limit(3)
  end

  def create
    topics = params['article']['topics'].reject(&:empty?)
    @articles = Article.all
    @article = Article.new(article_params)
    if @article.save
      @article.update_attributes(user_id: current_user.id, topic_name: topics.map { |c| Topic.find(c).name.capitalize }.join(', '))
      topics.each { |c| ArticleTopic.create!(article_id: @article.id, topic_id: c.to_i) }
      if @article.posted?
        flash[:success] = 'Article succesfully posted!'
        redirect_to articles_path
      else
        flash[:success] = 'Draft succesfully saved!'
        redirect_to articles_path
      end
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
    topics = params['article']['topics'].reject(&:empty?)
    if @article.update(article_params)
      @article.topics.destroy_all
      @article.update_attributes(topic_name: topics.map { |c| Topic.find(c).name.capitalize }.join(', '))
      topics.each { |c| ArticleTopic.create!(article_id: @article.id, topic_id: c.to_i) }
      flash[:success] = 'Article succesfully updated!'
      render :index
    else
      flash[:danger] = 'Something went wrong!'
      render :index
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path
      flash[:success] = 'Article succesfully deleted!'
    else
      flash[:danger] = 'Something went wrong'
      redirect_to articles_path
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body, :image, :user_id, :posted, :date, :slug, :topics)
  end

  def setup
    @article = Article.friendly.find(params[:id].parameterize)
    @articles = Article.all
  end
end
