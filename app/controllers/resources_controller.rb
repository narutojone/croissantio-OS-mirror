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
    # set_slug_for_resource(@resource)
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
    # new_resource_params = update_slug_for_resource(resource_params)
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
    params.require(:resource).permit(:title, :website, :link, :grade, :slug, :description, :author, :date, :resource_type)
  end
  #
  # def set_slug_for_resource(resource) # Set & Update slugs for resources
  #   resource.slug = resource_params[:title].delete("\'").parameterize
  #   resource.save!
  # end
  #
  # def update_slug_for_resource(resource_params) # Add updated slugs to params (not passed through form)
  #   resource_params[:slug] = resource_params[:title].delete("\'").parameterize
  #   resource_params
  # end

  def setup
    @resource = Resource.friendly.find(params[:id])
    @resources = Resource.all
  end
end
