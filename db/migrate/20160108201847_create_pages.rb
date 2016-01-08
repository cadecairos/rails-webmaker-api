class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :x, null: false
      t.integer :y, null: false
      t.datetime :deleted_at, default: nil
      t.jsonb :styles, default: '{}'

      t.references :project

      t.timestamps null: false
    end

    add_index :pages, [:id, :x, :y], unique: true, where: "deleted_at IS NULL"
  end
end
