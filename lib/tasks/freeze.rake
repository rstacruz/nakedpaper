def session
  @session ||= begin
    ENV['RACK_ENV'] = 'production'
    require 'fileutils'
    require 'rack/test'
    require './init'
    Rack::Test::Session.new(Main)
  end
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

desc "Do pre-deployment freezing [Project]"
task(:freeze) {
  bake! '/js/app.js'
  bake! '/css/style.css'
}
