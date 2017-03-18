class Article < ActiveRecord::Base
  # Adding images to articles
  mount_uploader :image, ImageUploader

  # Friendly Id (mydomain.com/my-cool-article)
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Associations with article_category
  belongs_to :article_category
end
