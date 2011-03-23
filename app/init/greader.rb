# Explicitly use a development version of greader
greader_path = './vendor/gems/greader/lib/greader.rb'
require greader_path  if File.file? greader_path

unless defined?(GReader)
  puts "*** Unable to load the greader gem."
  puts "    See the README for details."
  exit
end

require 'normalizer'
GReader.html_processors << lambda { |str| Normalizer::normalize str }

