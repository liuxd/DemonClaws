require 'nokogiri'
require 'open-uri'

# eg: ./main.rb dbm 1 dbm

class Dbm
  @@instance = Dbm.new
  @@folder = ''
  private_class_method :new

  def run url, page_size, folder
    @@folder = folder

    url_list = [
      'http://tieba.baidu.com/p/3809404549',
      'http://tieba.baidu.com/p/3809412708',
      'http://tieba.baidu.com/p/3809419029',
      'http://tieba.baidu.com/p/3809908839',
      'http://tieba.baidu.com/p/3809918107',
      'http://tieba.baidu.com/p/3810656880',
      'http://tieba.baidu.com/p/3810672000',
      'http://tieba.baidu.com/p/3337878061',
      'http://tieba.baidu.com/p/3337898481',
      'http://tieba.baidu.com/p/3338048833',
      'http://tieba.baidu.com/p/3338081041',
      'http://tieba.baidu.com/p/3339568013',
      'http://tieba.baidu.com/p/3341890487',
      'http://tieba.baidu.com/p/3344612148',
      'http://tieba.baidu.com/p/3345211980',
      'http://tieba.baidu.com/p/3345240419',
      'http://tieba.baidu.com/p/3345255088',
      'http://tieba.baidu.com/p/3347711672',
      'http://tieba.baidu.com/p/1122415772',
      'http://tieba.baidu.com/p/1538104807',
      'http://tieba.baidu.com/p/3350007793',
      'http://tieba.baidu.com/p/3361314379',
      'http://tieba.baidu.com/p/3361352072',
      'http://tieba.baidu.com/p/3361398762',
      'http://tieba.baidu.com/p/3361592805',
      'http://tieba.baidu.com/p/3362122284',
      'http://tieba.baidu.com/p/3362251819',
      'http://tieba.baidu.com/p/3362449465',
      'http://tieba.baidu.com/p/3365798993',
      'http://tieba.baidu.com/p/2092813835',
      'http://tieba.baidu.com/p/2198951567',
      'http://tieba.baidu.com/p/2292763671',
      'http://tieba.baidu.com/p/2382401000',
      'http://tieba.baidu.com/p/3365839515',
      'http://tieba.baidu.com/p/3365861700',
      'http://tieba.baidu.com/p/2686291113',
      'http://tieba.baidu.com/p/2774844806',
      'http://tieba.baidu.com/p/2855052130',
      'http://tieba.baidu.com/p/2953964548',
      'http://tieba.baidu.com/p/3072725737',
      'http://tieba.baidu.com/p/3183792441',
      'http://tieba.baidu.com/p/3314021881',
      'http://tieba.baidu.com/p/3437519360',
      'http://tieba.baidu.com/p/3514825805',
      'http://tieba.baidu.com/p/3617737370',
      'http://tieba.baidu.com/p/3735327013',
      'http://tieba.baidu.com/p/3873960805',
      'http://tieba.baidu.com/p/3995472326',
      'http://tieba.baidu.com/p/4116423539',
      'http://tieba.baidu.com/p/4249315133',
      'http://tieba.baidu.com/p/4371265140',
      'http://tieba.baidu.com/p/4494934100',
      'http://tieba.baidu.com/p/4621061990',
      'http://tieba.baidu.com/p/4745051551',
      'http://tieba.baidu.com/p/4843292979'
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

    order = 1

    doc.css('img.BDE_Image').each do |e|
      img_url = e.to_h['src']
      download img_url, $current_path + 'img/' + @@folder + '/' + k.to_s + '/', order.to_s + '.jpg'
      order += 1
    end
  end

  def self.instance
    return @@instance
  end
end

# end of this file
