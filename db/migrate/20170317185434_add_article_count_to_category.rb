class AddArticleCountToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :articles_count, :integer, default: 0
  end
end
