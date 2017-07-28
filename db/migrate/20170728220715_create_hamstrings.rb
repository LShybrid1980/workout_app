class CreateHamstrings < ActiveRecord::Migration[5.1]
  def change
    create_table :hamstrings do |t|

      t.timestamps
    end
  end
end
