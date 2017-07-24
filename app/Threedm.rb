require 'nokogiri'
require 'open-uri'

# Get image from http://www.3dmgame.com.
# eg: ./main.rb http://www.3dmgame.com/news/201503/3463462.html 7 onepiece3

class Threedm
  @@instance = Threedm.new
  @@folder = ''
  private_class_method :new

  def run url, page_size, folder
    @@folder = folder

    url_prefix = url[0..-6]
    url_suffix = '.html'

    (0..page_size.to_i).to_a.each do |n|
      page = n > 0 ? '_' + n.to_s : ''
      url = url_prefix + page + url_suffix

      handle Net::HTTP.get(URI(url))
    end
  end

  def handle data
    doc = Nokogiri::HTML.parse data

    doc.css('p a').each do |d|
      if d['href'].include? 'upload'
        url = 'http://www.3dmgame.com' + d['href']
        download url, $current_path + 'img/' + @@folder + '/'
      end
    end
  end

  def self.instance
    return @@instance
  end
end
