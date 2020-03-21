class CreateQuestionnaires < ActiveRecord::Migration[6.0]
  def change
    create_table :questionnaires, id: :uuid do |t|
      t.uuid :client_uuid,                         null: false
      t.boolean :healthy,                          null: false
      t.boolean :tested,                           null: false
      t.boolean :fever,                            null: false
      t.boolean :cough,                            null: false
      t.string :other_symptoms,                    null: false

      t.float :latitude,                           null: false
      t.float :longitude,                          null: false
      t.text   :address,                           null: true
      t.float :accuracy,                           null: false

      t.timestamps
    end
  end
end
