class Category < ActiveRecord::Base
  validates :name, length: { minimum: 2 }

  # Downcase attribute before saving
  before_save { self.name = name.downcase }

  # Slug in ulr
  extend FriendlyId
  friendly_id :name, use: :slugged

  # To display it pretty in selector on /search page
  def display_name
    name.capitalize
  end

  # Connects resource_category (STI of Category) with resources
  has_many :resources_categories
  has_many :resources, through: :resources_categories
end
