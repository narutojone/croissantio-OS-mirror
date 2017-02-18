class AddCategoryIdToResources < ActiveRecord::Migration
  def change
    add_column :resources, :category_id, :integer, index: true
  end
end
