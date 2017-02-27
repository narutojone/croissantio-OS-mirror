class AddCategoryNameToResources < ActiveRecord::Migration
  def change
    add_column :resources, :category_name, :string
  end
end
