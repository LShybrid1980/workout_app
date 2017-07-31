class CreateWorkoutData < ActiveRecord::Migration[5.1]
  def change
    create_table :workout_data do |t|
      t.date :date

      t.timestamps
    end
  end
end
