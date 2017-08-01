class CreateUpperBacks < ActiveRecord::Migration[5.1]
  def change
    create_table :upper_backs do |t|

      t.timestamps
    end
  end
end
