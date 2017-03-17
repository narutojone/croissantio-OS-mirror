class Category < ActiveRecord::Base
  # Relation to articles
  has_many :articles, dependent: :destroy

  # Relation to resources
  has_many :resources, dependent: :destroy

  # Downcase attribute before saving
  before_save { self.name = name.downcase }

  # Slug in ulr
  extend FriendlyId
  friendly_id :name, use: :slugged
end
