require 'nokogiri'
require 'open-uri'

# Get image from http://www.3dmgame.com.
# eg: ./main.rb http://www.3dmgame.com/news/201503/3463462.html 7 onepiece3

class Feblog
  @@instance = Feblog.new
  @@folder = ''
  private_class_method :new

  def run url, page_size, folder
    @@folder = folder

    url_list = [
      # 'https://fireemblemblog.wordpress.com/sword-of-seals/official-art-2/',
      # 'https://fireemblemblog.wordpress.com/blazing-sword/official-art/',
      # 'https://fireemblemblog.wordpress.com/radiant-dawn/official-art-high-res/',
      'https://fireemblemblog.wordpress.com/5-sacred-stones/official-art/'
    ]

    if !File.exists? $img_folder + folder
      Dir.mkdir $img_folder + folder
    end

    k = 1

    url_list.each do |url|
      handle Net::HTTP.get(URI(url)), k
      k += 1
    end
  end

  def handle data, k
    doc = Nokogiri::HTML.parse data

    doc.css('p a').each do |d|
      if d['href'].include? "files"
        img_url = d['href']
        download img_url, $current_path + 'img/' + @@folder + '/' + k.to_s + '/'
      end
    end
  end

  def self.instance
    return @@instance
  end
end
