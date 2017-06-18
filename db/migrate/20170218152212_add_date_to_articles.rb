class AddDateToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :date, :datetime
  end
end
