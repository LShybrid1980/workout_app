class CreateCardios < ActiveRecord::Migration[5.1]
  def change
    create_table :cardios do |t|
      
      t.timestamps
    end
  end
end
