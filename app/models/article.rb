class Article < ActiveRecord::Base
mount_uploader :image, ImageUploader

before_save { self.category = category.downcase }

extend FriendlyId
friendly_id :title, use: :slugged

end
