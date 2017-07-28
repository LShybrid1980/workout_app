class CreateBiceps < ActiveRecord::Migration[5.1]
  def change
    create_table :biceps do |t|

      t.timestamps
    end
  end
end
