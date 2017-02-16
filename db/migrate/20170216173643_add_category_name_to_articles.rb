class AddCategoryNameToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :category_name, :string, index: true
  end
end
