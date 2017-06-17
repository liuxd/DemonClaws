# DemonClaws

Another simple crawler framework.

### Website List

+ [http://www.ali213.net](http://www.ali213.net)
+ [http://www.3dmgame.com](http://www.3dmgame.com)
+ [http://www.sc115.com/](http://www.sc115.com/)
+ [Dragonball multiverse](http://tieba.baidu.com/p/3345173889?pn=1) - Usage : `./main.rb dbm 1 dbm`
+ [Fire Emblem Blog](https://fireemblemblog.wordpress.com) - Usage : `./main.rb feblog 1 feblog`
+ [http://www.laravelpodcast.com/episodes](http://www.laravelpodcast.com/episodes) - Usage : `./main.rb http://www.laravelpodcast.com/episodes  1 1`

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
