class AddColumnToMeasures < ActiveRecord::Migration[6.0]
  def change
    add_column :measures, :body_part_name, :string
  end
end
