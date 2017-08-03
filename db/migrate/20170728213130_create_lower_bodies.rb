class CreateLowerBodies < ActiveRecord::Migration[5.1]
  def change
    create_table :lower_bodies do |t|
      t.integer  :abdominal_id
      t.integer  :lower_back_id

      t.timestamps
    end
  end
end
