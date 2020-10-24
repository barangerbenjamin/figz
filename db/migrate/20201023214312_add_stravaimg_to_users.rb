class AddStravaimgToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :strava_picture_url, :string
  end
end
