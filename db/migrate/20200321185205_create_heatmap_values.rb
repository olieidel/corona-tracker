class CreateHeatmapValues < ActiveRecord::Migration[6.0]
  def change
    create_table :heatmap_values, id: :uuid do |t|
      t.references :heatmap, type: :uuid, null: false, foreign_key: true
      t.float :latitude,        null: false
      t.float :longitude,       null: false
      t.float :percentage_sick, null: false

      # Note: Timestamps omitted, are in referenced heatmap
    end

    add_index :heatmap_values, [:latitude, :longitude]
  end
end
