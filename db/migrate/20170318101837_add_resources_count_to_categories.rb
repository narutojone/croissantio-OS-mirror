class AddResourcesCountToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :resources_count, :integer, default: 0
  end
end
