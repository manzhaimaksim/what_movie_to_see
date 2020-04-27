class FilmCollection
  def self.from_list
    films_list = []
    uri = ''
    doc = Nokogiri::HTML(open(uri))

    doc.css('table#itemList .news').each do |film|
      title = film.css('.all').text
      director = film.at_css('.gray_text a').text
      year = film.css('span').text.split(' ').find { |string| string.match('\([0-9]{4}\)') }.delete('()')

      films_list << Film.new(title, director, year)
    end
    films_list
  end

  def initialize
    @collection = []
  end
end
