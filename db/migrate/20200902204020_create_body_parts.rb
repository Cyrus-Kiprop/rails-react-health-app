class CreateBodyParts < ActiveRecord::Migration[6.0]
  def change
    create_table :body_parts do |t|
      t.string :name
      t.integer :size
      t.references :measure, null: false, foreign_key: true

      t.timestamps
    end
  end
end
