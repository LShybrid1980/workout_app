class CreateCardios < ActiveRecord::Migration[5.1]
  def change
    create_table :cardios do |t|
      t.integer  :treadmill_id
      t.integer  :elliptical_id
      
      t.timestamps
    end
  end
end
