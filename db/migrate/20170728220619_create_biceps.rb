class CreateBiceps < ActiveRecord::Migration[5.1]
  def change
    create_table :biceps do |t|
      t.string   :status_type
      t.integer  :weight
      t.integer  :set
      t.integer  :rep

      t.timestamps
    end
  end
end
