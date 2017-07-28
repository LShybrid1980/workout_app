class CreateChests < ActiveRecord::Migration[5.1]
  def change
    create_table :chests do |t|

      t.timestamps
    end
  end
end
