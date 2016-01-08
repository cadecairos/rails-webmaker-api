class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, unique: true
      t.datetime :deleted_at
      t.string :language
      t.boolean :moderator
      t.boolean :staff

      t.timestamps null: false
    end
  end
end
