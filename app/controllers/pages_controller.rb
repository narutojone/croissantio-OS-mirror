class PagesController < ApplicationController
  before_filter :logged_in_user?, only: [:admin]
  before_filter :is_admin?, only: [:admin]

   def home
   end

   def admin

   end

   def about

   end

   def thanks

   end

   def services

   end

   def blog
     @category = (Category.where.not(name: "newsletter").first) || (return @articles = [])
     @articles = @category.articles.where(posted: true).order("created_at DESC")
   end

   def newsletter
     @newsletters = Category.find_by(name: "newsletter").articles.where(posted: true).order("created_at DESC")
end
end
