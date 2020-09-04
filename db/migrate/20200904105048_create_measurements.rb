class CreateMeasurements < ActiveRecord::Migration[6.0]
  def change
    create_table :measurements do |t|
      t.string :size
      t.references :measure, null: false, foreign_key: true

      t.timestamps
    end
  end
end
