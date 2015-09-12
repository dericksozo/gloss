class ModifyTweetIdColumn < ActiveRecord::Migration
  def change
      change_column :sentences, :tweet_id, :integer, {limit: 18}
  end
end
