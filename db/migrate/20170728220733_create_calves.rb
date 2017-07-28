class CreateCalves < ActiveRecord::Migration[5.1]
  def change
    create_table :calves do |t|

      t.timestamps
    end
  end
end
