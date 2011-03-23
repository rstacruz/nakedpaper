ENV['RACK_ENV'] ||= 'development'

# Loadables
$:.unshift *Dir["./vendor/plugins/*/lib"]
$:.unshift *Dir["./lib"]

# Bundler
require "bundler"
Bundler.require :default, ENV['RACK_ENV'].to_sym

class Main < Sinatra::Base
  set      :root, lambda { |*args| File.join(File.dirname(__FILE__), *args) }
  set      :run,  lambda { __FILE__ == $0 and not running? }
  set      :views, root('app', 'views')

  enable   :raise_errors, :logging
  enable   :show_exceptions, :raise_errors

  use      Rack::Session::Pool
end

# Load files
(Dir['./config/*.defaults.rb'] +
 Dir['./config/*.rb'] +
 Dir['./app/init/*.rb'] +
 Dir['./app/**/*.rb']
).uniq.each { |rb| require rb }

Main.set :port, ENV['PORT'].to_i  if ENV['PORT']
Main.run!  if Main.run?
