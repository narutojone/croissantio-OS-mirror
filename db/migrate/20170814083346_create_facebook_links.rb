class CreateFacebookLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :facebook_links do |t|
      t.string :link
      t.boolean :sent

      t.timestamps
    end
  end
end
