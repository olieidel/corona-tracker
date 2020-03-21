class CreateHeatmaps < ActiveRecord::Migration[6.0]
  def change
    create_table :heatmaps, id: :uuid do |t|
      t.float :radius_km,         null: false
      t.datetime :data_starts_at, null: false
      t.datetime :data_ends_at,   null: false

      t.boolean :simulated,       null: false, default: false

      t.timestamps
    end
  end
end
