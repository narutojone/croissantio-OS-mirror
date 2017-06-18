class ResourcesController < ApplicationController
  before_action :setup, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user?, except: [:show]
  before_action :is_admin?, except: [:show]

  def index
    @action = 'New'
    @resources = Resource.all
    @resource = Resource.new
  end

  def show

  end

  def create
    categories = params["resource"]["categories"].reject{|r| r.empty? }
    @resources = Resource.all
    @resource = Resource.new(resource_params)
    if @resource.save
      @resource.update_attributes(category_name: categories.map{|c| Category.find(c).name.capitalize}.join(", "))
      categories.each {|c| ResourceCategory.create!(resource_id: @resource.id, category_id: c.to_i)}
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
    categories = params["resource"]["categories"].reject{|r| r.empty? }
    @action = 'Edit'
    if @resource.update(resource_params)
      @resource.categories.destroy_all
      @resource.update_attributes(category_name: categories.map{|c| Category.find(c).name.capitalize}.join(", "))
      categories.each {|c| ResourceCategory.create!(resource_id: @resource.id, category_id: c.to_i)}
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
    params.require(:resource).permit(:title, :website, :link, :grade, :slug, :description, :author, :date, :resource_type)
  end

  def setup
    @resource = Resource.friendly.find(params[:id].parameterize)
    @resources = Resource.all
  end
end
