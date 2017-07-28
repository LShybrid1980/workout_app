class CreateShoulders < ActiveRecord::Migration[5.1]
  def change
    create_table :shoulders do |t|

      t.timestamps
    end
  end
end
