class ImagesController < ApplicationController
    #skip_before_action :verify_authenticity_token

    def getAll
        
        images = Image.all

        render json: images

    end

end
