class CreateUpperBodies < ActiveRecord::Migration[5.1]
  def change
    create_table :upper_bodies do |t|
      t.integer  :chest_id
      t.integer  :shoulder_id
      t.integer  :upper_back_id

      t.timestamps
    end
  end
end
