require 'nokogiri'
require 'open-uri'

class Hyhealth
  @@instance = Hyhealth.new
  @@folder = ''
  private_class_method :new

  def run url = '', page_size = '', folder = ''

    save "http://hyhealth.co.nz/?product-7207.html", '茱莉蔻'
    exit
    # @todo

    get_brand_list.each do |brand_url|
      handle_product_list(brand_url)
    end
  end

  def get_brand_list
    brand_list_url = 'http://hyhealth.co.nz/?brand-showList.html'
    doc = Nokogiri::HTML.parse Net::HTTP.get(URI(brand_list_url))

    result = []

    doc.css('.brandLogo a').each do |d|
      result.push 'http://hyhealth.co.nz/' + d['href']
    end

    result
  end

  def handle_product_list brand_url
    doc = Nokogiri::HTML.parse Net::HTTP.get(URI(brand_url))

    # get brand name
    doc.css('.info h1').each do |div|
      brand_name = div.text
    end

    # get product_url_list
    page_totel = doc.css('.pagernum a').children().length + 1
    url_base = brand_url.sub '.html', ''

    page_totel.times.each do |page|
        product_list_url = url_base + '-' + (page + 1).to_s + '.html'

        get_product_url(product_list_url).each do |url|
          save url, brand_name
        end
    end
  end

  def get_product_url product_list_url
    doc = Nokogiri::HTML.parse Net::HTTP.get(URI(product_list_url))
    result = []

    doc.css('.goodpic a').each do |e|
      result.push 'http://hyhealth.co.nz/' + e['href']
    end

    result
  end

  def save product_url, brand_name
    doc = Nokogiri::HTML.parse Net::HTTP.get(URI(product_url))
    name_cn = ''
    image_url = ''
    types = []

    doc.css('.goodsname').each do |e|
      name_cn = e.text
    end

    doc.css('.goods-detail-pic').each do |e|
      image_url = e['bigpicsrc']
    end

    p name_cn, image_url
    # p data = Net::HTTP.get(URI(image_url))

    doc.css('.Navigation a').each do |e|
      if e.text != '首页'
        types.push e.text
      end
    end

    p types

    # @todo
  end

  def self.instance
    return @@instance
  end
end

# end of this file
