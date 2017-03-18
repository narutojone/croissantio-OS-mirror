# frozen_string_literal: true
class PagesController < ApplicationController
  require 'active_support/core_ext/integer/inflections'
  before_filter :logged_in_user?, only: [:admin]
  before_filter :is_admin?, only: [:admin]

  def home; end

  def admin; end

  def about; end

  def thanks
    @newsletter = Article.where(category_name: 'newsletter', posted: true).first
  end

  def services; end

  def about; end

  def contact
    @contactform = Contactform.new
  end

  def blog
    @articles = Article.where.not(category_name: 'newsletter').where(posted: true)
  end

  def newsletter
    @newsletters = Article.where(category_name: 'newsletter', posted: true)
  end

  def search
    @topcategories = ResourceCategory.joins(:resources).group("categories.id").order("count(resources.id) DESC").limit(8)
    @selected_option = { resource_type: '', order: '', range: '', upper: '', lower: '', category: "" }
    @resources = []
    if params[:id] && !params['/resources']
      category = ResourceCategory.find_by(slug: params[:id].parameterize)
      @resources = Resource.includes(:categories).where(categories: { id: category.id })
      @status = "hidden"
    elsif params['/resources']
      type = params['/resources'][0]
      category = params['/resources'][1]
      order = params['/resources'][2]
      range = params['/resources'][3]
      range = range.split('-').collect(&:to_datetime)
      @selected_option = { category: category, upper: range[0].to_f * 1000, lower: range[1].to_f * 1000, resource_type: type, order: order, range: params['/resources'][3] }
      range = range[0]..range[1]
      @resources = Resource.includes(:categories).where(resource_type: type.downcase, date: range, categories: { id: category }).order(order)
      @status = "hidden"
    else
      @status = ""
      @resource = Resource.new
    end
  end
end
