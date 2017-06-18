class ChangeColumnTypeInResources < ActiveRecord::Migration[5.1]
  def change
    rename_column :resources, :type, :resource_type
  end
end
