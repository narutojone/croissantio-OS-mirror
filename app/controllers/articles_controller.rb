class ArticlesController < ApplicationController
  include ArticlesHelper
  before_action :setup, only: [:show, :edit, :update, :destroy]
  before_filter :logged_in_user?, except: [:show]
  before_filter :is_admin?, except: [:show]


  def index
    @action = "New"
    @articles = Article.all
    @article  = Article.new
  end

  def show
    @relatedarticles = (Article.where(category_name: @article.category_name).where.not(id: @article.id)).limit(3)
  end

  def create
    @articles = Article.all
    @article = Article.new(article_params)
    @article.update_attribute(:user_id, current_user.id)
    @article.category_name = Category.find(article_params[:category_id]).name
    # set_slug_for_article(@article)
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
    @action = "Edit"
    render :index
  end

  def update
    @action = "Edit"
    # new_article_params = update_slug_for_article(article_params)
    @article.category_name = Category.find(article_params[:category_id]).name
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
    params.require(:article).permit(:title, :description, :body, :image, :user_id, :category_id, :posted, :date, :slug)
  end

  # def set_slug_for_article(article) # Set & Update slugs for articles
  #   article.slug = article_params[:title].gsub("\'", "").parameterize
  #   article.save!
  # end
  #
  # def update_slug_for_article(article_params) # Add updated slugs to params (not passed through form)
  #   article_params.merge! slug: article_params[:title].gsub("\'", "").parameterize
  #   article_params
  # end

  def setup
    @article = Article.friendly.find(params[:id])
    @articles = Article.all
  end
end
