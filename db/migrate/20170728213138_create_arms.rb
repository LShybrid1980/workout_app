class CreateArms < ActiveRecord::Migration[5.1]
  def change
    create_table :arms do |t|

      t.timestamps
    end
  end
end
