class ModifyTweetIdColumn < ActiveRecord::Migration
  def change
      change_column :sentences, :tweet_id, :bigint
  end
end
