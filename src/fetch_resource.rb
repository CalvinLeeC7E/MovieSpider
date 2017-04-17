#coding:utf-8
require 'nokogiri'
require 'open-uri'
require 'iconv'
require './dom_parser'
class FetchResource
  attr_accessor :host

  def initialize
    self.host = 'http://www.ygdy8.net'
  end

  def get_html(url)
    html = open(url).read()
    html.encode 'utf-8', 'GB18030', {:invalid => :replace}
  end

  def get_doms(html)
    Nokogiri::HTML::Document.parse html
  end

  def fetch(url)
    get_doms(get_html(self.host + url))
  end

  def fetch_pages(size)
    url_addr = '/html/gndy/dyzz/index.html'
    DOMParser.pages_parser(fetch(url_addr))
        .map(&lambda { |item| item['value'] }).slice(0, size)
  end

  def fetch_movies
    url_addr = '/html/gndy/dyzz/'
    movies = fetch_pages(3).inject([]) do |result, url|
      result.concat DOMParser.movie_parser(fetch(url_addr+url))
                        .map(&lambda { |item| Movie.new(item.content, item[:href]) })
    end
    fetch_movies_detail movies
    movies
  end

  def fetch_movies_detail(movies)
    movies.each do |item|
      imgs = DOMParser.movie_detail_parser(fetch(item.resource_addr)).map { |item| item[:src] }
      item.img_cover = imgs[0]
      item.pre_img = imgs[1]
      item.to_store
    end
  end

end