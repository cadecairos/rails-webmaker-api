class ChangeMetadataDefault < ActiveRecord::Migration
  def change
    change_column :projects, :metadata, :jsonb, default: '{}'
  end
end
