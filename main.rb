require 'nokogiri'
require 'open-uri'

require_relative 'lib/film'
require_relative 'lib/film_collection'

PAGE_URL = "https://www.kinopoisk.ru/top/navigator/m_act[num_vote]/1000/m_act[is_film]/on/order/rating/perpage/200/#results"

films = FilmCollection.from_list(PAGE_URL.gsub("[","%5B").gsub("]","%5D"))

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
