class PagesController < ApplicationController
  before_filter :logged_in_user?, only: [:admin], if: "User.any?"
  before_filter :is_admin?, only: [:admin], if: "User.any?"

   def home
     @newsletters = Article.where(posted: true, category: "newsletter").order("created_at DESC")
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
     @articles = Article.where(posted: true).where.not(category: "newsletter").order("created_at DESC")
   end
end
