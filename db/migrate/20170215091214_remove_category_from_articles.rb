class RemoveCategoryFromArticles < ActiveRecord::Migration[5.1]
  def change
    remove_column :articles, :category
  end
end
