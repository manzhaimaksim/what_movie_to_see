module FilmCollection
  def self.from_list
    page_url = 'https://www.kinopoisk.ru/top/navigator/m_act[num_vote]/1000/m_act[is_film]/on/order/rating/perpage/200/#results'
    html_page = page_url.gsub('[', '%5B').gsub(']', '%5D')

    films = []
    doc = Nokogiri::HTML(URI.open(html_page))

    doc.css('div .item').each do |film|
      title = film.css('.info .name a').text
      director = film.css('.info .gray_text i .lined').text
      year = film.css('.info .name span').text.split(' ').find { |string| string.match('\([0-9]{4}\)') }
      year.delete!('()') unless year.nil?

      unless title.empty? && director.empty? && year.nil?
        films << Film.new(title, director, year)
      end
    end
    films
  end

  def self.directors(films)
    films.map(&:director).uniq.sort
  end
end
