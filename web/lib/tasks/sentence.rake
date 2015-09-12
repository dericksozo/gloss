

namespace :sentence do
  desc "Fetches sentences from twitter streaming API, runs it through an algorithm, and saves it to the database."
  task fetch: :environment do

      TweetStream.configure do |config|
          config.consumer_key       = 'DNLnlWtIjnA27GXBiFLnIt9DV'
          config.consumer_secret    = '0JO30aiky7NnwJlbPbhwmjBTMYx9Amlf0Dbu2aooZx6NSKDQdT'
          config.oauth_token        = '912739170-jdckbGffV3OFDEDzvvLrISCgEcIdL2uqc3DTv57D'
          config.oauth_token_secret = 'YESyLtfFRo3uC6DbSD3jJFcsekLkeTUcaEwdvfnJcM7vi'
          config.auth_method        = :oauth
      end

      client = TweetStream::Client.new
      statuses = []

      client.sample( {language: 'ja', filter_level: 'low'} ) do |status, client|
            if !status.retweeted
                statuses << {
                    created_at: status.created_at,
                    text: status.text,
                    tweet_id: status.id
                }
            end
            client.stop if statuses.size >= 1000
        end
  end

end
