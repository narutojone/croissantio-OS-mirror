class ArticlesController < ApplicationController
  def index
    @article = Article.new
    @action = "Create"
    @articles = Article.all
  end

  def create
  end

  def new
  end

  def destroy
  end

  def show
  end
end
