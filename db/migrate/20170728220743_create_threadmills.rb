class CreateThreadmills < ActiveRecord::Migration[5.1]
  def change
    create_table :threadmills do |t|
      t.string   :name
      t.integer  :speed
      t.time     :time
      t.integer  :incline
      t.float    :distance

      t.timestamps
    end
  end
end
