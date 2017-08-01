class CreateAbdominals < ActiveRecord::Migration[5.1]
  def change
    create_table :abdominals do |t|
      t.string   :name
      t.integer  :set
      t.integer  :rep

      t.timestamps
    end
  end
end
