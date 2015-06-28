class UniqueUser1AndUser2InRelationshipsTable < ActiveRecord::Migration
  def change
    add_index :relationships, [:user_1, :user_2], unique: true
  end
end
