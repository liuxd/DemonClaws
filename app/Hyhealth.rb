require 'nokogiri'
require 'open-uri'
require 'sqlite3'

class Hyhealth
  @@instance = Hyhealth.new
  @@folder = ''
  @@db = ''

  private_class_method :new

  def run url = '', page_size = '', folder = ''
    get_brand_list.each do |brand_url|
      @@db = SQLite3::Database.new '/Users/allen/Downloads/product.db'
      handle_product_list(brand_url)
      @@db.close
      sleep 1
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
    brand_name = ''

    # get brand name
    doc.css('.info h1').each do |div|
      brand_name = div.text
    end

    p brand_name

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
    types = [brand_name]

    doc.css('.goodsname').each do |e|
      name_cn = e.text
    end

    doc.css('.goods-detail-pic').each do |e|
      image_url = e['bigpicsrc']
    end

    doc.css('.Navigation a').each do |e|
      if e.text != '首页'
        types.push e.text
      end
    end

    sql = 'INSERT INTO product_info (name_cn, image_url) VALUES ("' + name_cn + '","' + image_url +'")'
    product_id = db_insert sql

    download image_url, $current_path + 'img/hy/', product_id.to_s + '.jpg'

    types.each do |type|
      sql_query_tag = 'SELECT tag_id FROM tag_info WHERE tag_name = "' + type +'"'
      stm = @@db.prepare sql_query_tag
      rs = stm.execute
      tag_id = ''

      rs.each do |e|
        tag_id = e[0].to_i
      end

      stm.close

      if tag_id == ''
        sql_tag = 'INSERT INTO tag_info (tag_name) VALUES ("' + type +'")'
        tag_id = db_insert sql_tag
      end

      sql_map = 'INSERT INTO product_tag (product_id, tag_id) VALUES (' + product_id.to_s + ', ' + tag_id.to_s + ')'
      db_insert sql_map
    end
  end

  def db_insert sql
    @@db.execute sql
    @@db.last_insert_row_id
  end

  def self.instance
    return @@instance
  end
end

# end of this file
