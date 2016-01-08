class AddDefaultsToProjectColumns < ActiveRecord::Migration
  def change
    change_column :projects, :thumbnail, :jsonb, default: {}
    change_column :projects, :metadata, :jsonb, default: {}
  end
end