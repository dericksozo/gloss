class User < ActiveRecord::Base
	has_many :sentences, through: :user_sentences
	has_many :user_sentences
end
