class CreateCalves < ActiveRecord::Migration[5.1]
  def change
    create_table :calves do |t|
      t.string   :status_type
      t.integer  :weight
      t.integer  :set
      t.integer  :rep
      t.integer  :workout_data_id

      t.timestamps
    end
  end
end
