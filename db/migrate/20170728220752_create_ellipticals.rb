class CreateEllipticals < ActiveRecord::Migration[5.1]
  def change
    create_table :ellipticals do |t|
      t.string   :name
      t.integer  :speed
      t.time     :time
      t.integer  :distance

      t.timestamps
    end
  end
end
