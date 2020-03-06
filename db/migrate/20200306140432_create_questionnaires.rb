class CreateQuestionnaires < ActiveRecord::Migration[6.0]
  def change
    create_table :questionnaires, id: :uuid do |t|
      t.boolean :healthy,                          null: false
      t.boolean :fever,                            null: false
      t.boolean :cough,                            null: false
      t.references :browser_location, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
