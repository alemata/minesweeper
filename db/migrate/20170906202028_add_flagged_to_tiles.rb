class AddFlaggedToTiles < ActiveRecord::Migration[5.0]
  def change
    add_column :tiles, :flagged, :boolean
  end
end
