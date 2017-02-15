class Resource < ActiveRecord::Base
  # Use short, clean url's for resources
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Adding algoliasearch
  include AlgoliaSearch
  algoliasearch do

  end
end
