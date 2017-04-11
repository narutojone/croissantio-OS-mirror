class Article < ActiveRecord::Base
  # Adding images to articles
  mount_uploader :image, ImageUploader

  # Downcase attribute before saving
  before_save { self.slug = slug.downcase }

  # Friendly Id (mydomain.com/my-cool-article)
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :article_topics, :dependent => :delete_all
  has_many :topics, through: :article_topics
end
