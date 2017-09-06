class CreateTiles < ActiveRecord::Migration[5.0]
  def change
    create_table :tiles do |t|
      t.integer :row
      t.integer :column
      t.boolean :mine, default: false
      t.boolean :revealed, default: false
      t.references :game, foreign_key: true
      t.integer :neighbor_mines_count, default: 0

      t.timestamps
    end
  end
end
