require 'nokogiri'
require 'open-uri'

# Get image from http://www.sc115.com/.

class Sc115
  @@instance = Sc115.new
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

    doc.css('p a img').each do |d|
      img_url = d['src']
      download img_url, $current_path + 'img/' + @@folder + '/'
    end
  end

  def self.instance
    return @@instance
  end
end

# end of this file
