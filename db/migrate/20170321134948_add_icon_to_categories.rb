class AddIconToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :icon, :string
  end
end
