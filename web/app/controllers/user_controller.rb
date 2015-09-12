
require 'securerandom'

class UserController < ApplicationController
    def create
        render json: { uuid: SecureRandom.uuid }
    end

end
