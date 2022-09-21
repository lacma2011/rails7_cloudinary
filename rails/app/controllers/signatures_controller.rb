class SignaturesController < ApplicationController
    #skip_before_action :verify_authenticity_token
     def initialize
        @upload_folder = 'signed_uploads';
        @perm_folder = 'rails7_app_demo'
     end
     
    def new

        # TODO: get User ID from Token-based Authentication
        # make file name for new upload from that        
        user_id = getUserId
        
        config = Rails.application.config_for(:cloudinary)
        api_secret = config.api_secret
        params_to_sign = Hash.new
        params_to_sign["timestamp"] = Time.now.to_i
        params_to_sign["source"] = "profile_#{user_id}"
        params_to_sign["folder"] = @upload_folder
        signature = Cloudinary::Utils.api_sign_request(params_to_sign, api_secret)

        return_value = params_to_sign
        return_value['signature'] = signature
        render json: return_value
    end

    
    def processUpload
        
        asset_id = params[:asset_id]
        public_id = params[:public_id]

        chunks = public_id.split(@upload_folder + '/')
        if chunks.length() != 2 then
            raise "error"
        end
        id_only = chunks[1]

        new_public_id = @perm_folder + '/' + id_only

        user_id = getUserId

        Cloudinary::Uploader.rename(public_id, new_public_id)

        res = Cloudinary::Api.resources_by_ids([new_public_id])["resources"][0]

        image = Hash.new
        image['asset_id'] = res["asset_id"]
        image['user_id'] = user_id
        image['public_id'] = res["public_id"]
        image['url'] = res["url"]
        image['secure_url'] = res["secure_url"]

        Image.create(image)
        
        render json: image

    end


    def getUserId
        # TODO: get User ID from Token-based Authentication
        # make file name for new upload from that        
        return rand(1..20)
    end
end
