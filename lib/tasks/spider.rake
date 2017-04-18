# require 'spider/fetch_resource'
namespace :spider do
  task :run => [:environment] do
    fetch_res = Spider::FetchResource.new
    fetch_res.fetch_movies(10)
  end
end
