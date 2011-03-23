# Set up OAuth
key    = Main.oauth_key    || ENV['OAUTH_KEY']
secret = Main.oauth_secret || ENV['OAUTH_SECRET']

Main.set :oauth, !(key.nil? || secret.nil?)

if Main.oauth?
  Main.use OmniAuth::Builder do
    provider :google, key, secret, scope: "http://www.google.com/reader/api"
  end
else
  puts "*** You need to enter the Google OAuth key/secret."
  puts "*** See config/oauth.defaults.rb for details."
end

