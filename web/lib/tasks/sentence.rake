require "obi/nagoyaobi.rb"

namespace :sentence do
  desc "Fetches sentences from twitter streaming API, runs it through an algorithm, and saves it to the database."
  task fetch: :environment do

    default = 'T13'
    dir   = "#{Rails.root}/lib/obi"
    frequency = 0
    char = "#{dir}/jchar.utf8"

    op_char = NagoyaObi.load_operative_character_file(char)

    model = NagoyaObi.load_model(default, dir, frequency)

    TweetStream.configure do |config|
        config.consumer_key       = 'DNLnlWtIjnA27GXBiFLnIt9DV'
        config.consumer_secret    = '0JO30aiky7NnwJlbPbhwmjBTMYx9Amlf0Dbu2aooZx6NSKDQdT'
        config.oauth_token        = '912739170-jdckbGffV3OFDEDzvvLrISCgEcIdL2uqc3DTv57D'
        config.oauth_token_secret = 'YESyLtfFRo3uC6DbSD3jJFcsekLkeTUcaEwdvfnJcM7vi'
        config.auth_method        = :oauth
    end

    client = TweetStream::Client.new
    statuses = []
    insert_count = 0
    client.sample( {language: 'ja', filter_level: 'low'} ) do |status, client|
          if !status.retweeted?

              words = ["#{status.text}"]
              statuses << {
                  tweet_created_at: status.created_at,
                  sentence: words,
                  tweet_id: status.id,
                  level: model.readability(words, nil, op_char, smoothing=nil).grade.to_i
              }
          end
          if statuses.size >= 250
              Sentence.create(statuses)
              statuses = []
              insert_count = insert_count + 1
          end
          client.stop if insert_count >= 400
      end





  end

end
