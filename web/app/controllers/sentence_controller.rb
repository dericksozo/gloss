class SentenceController < ApplicationController
    def index
        render json: {stuff: 'things'}
    end
end
