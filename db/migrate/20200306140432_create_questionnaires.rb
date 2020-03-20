class CreateQuestionnaires < ActiveRecord::Migration[6.0]
  def change
    create_table :questionnaires, id: :uuid do |t|
      t.uuid :client_uuid,                         null: false
      t.boolean :healthy,                          null: false
      t.boolean :tested,                           null: false
      t.boolean :fever,                            null: false
      t.boolean :cough,                            null: false
      t.text :other_symptoms,                      null: true

      t.float :latitude,                           null: false
      t.float :longitude,                          null: false
      t.text   :address,                           null: true
      t.float :accuracy,                           null: false

      # t.references :browser_location, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
