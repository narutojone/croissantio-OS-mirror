class CreateResources < ActiveRecord::Migration[5.1]
  def change
    create_table :resources do |t|
      t.integer :grade
      t.string :website
      t.string :title
      t.string :link
      t.string :slug
      t.text :description
      t.string :author
      t.datetime :date

      t.timestamps
    end
    add_index :resources, :slug, unique: true
  end
end
