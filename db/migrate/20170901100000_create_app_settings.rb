class CreateAppSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :app_settings do |t|
      t.string :refresh_token

      t.timestamps
    end
  end
end
