class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.integer :album_id
      t.integer :user_id
      t.string :role
      t.string :status

      t.timestamps
    end

    add_index :collaborations, :album_id
    add_index :collaborations, :user_id
    add_index :collaborations, [:album_id, :user_id], unique: true
  end
end
