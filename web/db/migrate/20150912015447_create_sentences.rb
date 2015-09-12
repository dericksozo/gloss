class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.text :sentence
      t.integer :level

      t.timestamps null: false
    end
  end
end
