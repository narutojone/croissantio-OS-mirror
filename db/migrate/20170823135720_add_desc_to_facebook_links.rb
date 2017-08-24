class AddDescToFacebookLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :facebook_links, :desc, :text
  end
end
