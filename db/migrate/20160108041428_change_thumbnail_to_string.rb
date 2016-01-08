class ChangeThumbnailToString < ActiveRecord::Migration
  def change
    change_column :projects, :thumbnail, :string, default: ""
  end
end
