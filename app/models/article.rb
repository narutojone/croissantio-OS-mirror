class Article < ActiveRecord::Base
  # Adding images to articles
  mount_uploader :image, ImageUploader

  # Friendly Id (mydomain.com/my-cool-article)
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :article_topics, :dependent => :delete_all
  has_many :topics, through: :article_topics
end
