class SentenceController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:swipe]
  
  def index
    user = User.where(uuid: params[:uuid]).first

    sentences = Sentence.find_by_sql(["SELECT * FROM sentences WHERE level = ? AND id NOT IN (SELECT sentence_id FROM user_sentences WHERE user_id = ?) LIMIT ?", user.level, user.id, params[:number].to_i])

    ids = sentences.map(&:id)

    relations = []
    ids.each do |id|
      relations << {user_id: user.id, sentence_id: id.to_i}
    end

    UserSentence.create(relations)

    render json: sentences
  end

  def swipe
    user = User.where(uuid: params[:uuid]).first

    if params[:understood] == 'true'
      understood = true
    else
      understood = false
    end

    if understood
      count_right = user.count_right + 1
      if count_right > 4
        user.count_right = 0
        user.level = user.level + 1
      else
        user.count_right = count_right
      end
    else
      count_left = user.count_left + 1
      if count_left > 4
        user.count_left = 0
        user.level = user.level - 1
      else
        user.count_left = count_left
      end
    end

    if user.save
      render json: { status: "Fresh" }
    else
    	render status: 500
    	render json: { error: "Oops SOMETHING went wrong" }
    end
  end
end
