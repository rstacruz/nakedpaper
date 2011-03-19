source "http://rubygems.org"

gem "sinatra", require: "sinatra/base"
gem "ffaker"
gem "jsmin"
gem "haml", ">= 3.0"
gem "sinatra-content-for", require: "sinatra/content_for"
gem "maruku"
gem "rest-client", require: "rest_client"
gem "nokogiri"
gem "coffee-script", require: "coffee_script"
gem "omniauth"

if File.file?('Gemfile.local') && !ENV['HEROKU']
  eval File.read('Gemfile.local')
else
  gem "greader", git: "git://github.com/rstacruz/greader.git"
end
