# Nakedpaper
#### Google Reader interface.

Setup
-----

Follow all these below.

1. Configuration
----------------

You may set OAuth config via ENV variables:

    export OAUTH_KEY=consumer_key.com
    export OAUTH_SECRET=secret_here
    # ...that's `heroku config:add` in Heroku

Or via a config file (see that file for details):

    cp  config/oauth.defaults.rb config/oauth.rb
    vim config/oauth.rb

2. Development setup
--------------------

(Skip this section if you don't want to set up a local copy.)

Do the configuration things above, then do the Bundler dance:

    rvm --rvmrc --create 1.9.2@nakedpaper
    bundle install

If the GReader gem is actively being developed alongside this,
add the GReader gem somewhere in vendor/.

    ln -s ~/Projects/greader vendor/gems/greader

Start:

    rake start   # or `rackup`, `thin start`, etc
    rake test

3. Deployment
-------------

Do the configuration things, then run as a Rack app via Passenger/Heroku/etc.

To deploy to Heroku (and other hosts without CoffeeScript support), do
`rake freeze` to freeze the JS/CSS files first.
