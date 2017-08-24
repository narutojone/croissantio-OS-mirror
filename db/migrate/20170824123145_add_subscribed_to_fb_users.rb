class AddSubscribedToFbUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :facebook_ids, :subscribed, :boolean, default: false
  end
end
