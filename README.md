# Nakedpaper
#### Google Reader interface.

### Setup

    rvm --rvmrc --create 1.9.2@myproject
    bundle install

You may set OAuth config via ENV variables:

    heroku config:add OAUTH_KEY=consumer_key.com
    heroku config:add OAUTH_SECRET=secret_here

Or via a file (see that file for details):

    cp config/oauth.defaults.rb config/oauth.rb
    vim config/oauth.rb

