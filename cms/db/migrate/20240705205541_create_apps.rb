class CreateApps < ActiveRecord::Migration[7.1]
  def change
    create_table :apps do |t|
      t.string :name, limit: 64
      t.string :icon
      t.string :client_id, limit: 32

      t.timestamps
    end
    add_index :apps, :client_id, unique: true
  end
end
