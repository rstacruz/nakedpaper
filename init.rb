ENV['RACK_ENV'] ||= 'development'

# Bundler
require "bundler"
Bundler.require :default, ENV['RACK_ENV'].to_sym

# Plugins
$:.unshift *Dir["./vendor/plugins/*/lib"]
require "rtopia"
require "jsfiles"
require "user_agent"

# Explicitly use a development version of greader
greader_path = './vendor/gems/greader/lib/greader.rb'
require greader_path  if File.file? greader_path

unless defined?(GReader)
  puts "*** Unable to load the greader gem."
  puts "    See the README for details."
  exit
end

class Main < Sinatra::Base
  set      :root, lambda { |*args| File.join(File.dirname(__FILE__), *args) }
  set      :views, root('app', 'views')
  set      :run, lambda { __FILE__ == $0 and not running? }

  enable   :raise_errors, :logging,
           :show_exceptions, :raise_errors

  use      Rack::Session::Pool

  helpers  Rtopia
  helpers  Sinatra::ContentFor        # sinatra-content_for
  helpers  Sinatra::UserAgentHelpers  # agentsniff

  # Load all, but load defaults first
  Dir[root('config', '{*.defaults,*}.rb')].uniq.each { |f| load f }

  configure :development do
    require 'pistol'
    use(Pistol, Dir["./{lib,app}/**/*.rb"]) { reset! and load(__FILE__) }
  end
end

# Set up OAuth
key    = Main.oauth_key    || ENV['OAUTH_KEY']
secret = Main.oauth_secret || ENV['OAUTH_SECRET']

Main.set :oauth, !(key.nil? || secret.nil?)

if Main.oauth?
  Main.use OmniAuth::Builder do
    provider :google, key, secret, scope: "http://www.google.com/reader/api"
  end
else
  puts "*** You need to enter the Google OAuth key/secret."
  puts "*** See config/oauth.defaults.rb for details."
end

Dir["./{lib,app/**}/*.rb"].each { |rb| require rb }

Main.set :port, ENV['PORT'].to_i  unless ENV['PORT'].nil?
Main.run!  if Main.run?
