class PagesController < ApplicationController
  before_filter :logged_in_user?, only: [:admin], if: "User.any?"
  before_filter :is_admin?, only: [:admin], if: "User.any?"
   def home

   end

   def admin

   end
end
