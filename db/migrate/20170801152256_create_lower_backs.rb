class CreateLowerBacks < ActiveRecord::Migration[5.1]
  def change
    create_table :lower_backs do |t|

      t.timestamps
    end
  end
end
