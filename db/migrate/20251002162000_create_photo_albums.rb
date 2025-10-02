class CreatePhotoAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :photo_albums do |t|
      t.references :photo, null: false, foreign_key: true
      t.references :album, null: false, foreign_key: true
      t.timestamps
    end
    add_index :photo_albums, [ :photo_id, :album_id ], unique: true
  end
end
