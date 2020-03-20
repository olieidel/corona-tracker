class CreateBrowserLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :browser_locations, id: :uuid do |t|
      # t.st_point :lonlat, geographic: true, null: false
      t.float :latitude,                    null: false
      t.float :longitude,                   null: false
      t.text   :address,                    null: true
      t.float :accuracy,                    null: false

      t.timestamps
    end

    # add_index :browser_locations, :lonlat, using: :gist
  end
end
