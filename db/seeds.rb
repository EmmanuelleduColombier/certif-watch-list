# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

URL = "https://api.themoviedb.org/3/movie/top_rated?api_key=dfb68040430447137be70cab875f8f19&language=en-US&page=1"
movies_serialized = URI.open(URL).read
movies = JSON.parse(movies_serialized)

Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

i = 0
while i < 10
  movie = Movie.create!(title: movies["results"][i]["title"],
                      overview: movies["results"][i]["overview"],
                      poster_url: "https://image.tmdb.org/t/p/w200/#{movies["results"][i]["poster_path"]}",
                      rating: movies["results"][i]["vote_average"])
  i += 1
end
