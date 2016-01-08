class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :remixed_from
      t.string :version
      t.string :title
      t.boolean :featured
      t.datetime :deleted_at
      t.jsonb :thumbnail
      t.text :description
      t.jsonb :metadata

      t.timestamps null: false
    end
    execute <<-SQL
      CREATE INDEX ON projects ((metadata->>'tags'))
    SQL
  end
end
