require 'nokogiri'
require 'open-uri'

# eg: ./main.rb dbm 1 dbm

class Dbm
  @@instance = Dbm.new
  @@folder = ''
  @@page_size = 1
  private_class_method :new

  def run url, page_size, folder
    @@folder = folder
    @@page_size = page_size

    ep = ARGV[3].to_i

    url_list = [
      'https://tieba.baidu.com/p/3809404549',
      'https://tieba.baidu.com/p/3809412708',
      'https://tieba.baidu.com/p/3809419029',
      'https://tieba.baidu.com/p/3809908839',
      'https://tieba.baidu.com/p/3809918107',
      'https://tieba.baidu.com/p/3810656880',
      'https://tieba.baidu.com/p/3810672000',
      'https://tieba.baidu.com/p/3337878061',
      'https://tieba.baidu.com/p/3337898481',
      'https://tieba.baidu.com/p/3338048833',
      'https://tieba.baidu.com/p/3338081041',
      'https://tieba.baidu.com/p/3339568013',
      'https://tieba.baidu.com/p/3341890487',
      'https://tieba.baidu.com/p/3344612148',
      'https://tieba.baidu.com/p/3345211980',
      'https://tieba.baidu.com/p/3345240419',
      'https://tieba.baidu.com/p/3345255088',
      'https://tieba.baidu.com/p/3347711672',
      'https://tieba.baidu.com/p/1122415772',
      'https://tieba.baidu.com/p/1538104807',
      'https://tieba.baidu.com/p/3350007793',
      'https://tieba.baidu.com/p/3361314379',
      'https://tieba.baidu.com/p/3361352072',
      'https://tieba.baidu.com/p/3361398762',
      'https://tieba.baidu.com/p/3361592805',
      'https://tieba.baidu.com/p/3362122284',
      'https://tieba.baidu.com/p/3362251819',
      'https://tieba.baidu.com/p/3362449465',
      'https://tieba.baidu.com/p/3365798993',
      'https://tieba.baidu.com/p/2092813835',
      'https://tieba.baidu.com/p/2198951567',
      'https://tieba.baidu.com/p/2292763671',
      'https://tieba.baidu.com/p/2382401000',
      'https://tieba.baidu.com/p/3365839515',
      'https://tieba.baidu.com/p/3365861700',
      'https://tieba.baidu.com/p/2686291113',
      'https://tieba.baidu.com/p/2774844806',
      'https://tieba.baidu.com/p/2855052130',
      'https://tieba.baidu.com/p/2953964548',
      'https://tieba.baidu.com/p/3072725737',
      'https://tieba.baidu.com/p/3183792441',
      'https://tieba.baidu.com/p/3314021881',
      'https://tieba.baidu.com/p/3437519360',
      'https://tieba.baidu.com/p/3514825805',
      'https://tieba.baidu.com/p/3617737370',
      'https://tieba.baidu.com/p/3735327013',
      'https://tieba.baidu.com/p/3873960805',
      'https://tieba.baidu.com/p/3995472326',
      'https://tieba.baidu.com/p/4116423539',
      'https://tieba.baidu.com/p/4249315133',
      'https://tieba.baidu.com/p/4371265140',
      'https://tieba.baidu.com/p/4494934100',
      'https://tieba.baidu.com/p/4621061990',
      'https://tieba.baidu.com/p/4745051551',
      'https://tieba.baidu.com/p/4843292979',
      'https://tieba.baidu.com/p/4955494816',
      'https://tieba.baidu.com/p/5024299402',
      'https://tieba.baidu.com/p/5123938929'
    ]

    if !File.exists? $img_folder + folder
      Dir.mkdir $img_folder + folder
    end

    if ep > 0
      handle url_list[ep - 1], ep
    else
      k = 1

      url_list.each do |url|
        handle url, k
        k += 1
      end
    end

  end

  def handle url, k
    puts url, k
    if k < @@page_size.to_i
      return
    end

    data = Net::HTTP.get(URI(url))
    doc = Nokogiri::HTML.parse data

    order = 1

    doc.css('img.BDE_Image').each do |e|
      img_url = e['src']

      if img_url.length != 120
        next
      end

      download img_url, $current_path + 'img/' + @@folder + '/' + k.to_s + '/', order.to_s + '.jpg'
      order += 1
    end
  end

  def self.instance
    return @@instance
  end
end

# end of this file
