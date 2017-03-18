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
    categories = params["resource"]["resources_categories"].reject{|r| r.empty? }
    if @resource.save
      categories.each {|c| ResourcesCategory.create!(resource_id: @resource.id, category_id: c.to_i)}
      @resource.update_attribute("category_name",categories.map{|c| Category.find(c).name.capitalize}.join(", "))
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
    categories = params["resource"]["resources_categories"].reject{|r| r.empty? }
    if @resource.update(resource_params)
      @resource.resources_categories.destroy_all
      categories.each {|c| ResourcesCategory.create!(resource_id: @resource.id, category_id: c.to_i)}
      @resource.update_attribute("category_name",categories.map{|c| Category.find(c).name.capitalize}.join(", "))
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
