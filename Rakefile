desc "Run tests [Development]"
task(:test) {
  Dir['./test/**/*_test.rb'].each { |f| load f }
}

desc "Start the server [Development]"
task(:start) {
  system "ruby init.rb"
}

desc "Open a console [Development]"
task(:irb) {
  irb = ENV['IRB_PATH'] || 'irb'
  system "#{irb} -r./init.rb"
}

Dir['./lib/tasks/*.rake'].each { |f| load f }

task :default => :help
