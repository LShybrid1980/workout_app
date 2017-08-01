class CreateShoulders < ActiveRecord::Migration[5.1]
  def change
    create_table :shoulders do |t|
      t.string   :name
      t.integer  :weight
      t.integer  :set
      t.integer  :rep

      t.timestamps
    end
  end
end
