class CreateWorkoutData < ActiveRecord::Migration[5.1]
  def change
    create_table :workout_data do |t|
      t.date     :date
      t.integer  :upper_body_id
      t.integer  :lower_body_id
      t.integer  :arm_id 
      t.integer  :leg_id
      t.integer  :cardio_id
      t.integer  :user_id

      t.timestamps
    end
  end
end
