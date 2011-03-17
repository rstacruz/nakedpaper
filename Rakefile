task(:test) {
  $:.unshift File.join(File.dirname(__FILE__), "test")

  require 'cutest'
  Cutest.run(Dir['./test/**/*_test.rb'])
}

task(:start) {
  system "ruby init.rb"
}

task(:irb) {
  irb = ENV['IRB_PATH'] || 'irb'
  system "#{irb} -r./init.rb"
}

