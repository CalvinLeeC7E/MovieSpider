#coding:utf-8
require 'active_record'
require './movie'
require './fetch_resource'
require 'sinatra'

ActiveRecord::Base.establish_connection(
    :adapter => 'mysql2',
    :database => 'MovieSpider', #oracle service name
    :username => 'root',
    :password => 'superman',
    :pool => 5,
    :reconnect => true)

after do
  ActiveRecord::Base.connection.close
end

get '/' do
  fetch_res = FetchResource.new
  @movies = fetch_res.fetch_movies
  # htmls.join('<br>')
  html = <<HTML
%table{border:1}
  %thead
    %tr
      %td 年份
      %td 封面
      %td 名称
      %td 描述
      %td 分辨率
      %td 语言
      %td url
  -@movies.each do |item|
    %tr
      %td= item.year
      %td
        %img{src:item.img_cover,style:'width:80'}
      %td= item.title
      %td= item.des
      %td= item.resolution
      %td= item.language
      %td= item.resource_addr
HTML

  haml html
end
