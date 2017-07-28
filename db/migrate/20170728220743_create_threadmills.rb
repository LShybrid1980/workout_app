class CreateThreadmills < ActiveRecord::Migration[5.1]
  def change
    create_table :threadmills do |t|

      t.timestamps
    end
  end
end
