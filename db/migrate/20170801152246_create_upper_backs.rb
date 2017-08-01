class CreateUpperBacks < ActiveRecord::Migration[5.1]
  def change
    create_table :upper_backs do |t|
      t.string   :name
      t.integer  :weight
      t.integer  :set
      t.integer  :rep

      t.timestamps
    end
  end
end
