class SeparateCategoriesIntoTopicsAndCategories < ActiveRecord::Migration[5.1]
  def change
    drop_table :resources_categories
    remove_column :articles, :category_id
    rename_column :articles, :category_name, :topic_name
    remove_column :categories, :articles_count
    remove_column :categories, :type
    create_table :topics do |t|
      t.string :name
    end
  end
end
