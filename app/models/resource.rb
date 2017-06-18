class Resource < ActiveRecord::Base
  # Use short, clean url's for resources
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Save type as downcase
  before_save { self.resource_type = resource_type.downcase }

  has_many :resource_categories, :dependent => :delete_all
  has_many :categories, through: :resource_categories
end
