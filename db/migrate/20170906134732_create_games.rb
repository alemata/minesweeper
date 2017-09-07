class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :status
      t.integer :rows
      t.integer :columns
      t.integer :mines_count

      t.timestamps
    end
  end
end
