

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
      keyword = "日本"
      client.track(keyword, language: 'ja') do |status|
            puts "#{status.text}"
        end
  end

end
