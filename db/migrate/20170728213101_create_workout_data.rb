class CreateWorkoutData < ActiveRecord::Migration[5.1]
  def change
    create_table :workout_data do |t|

      t.timestamps
    end
  end
end
