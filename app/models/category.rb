class Category < ActiveRecord::Base
  validates :name, length: { minimum: 2 }

  # Downcase attribute before saving
  before_save { self.name = name.downcase }

  # Slug in ulr
  extend FriendlyId
  friendly_id :name, use: :slugged

  # To display it pretty in selector on /search page
  def display_name
    name.size > 3 ? name.split.map(&:capitalize)*' ' : name.upcase
  end

  has_many :resource_categories, dependent: :delete_all
  has_many :resources, through: :resource_categories
end
