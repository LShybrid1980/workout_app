class CreateChests < ActiveRecord::Migration[5.1]
  def change
    create_table :chests do |t|
      t.string   :name
      t.integer  :weight
      t.integer  :set
      t.integer  :rep
      
      t.timestamps
    end
  end
end
