class CreateEllipticals < ActiveRecord::Migration[5.1]
  def change
    create_table :ellipticals do |t|
      t.string   :status_type
      t.integer  :speed
      t.integer  :time
      t.integer  :distance
      t.integer  :incline
      t.integer  :resistance
      t.integer  :workout_data_id

      t.timestamps
    end
  end
end

