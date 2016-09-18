require 'nokogiri'
require 'open-uri'

class Laravel
  @@instance = Laravel.new
  @@folder = ''
  private_class_method :new

  def run url, page_size, folder
    @@folder = folder

    handle Net::HTTP.get(URI(url))
  end

  def handle data
    doc = Nokogiri::HTML.parse data

    doc.css('h3.podcast-episode-title a').each do |d|
      url = 'http://www.laravelpodcast.com' + d.to_h['href']
      res = Net::HTTP.get(URI(url))
      doc_info = Nokogiri::HTML.parse res
      mp3_url = doc_info.css('a.podcast-episode-download')[0].to_h['href']
      puts mp3_url
    end
  end

  def self.instance
    return @@instance
  end
end

# end of this file
