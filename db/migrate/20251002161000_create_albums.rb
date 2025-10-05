# frozen_string_literal: true

class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.text :description
      t.string :uuid, null: false, unique: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :albums, :uuid, unique: true
  end
end
