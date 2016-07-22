#!/usr/bin/env ruby

require 'pathname'
require 'net/http'

$current_path = Pathname.new(File.dirname(__FILE__) + '/').realpath.to_s + '/'
app = Pathname.new($current_path + '/app').realpath.to_s + '/'

url = ARGV[0]
page_size = ARGV[1]
folder = ARGV[2]

url_info = URI.parse url

class_mapping = {
  "www.ali213.net" => "Ali213",
  'www.3dmgame.com' => "Threedm",
  'www.sc115.com' => 'Sc115',
  'dbm' => 'Dbm',
  'feblog' => 'FEBlog'
}

class_name = class_mapping[url_info.host]

if !class_mapping.include? url_info.host
  class_name = class_mapping[url]
end

# Download Function
def download img_url, folder, filename = nil
  if !File.exists? folder
    Dir.mkdir folder
  end

  if filename.nil?
    filename = File.basename(img_url)
  end

  File.open(folder + filename, 'wb'){ |f|
    begin
      data = open(img_url).read
    rescue OpenURI::HTTPError
    end

    if !data.nil?
      f.write(data)
    end
  }
end

$img_folder = $current_path + 'img/'

if !File.exists? $img_folder
  Dir.mkdir $img_folder
end

require app + class_name

cls = Object.const_get class_name.capitalize
obj = cls.instance
obj.run url, page_size, folder

# end of this file.
