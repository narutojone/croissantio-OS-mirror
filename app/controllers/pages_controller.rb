# frozen_string_literal: true
class PagesController < ApplicationController
  before_filter :logged_in_user?, only: [:admin]
  before_filter :is_admin?, only: [:admin]

  def home; end

  def admin; end

  def about; end

  def thanks; end

  def services; end

  def blog
    @category = Category.where.not(name: 'newsletter').first || (return @articles = [])
    @articles = @category.articles.where(posted: true).order('created_at DESC')
  end

  def newsletter
    @newsletters = Category.find_by(name: 'newsletter').articles.where(posted: true).order('created_at DESC')
  end

  def search
    @selected_option = { resource_type: '', order: '', range: '' , upper: "", lower: ""}
    @selected_option = { upper: params['/resources'][4], lower: params['/resources'][3], resource_type: params['/resources'][0], order: params['/resources'][1], range: params['/resources'][2] } if params['/resources'].present?
    @resources = []
    if params[:search].present?
      redirect_to resources_show_path(params[:search].delete("\'").parameterize) if params[:search]
    elsif params['/resources']
      type = params['/resources'][0]
      order = params['/resources'][1]
      if params['/resources'][2] == 'Custom'
        range = ((params['/resources'][3].to_datetime)..(params['/resources'][4].to_datetime.end_of_day))
      else
        range = eval(params['/resources'][2])
      end
      # binding.pry
      @resources = Resource.where(resource_type: type.downcase, date: range).order(order)
      render :search
    else
      @resource = Resource.new
  end
  end
end
