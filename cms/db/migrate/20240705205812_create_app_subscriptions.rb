class CreateAppSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :app_subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :app, null: false, foreign_key: true

      t.timestamps
    end
  end
end
