class CreateLegs < ActiveRecord::Migration[5.1]
  def change
    create_table :legs do |t|
      t.integer  :hamstring_id
      t.integer  :calf_id
      t.integer  :quad_id

      t.timestamps
    end
  end
end
