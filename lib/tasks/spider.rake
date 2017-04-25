# require 'spider/fetch_resource'
namespace :spider do
  desc 'load new movies'
  task :run => [:environment] do
    fetch_res = Spider::FetchResource.new
    fetch_res.fetch_movies(10)
  end

  desc 'load movie rating from douban'
  task :update_douban => [:environment] do
    Spider::DouBanMovie.new().fetch_douban_ratings()
  end
end
