class CreateForearms < ActiveRecord::Migration[5.1]
  def change
    create_table :forearms do |t|
      t.string   :status_type
      t.integer  :weight
      t.integer  :set
      t.integer  :rep

      t.timestamps
    end
  end
end
