class AddTitleToLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :facebook_links, :title, :string
  end
end
