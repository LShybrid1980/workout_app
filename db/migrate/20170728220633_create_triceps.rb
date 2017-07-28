class CreateTriceps < ActiveRecord::Migration[5.1]
  def change
    create_table :triceps do |t|

      t.timestamps
    end
  end
end
