class AddResourcesCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :resources_count, :integer, default: 0
  end
end
