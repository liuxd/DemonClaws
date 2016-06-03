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
  'www.3dmgame.com' => "Threedm"
}

class_name = class_mapping[url_info.host]

def download img_url, folder
  if !File.exists? folder
    Dir.mkdir folder
  end

  File.open(folder + File.basename(img_url), 'wb'){ |f|
    f.write(open(img_url).read)
  }
end

img_folder = $current_path + 'img/'

if !File.exists? img_folder
  Dir.mkdir img_folder
end

require app + class_name

cls = Object.const_get class_name.capitalize
obj = cls.instance
obj.run url, page_size, folder