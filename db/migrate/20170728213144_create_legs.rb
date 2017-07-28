class CreateLegs < ActiveRecord::Migration[5.1]
  def change
    create_table :legs do |t|

      t.timestamps
    end
  end
end
