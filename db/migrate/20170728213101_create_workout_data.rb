class CreateWorkoutData < ActiveRecord::Migration[5.1]
  def change
    create_table :workout_data do |t|
      t.date     :date
      t.integer  :chest_id
      t.integer  :shoulder_id
      t.integer  :abdominal_id 
      t.integer  :bicep_id
      t.integer  :tricep_id
      t.integer  :hamstring_id
      t.integer  :quad_id
      t.integer  :treadmill_id
      t.integer  :elliptical_id
      t.integer  :upper_back_id
      t.integer  :lower_back_id
      t.integer  :forearm_id
      t.integer  :user_id

      t.timestamps
    end
  end
end
