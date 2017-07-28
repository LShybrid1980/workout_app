class CreateLowerBodies < ActiveRecord::Migration[5.1]
  def change
    create_table :lower_bodies do |t|

      t.timestamps
    end
  end
end
