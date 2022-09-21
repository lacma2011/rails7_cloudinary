# README

Make a file at project root: ./.env containing the following cloudinary credentials:

CLOUDINARY_KEY="< Your Cloud Key >"

CLOUDINARY_SECRET="< Your Secret >"

CLOUDINARY_NAME="< Your Cloud Name >"


Be sure to start with docker-compose --env-file unless you have those variables in your environment already:

`docker-compose --env-file ./.env up`

`docker-compose down`



Note: this was once lacma2011/rails7_api_cloudinary which was private
