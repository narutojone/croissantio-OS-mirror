class ResourcesController < ApplicationController
  before_action :setup, only: [:show, :edit, :update, :destroy]
  before_filter :logged_in_user?, except: [:show]
  before_filter :is_admin?, except: [:show]

  def index
    @action = 'New'
    @resources = Resource.all
    @resource = Resource.new
  end

  def show

  end

  def create
    @resources = Resource.all
    @resource = Resource.new(resource_params)
    @resource.category_name = Category.find(resource_params[:category_id]).name
    if @resource.save
      redirect_to resources_path
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
    @resource.category_name = Category.find(resource_params[:category_id]).name
    if @resource.update(resource_params)
      flash[:success] = 'Resource succesfully updated!'
      render :index
    else
      flash[:danger] = 'Something went wrong!'
      render :index
    end
  end

  def destroy
    if @resource.destroy
      redirect_to resources_path
      flash[:success] = 'Resource succesfully deleted!'
    else
      flash[:danger] = 'Something went wrong'
      redirect_to resources_path
    end
  end

  private

  def resource_params
    params.require(:resource).permit(:title, :website, :link, :grade, :slug, :description, :author, :date, :resource_type, :category_id, :category_name)
  end

  def setup
    @resource = Resource.friendly.find(params[:id])
    @resources = Resource.all
  end
end
