class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.text :body
      t.string :image
      t.string :user_id
      t.string :category
      t.boolean :posted

      t.timestamps
    end
  end
end
