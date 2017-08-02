class CreateTreadmills < ActiveRecord::Migration[5.1]
  def change
    create_table :treadmills do |t|
      t.string   :status_type
      t.integer  :speed
      t.integer  :time
      t.integer  :incline
      t.float    :distance

      t.timestamps
    end
  end
end