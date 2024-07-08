class CreateAppRedirects < ActiveRecord::Migration[7.1]
  def change
    create_table :app_redirects do |t|
      t.string :uri
      t.references :app, null: false, foreign_key: true

      t.timestamps
    end
    add_index :app_redirects, [:app_id, :uri], unique: true
  end
end
