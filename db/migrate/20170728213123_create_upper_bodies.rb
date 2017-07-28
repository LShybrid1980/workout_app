class CreateUpperBodies < ActiveRecord::Migration[5.1]
  def change
    create_table :upper_bodies do |t|

      t.timestamps
    end
  end
end
