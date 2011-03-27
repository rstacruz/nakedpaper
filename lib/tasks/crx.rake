desc "Builds the Chrome extension [Project]"
task(:build_crx) {
  file = "public/nakedpaper_chrome.zip"
  File.unlink file  if File.file?(file)
  system "zip #{file} chrome_app/*"
  puts "* #{file}"
}
