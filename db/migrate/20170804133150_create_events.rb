class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.string     :event_type
      t.json       :details

      t.timestamps
    end
  end
end
