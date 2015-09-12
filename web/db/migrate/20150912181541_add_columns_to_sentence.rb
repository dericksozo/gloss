class AddColumnsToSentence < ActiveRecord::Migration
  def change
      add_column :sentences, :tweet_created_at, :datetime
      add_column :sentences, :tweet_id, :integer
  end
end
