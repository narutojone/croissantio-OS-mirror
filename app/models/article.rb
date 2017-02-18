class Article < ActiveRecord::Base
# Adding images to articles
mount_uploader :image, ImageUploader

# Friendly Id (mydomain.com/my-cool-article)
extend FriendlyId
friendly_id :title, use: :slugged

# Associations with category
belongs_to :category
end
