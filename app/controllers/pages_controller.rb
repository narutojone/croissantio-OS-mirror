# frozen_string_literal: true

class PagesController < ApplicationController
  require 'active_support/core_ext/integer/inflections'
  before_action :logged_in_user?, only: [:admin]
  before_action :is_admin?, only: [:admin]

  def home; end

  def admin; end

  def about; end

  def thanks
    @newsletter = Article.includes(:topics).where(topics: { name: 'newsletter' }, posted: true).last
  end

  def thanks_marketing_101
  end

  def thanks_call
  end

  def services; end

  def about; end

  def marketing_101; end

  def all_courses; end

  def contact
    @contactform = Contactform.new
  end

  def blog
    @articles = Article.includes(:topics).where.not(topics: { name: 'newsletter' }).where(posted: true)
  end

  def newsletter
    @newsletters = Article.includes(:topics).where(topics: { name: 'newsletter' }, posted: true)
  end

  def search
    @topcategories = Category.joins(:resources).group('categories.id').order('count(resources.id) DESC').limit(8)
    @selected_option = { resource_type: '', order: '', range: '', upper: '', lower: '', category: '' }
    @resources = []
    if params[:id] && !params['/resources']
      category = Category.find_by(slug: params[:id].parameterize)
      @resources = Resource.includes(:categories).where(categories: { id: category.id })
      @status = 'hidden'
      respond_to do |format|
        format.html
        format.json { render json: @resources }
      end
    elsif params['/resources']
      type = params['/resources'][0]
      category = params['/resources'][1]
      order = params['/resources'][2]
      range = params['/resources'][3]
      if range == 'All Time'
        date = [nil, nil]
        range = [nil, nil]
      else
        date = range.split('-').collect(&:to_datetime)
        range = date[0]..date[1]
      end
      @search_resource = params[:query]
      @selected_option = { category: category, upper: date[0].to_f * 1000, lower: date[1].to_f * 1000, resource_type: type, order: order, range: params['/resources'][3] }
      @resources = Resource.includes(:categories).all
      @resources = @resources.where(date: range) if date != [nil, nil]
      @resources = @resources.where(resource_type: type.downcase) if type != ''
      @resources = @resources.where(categories: { slug: category.tr(' ', '-') }) if category != ''
      @resources = @resources.order(order)
      @status = 'hidden'
    else
      @status = ''
      @resource = Resource.new
    end
  end
end
