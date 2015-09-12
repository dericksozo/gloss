class CreateUserSentences < ActiveRecord::Migration
  def change
    create_table :user_sentences do |t|
      t.integer :sentence_id
      t.integer :user_id 

      t.timestamps null: false
    end

    add_index :user_sentences, :sentence_id
    add_index :user_sentences, :user_id
  end
end
