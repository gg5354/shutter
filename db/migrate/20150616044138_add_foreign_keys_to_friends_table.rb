class AddForeignKeysToFriendsTable < ActiveRecord::Migration
  def change
    remove_column :friends, :user_id
    remove_column :friends, :friend_id
    remove_column :friends, :status_id

    add_column :friends, :user_1, :integer, null: false
    add_column :friends, :user_2, :integer, null: false
    add_column :friends, :status, :integer, null: false

    add_foreign_key :friends, :users, column: :user_1
    add_foreign_key :friends, :users, column: :user_2
  end
end
