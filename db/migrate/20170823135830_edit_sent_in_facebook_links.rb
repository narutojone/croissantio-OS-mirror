class EditSentInFacebookLinks < ActiveRecord::Migration[5.1]
  def change
    change_column :facebook_links, :sent, :boolean, default: false
  end
end
