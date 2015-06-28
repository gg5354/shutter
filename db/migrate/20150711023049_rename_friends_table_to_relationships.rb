class RenameFriendsTableToRelationships < ActiveRecord::Migration
  def change
    rename_table :friends, :relationships
  end
end
