# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Person.create!(name:'Jess', email:'jess@place.com', username:'jess', password:'jess', city:'Los Angeles')
Person.create!(name:'Amy', email:'amy@place.com', username:'amy', password:'amy', city:'New York')
