  desc "Clear profiles folder"
  task clear_profiles_folder: :environment do
    images = Array.new
    result = Cloudinary::Search
              .expression('folder="rails7_app_demo"')
              .sort_by('public_id','desc')
              .max_results(1000)
              .execute        
    result["resources"].each do |image|
      images << image["public_id"]
    end
    #logger = Logger.new(STDOUT)
    #logger.debug images
    if images.length > 0
      Cloudinary::Api.delete_resources(images)
    end
  end