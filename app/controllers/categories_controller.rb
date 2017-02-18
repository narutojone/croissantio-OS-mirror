class CategoriesController < ApplicationController
  before_action :setup, only: [:show, :edit, :update, :destroy]
  before_filter :logged_in_user?, except: [:show]
  before_filter :is_admin?, except: [:show]


  def index
    @action = 'New'
    @categories = Category.all
    @category = Category.new
  end

  def show
    @articles = @category.articles
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
    params.require(:category).permit(:name, :slug)
  end

  def set_slug_for_category(category) # Set & Update slugs for categorys
    category.slug = category_params[:name].delete("\'").parameterize
    category.save!
  end

  def update_slug_for_category(category_params) # Add updated slugs to params (not passed through form)
    category_params[:slug] = category_params[:name].delete("\'").parameterize
    category_params
  end

  def setup
    @category = Category.friendly.find(params[:id])
    @categories = Category.all
  end
end
