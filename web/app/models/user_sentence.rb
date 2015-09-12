class UserSentence < ActiveRecord::Base
	belongs_to :user 
	belongs_to :sentence
end
