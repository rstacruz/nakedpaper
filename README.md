# Nakedpaper
#### Google Reader interface.

### Configure

You may set OAuth config via ENV variables:

    heroku config:add OAUTH_KEY=consumer_key.com
    heroku config:add OAUTH_SECRET=secret_here
    # (or otherwise export these vars)

Or via a config file (see that file for details):

    cp  config/oauth.defaults.rb config/oauth.rb
    vim config/oauth.rb

### Development setup

Do the configuration things above, then do the Bundler dance:

    rvm --rvmrc --create 1.9.2@nakedreader
    bundle install

If the GReader gem is actively being developed alongside this,
add the GReader gem somewhere in vendor/.

    ln -s ~/Projects/greader vendor/gems/greader-dev

Start:

    rake start   # or rackup/thin start/unicorn/etc
    rake test

### Deployment

Do the configuration things, then run as a Rack app.
