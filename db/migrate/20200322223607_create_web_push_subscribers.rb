class CreateWebPushSubscribers < ActiveRecord::Migration[6.0]
  def change
    create_table :web_push_subscribers, id: :uuid do |t|
      t.float :latitude,           null: false
      t.float :longitude,          null: false
      t.string :endpoint,          null: false
      t.string :p256dh,            null: false
      t.string :auth,              null: false
      t.datetime :expires_at,      null: true
      t.datetime :unsubscribed_at, null: true
      t.timestamps
    end

    add_index :web_push_subscribers, :endpoint, unique: true
  end
end
