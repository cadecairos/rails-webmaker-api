class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :remixed_from
      t.string :version
      t.string :title
      t.boolean :featured
      t.datetime :deleted_at
      t.string :thumbnail, default: ""
      t.text :description
      t.jsonb :metadata, default: '{}'

      t.references :user

      t.timestamps null: false
    end
    execute <<-SQL
      CREATE INDEX ON projects ((metadata->>'tags'))
    SQL
  end
end
