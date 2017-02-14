class ArticlesController < ApplicationController
  include ArticlesHelper
  before_action :setup, only: [:show, :edit, :update, :destroy]

  def index
    @action = "New"
    @articles = Article.all
    @article  = Article.new
  end

  def show

  end

  def create
    @articles = Article.all
    @article = Article.new(article_params)
    @article.update_attribute(:user_id, current_user.id)
    # set_slug_for_article # Sets slug_en & slug_nl for article
    if @article.save
      if @article.posted?
        flash[:success] = "Article succesfully posted!"
        redirect_to articles_path
      else
        flash[:success] = "Draft succesfully saved!"
        redirect_to articles_path
      end
    else
      flash[:danger] = "Something went wrong!"
      render :index
    end
  end

  def edit
    @articles = Article.all
    @action = "Edit"
    render :index
  end

  def update
    @action = "Edit"
    @articles = Article.all
    if @article.update(article_params)
      flash[:success] = "Article succesfully updated!"
      render :index
    else
      flash[:danger] = "Something went wrong!"
      render :index
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path
      flash[:success] = "Article succesfully deleted!"
    else
      flash[:danger] = "Something went wrong"
      redirect_to articles_path
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body, :image, :user_id, :category, :posted, :slug)
  end

  def set_slug_for_article # Set & Update slugs for articles
    @article.set_friendly_id(article_params[:title], :nl)
    @article.set_friendly_id(article_params[:en_title], :en)
  end

  def update_slug_for_article(article_params) # Add updated slugs to params (not passed through form)
    article_params.merge! slug_nl: article_params[:title].gsub("\'", "").parameterize
    article_params.merge! slug_en: article_params[:en_title].gsub("\'", "").parameterize
    article_params
  end

  def setup
    @article = Article.friendly.find(params[:id])
  end
end
