class Main
  get '/mockups' do
    @mockups = Mockup.all
    haml :'mockups/index'
  end

  get '/mockup/:name' do |name|
    @mockup = Mockup[name]  or not_found
    haml :"mockups/#{@mockup}"
  end
end

class Mockup
  attr_reader :name

  alias to_s name

  def self.all
    list = Dir[path('*.haml')]
    list.map!    { |fname| File.basename(fname, '.*') }
    list.reject! { |fname| fname[0..0] == '_' || fname == 'index' }
    list.map!    { |fname| Mockup[fname] }
    list
  end

  def self.[](name)
    m = new name
    m if m.exists?
  end

  def initialize(name)
    @name = name
  end

  def exists?
    File.file? fname
  end

  def fname
    self.class.path "#{@name}.haml"
  end

  def self.path(*a)
    File.join Main.root('app/views/mockups'), *a
  end
end
