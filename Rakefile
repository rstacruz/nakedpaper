task(:test) {
  Dir['./test/**/*_test.rb'].each { |f| load f }
}

task(:start) {
  system "ruby init.rb"
}

task(:irb) {
  irb = ENV['IRB_PATH'] || 'irb'
  system "#{irb} -r./init.rb"
}

task :default => :test
