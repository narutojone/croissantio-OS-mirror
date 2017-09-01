class AddAccesTokenToAppSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :app_settings, :access_token, :string
  end
end
