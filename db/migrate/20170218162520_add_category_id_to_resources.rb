class AddCategoryIdToResources < ActiveRecord::Migration[5.1]
  def change
    add_column :resources, :category_id, :integer, index: true
  end
end
