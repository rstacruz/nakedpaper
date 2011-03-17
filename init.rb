$:.unshift *Dir["./vendor/gems/*/lib"]

require "bundler"
Bundler.require :default

require "rtopia"
require "jsfiles"
require "user_agent"
require "greader"

class Main < Sinatra::Base
  set      :root, lambda { |*args| File.join(File.dirname(__FILE__), *args) }
  set      :views, root('app', 'views')
  set      :run, lambda { __FILE__ == $0 and not running? }

  enable   :raise_errors, :sessions, :logging,
           :show_exceptions, :raise_errors

  use      Rack::Session::Cookie
  helpers  Rtopia
  helpers  Sinatra::ContentFor        # sinatra-content_for
  helpers  Sinatra::UserAgentHelpers  # agentsniff

  set      :client, nil

  # Load all, but load defaults first
  Dir[root('config', '{*.defaults,*}.rb')].uniq.each { |f| load f }

  configure :development do
    require 'pistol'
    use(Pistol, Dir["./{lib,app}/**/*.rb"]) { reset! and load(__FILE__) }
  end
end

Dir["./{lib,app/**}/*.rb"].each { |rb| require rb }

Main.set :port, ENV['PORT'].to_i  unless ENV['PORT'].nil?
Main.run!  if Main.run?
