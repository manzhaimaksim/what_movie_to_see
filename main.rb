require 'nokogiri'
require 'open-uri'

require_relative 'lib/film'
require_relative 'lib/film_collection'

films = FilmCollection.from_list
all_directors = films.map(&:director)

puts "Программа 'Фильм на вечер'"

list_of_directors = all_directors.uniq.sort

list_of_directors.each_with_index do |director, index|
  puts "#{index + 1}. #{director}"
end

puts
puts 'Фильм какого режиссера вы хотите сегодня посмотреть?'

user_input = 0

until user_input.between?(1, list_of_directors.size)
  puts "Введите число от 1 до #{list_of_directors.size}"
  user_input = STDIN.gets.to_i
end

puts
puts 'И сегодня вечером рекомендую посмотреть:'
puts films.select { |film| film.director == list_of_directors[user_input.to_i - 1] }.sample
