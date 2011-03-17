ENV["RACK_ENV"] = "test"

require File.expand_path("../init", File.dirname(__FILE__))

begin
  # NB: Edit .gems if you add gems here.
  gem 'cutest', "~> 1.0"
  require "cutest"
  require "spawn"
  require "capybara/dsl"
rescue LoadError => e
  $stderr.write "Not all gems were able to load. (#{e.message.strip})\n"
  $stderr.write "Do `monk install` first, or install the gems in .gems yourself.\n"
  exit
end

Ohm.connect(db: 1)

prepare do
  Ohm.flush
  Capybara.app = Main.new
end

module Kernel
  def fixture(file)
    File.open Main.root("test", "fixtures", "files", file)
  end
  private :fixture
end

class Story < Cutest::Scope
  include Capybara

  alias :scenario :test

  # For cases where you want to directly post. Note that this only works for
  # rack-test.
  def post(path, *args)
    page.driver.post(path, *args)
    page.driver.follow_redirects!
  end

  # define your story helpers here
end

def story(&blk)
  Story.new(&blk).call
end
