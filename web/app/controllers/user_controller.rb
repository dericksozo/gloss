
class UserController < ApplicationController
    def create
    	uuid = SecureRandom.uuid
    	user = User.new({uuid: uuid, level: 2, count_left: 0, count_right: 0})

    	if user.save
        	render json: { uuid: uuid}
        else
        	render status: 500
        	render json: {error: "Oops something went wrong with user save"}
        end
    end


end
