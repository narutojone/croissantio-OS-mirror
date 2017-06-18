class AddCategoryNameToResources < ActiveRecord::Migration[5.1]
  def change
    add_column :resources, :category_name, :string
  end
end
