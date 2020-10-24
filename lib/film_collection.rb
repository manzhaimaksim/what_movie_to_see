class FilmCollection
  def self.from_list(html_file)
    films_list = []
    uri = html_file
    doc = Nokogiri::HTML(open(uri))

    doc.css('div .item').each do |film|
      title = film.css('.info .name a').text
      director = film.css('.info .gray_text i .lined').text
      year = film.css('.info .name span').text.split(' ').find { |string| string.match('\([0-9]{4}\)') }
      year.delete!('()') unless year.nil?

      unless title.empty? && director.empty? && year.nil?
        films_list << Film.new(title, director, year)
      end
    end

    films_list
  end

  def initialize
    @collection = []
  end
end
