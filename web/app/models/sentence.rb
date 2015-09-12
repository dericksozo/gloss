class Sentence < ActiveRecord::Base
	has_many :users, through: :user_sentences
	has_many :user_sentences
end
