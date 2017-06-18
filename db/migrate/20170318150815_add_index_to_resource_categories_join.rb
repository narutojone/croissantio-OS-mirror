class AddIndexToResourceCategoriesJoin < ActiveRecord::Migration[5.1]
  def change
    add_index(:resources_categories, :resource_id)
    add_index(:resources_categories, :category_id)
  end
end
