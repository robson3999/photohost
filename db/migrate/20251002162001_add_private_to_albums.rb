# frozen_string_literal: true

class AddPrivateToAlbums < ActiveRecord::Migration[8.0]
  def change
    add_column :albums, :private, :boolean, default: true, null: false
  end
end
