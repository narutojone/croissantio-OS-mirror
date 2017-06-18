class CategoriesController < ApplicationController
  include CategoriesHelper
  before_action :setup, only: %i[show edit update destroy]
  before_action :logged_in_user?, except: [:show]
  before_action :is_admin?, except: [:show]

  def index
    @action = 'New'
    @categories = Category.all
    @category = Category.new
  end

  def show
    @articles = Article.where(category_id: @category)
  end

  def create
    @categories = Category.all
    @category = Category.new(category_params)
    set_slug_for_category(@category)
    if @category.save
      redirect_to categories_path
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
    new_category_params = update_slug_for_category(category_params)
    if @category.update(new_category_params)
      flash[:success] = 'Category succesfully updated!'
      render :index
    else
      flash[:danger] = 'Something went wrong!'
      render :index
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path
      flash[:success] = 'Category succesfully deleted!'
    else
      flash[:danger] = 'Something went wrong'
      redirect_to categories_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :slug, :type, :icon)
  end

  def set_slug_for_category(category) # Set & Update slugs for categories
    category.slug = category_params[:name].delete("\'").parameterize
    category.save!
  end

  def update_slug_for_category(category_params) # Add updated slugs to params (not passed through form)
    category_params[:slug] = category_params[:name].delete("\'").parameterize
    category_params
  end

  def setup
    @category = Category.find_by(slug: params[:id].parameterize)
    @categories = Category.all
  end
end
