desc "Run tests"
task(:test) {
  Dir['./test/**/*_test.rb'].each { |f| load f }
}

desc "Start the server"
task(:start) {
  system "ruby init.rb"
}

desc "Open a console"
task(:irb) {
  irb = ENV['IRB_PATH'] || 'irb'
  system "#{irb} -r./init.rb"
}

task :default => :test

namespace :freeze do
  def session
    require './init'
    require 'fileutils'
    require 'rack/test'
    @session ||= Rack::Test::Session.new(Main)
  end

  def get(path)
    session.get(path).body
  end

  def bake!(path='/js/app.js')
    local = File.join('.', 'public', path)
    File.unlink local  if File.file?(local)

    body  = get(path)
    File.open(local, 'w') { |f| f.write body }

    puts "* #{local} (#{File.size(local)}b)"
  end

  desc "Freeze assets"
  task(:assets) {
    bake! '/js/app.js'
    bake! '/css/style.css'
  }
end

desc "Do pre-deployment freezing"
task :freeze => [ :'freeze:assets' ]
