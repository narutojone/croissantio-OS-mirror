class Resource < ActiveRecord::Base
  # Use short, clean url's for resources
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Save type as downcase
  before_save { self.resource_type = resource_type.downcase }

  # Adding algoliasearch
  include AlgoliaSearch
  algoliasearch do

  end

  # Associations with category
  belongs_to :category
end
