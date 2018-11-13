# frozen_string_literal: true

module ApplicationHelper
  def table_hidden?
    'col-hidden' if @action == 'Edit'
  end

  def form_hidden?
    'col-hidden' if @action != 'Edit'
  end

  def logged_in?
    !current_user.nil?
 end

  # Is this a logged in user?
  def logged_in_user?
    unless logged_in?
      redirect_to new_user_session_path
      flash[:danger] = 'Please login to do that action'
    end
  end

  # before_action for authorization in controller
  def is_admin?
    unless current_user.admin?
      flash[:danger] = 'Only admins can do that'
      redirect_to root_path
    end
  end

  def embedded_svg(filename, options = {})
    assets = Rails.application.assets
    file = assets.find_asset(filename).source.force_encoding("UTF-8")
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css "svg"
    if options[:class].present?
      svg["class"] = options[:class]
    end
    raw doc
  end
end
