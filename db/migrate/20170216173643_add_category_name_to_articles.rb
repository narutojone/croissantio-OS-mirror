class AddCategoryNameToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :category_name, :string, index: true
  end
end
