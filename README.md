# TitaniumDogEye

Fetch the images from some websites.

### Website List

+ [http://www.ali213.net](http://www.ali213.net)
+ [http://www.3dmgame.com](http://www.3dmgame.com)
+ [http://www.sc115.com/](http://www.sc115.com/)

### Installation

```
git clone git@github.com:liuxd/TitaniumDogEye.git
cd TitaniumDogEye
bundle install
```

### Usage

```
cd TitaniumDogEye/src
./main.rb {url} {page_size} {image_foler_name}
```

### Example

```
./main.rb http://www.ali213.net/news/html/2015-8/171333.html 12 euro
./main.rb http://www.3dmgame.com/news/201503/3463462.html 7 onepiece3
```