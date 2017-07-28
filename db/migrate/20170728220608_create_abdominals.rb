class CreateAbdominals < ActiveRecord::Migration[5.1]
  def change
    create_table :abdominals do |t|

      t.timestamps
    end
  end
end
