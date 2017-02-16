# frozen_string_literal: true
class PagesController < ApplicationController
  require 'active_support/core_ext/integer/inflections'
  before_filter :logged_in_user?, only: [:admin]
  before_filter :is_admin?, only: [:admin]

  def home; end

  def admin; end

  def about; end

  def thanks; end

  def services; end

  def blog
    @articles = Article.where.not(category_name: "newsletter").where(posted: true)
  end

  def newsletter
    @newsletters = Article.where(category_name: 'newsletter', posted: true)
  end

  def blog_test

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
