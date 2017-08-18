class CreateFacebookIds < ActiveRecord::Migration[5.1]
  def change
    create_table :facebook_ids do |t|
      t.string :fb_id

      t.timestamps
    end
  end
end
