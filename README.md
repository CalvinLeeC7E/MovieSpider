# MovieSpider
![VERSION](https://img.shields.io/badge/VERSION-1.0.0-brightgreen.svg)
![RUBY](https://img.shields.io/badge/RUBY-2.3.1-green.svg)
![RAILS](https://img.shields.io/badge/RAILS-4.2.7-green.svg)
![MYSQL](https://img.shields.io/badge/MYSQL-5.7-green.svg)
[![weibo](https://img.shields.io/badge/weibo-DeveloperLee-blue.svg)](http://weibo.com/DeveloperLee)

Rails实现的电影信息爬虫，爬取国内一些电影网站，并结合DouBanApi获取电影评分。

向前端提供RESTful风格的API。


更新日志
-------
V 1.0.0 线上基础功能可用版

运行环境
-------
采用Docker部署，镜像使用[网易蜂巢](https://c.163.com/)，下载速度快，支持线上基于Dockerfile构建镜像。

对于不了解Docker的朋友，也可本地安装如下环境。

ruby 2.3.1

```bash
$ docker pull hub.c.163.com/library/ruby:2.3.1
```

mysql 5.7

```bash
$ docker pull hub.c.163.com/library/mysql:5.7
```

nginx 1.13.0

```bash
$ docker pull hub.c.163.com/library/nginx:1.13.0
```

前端截图
-------
![MovieSpider](http://7xisw0.com1.z0.glb.clouddn.com/github_screenshot_moviespider.png_small) 

声明
-------
此项目仅用于学习和练习，所有内容不提供商业化，不提供下载途径，最后请支持正版电影。