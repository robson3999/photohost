# frozen_string_literal: true

class CreatePhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :photos do |t|
      t.string :uuid, null: false, index: { unique: true }
      t.string :title
      t.text :description
      t.json :metadata
      t.bigint :user_id, null: false, index: true

      t.timestamps
    end
  end
end
