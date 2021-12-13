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
                      poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
                      rating: movies["results"][i]["vote_average"])
  list = List.create!(name: movies["results"][i]["release_date"])
  Bookmark.create!(comment: "this is a test for a bookmark", movie_id: movie.id, list_id: list.id)
  i += 1
end
