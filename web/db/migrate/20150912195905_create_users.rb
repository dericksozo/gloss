class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.uuid :uuid
      t.integer :level
      t.integer :count_left
      t.integer :count_right

      t.timestamps null: false
    end
  end
end
