class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes do |t|
      t.string :name
      t.string :start_location
      t.float :start_latitude
      t.float :start_longitude
      t.string :end_location
      t.float :end_latitude
      t.float :end_longitude
      t.float :distance
      t.integer :elevation
      t.string :road_type

      t.timestamps
    end
  end
end
