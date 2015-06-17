class AddForeignKeyConstraintToAlbums < ActiveRecord::Migration
  def change
    add_foreign_key :albums, :users
  end
end
