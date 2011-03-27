# Nakedpaper
#### Google Reader interface.

Setup
-----

Set up config: (see *)

    cp  config/oauth.defaults.rb config/oauth.rb
    vim config/oauth.rb

Do the Bundler dance:

    rvm --rvmrc --create 1.9.2@nakedpaper
    bundle install

If the GReader gem is actively being developed alongside this,
add the GReader gem somewhere in `vendor/`:

    ln -s ~/Projects/greader vendor/gems/greader

Start:

    rake start   # or `rackup`, `thin start`, `ruby init.rb`, etc
    rake test

Deployment
----------

Use it as any other Rack up in Passenger/Thin/Unicorn/etc.

### Heroku deployment (*)

It's recommended that you do your Heroku stuff on a new branch
because we'll need to make some new files:

    git checkout -b heroku

It's better to use Heroku env vars to configure OAuth, instead of 
`config/oauth.rb` which you can't commit to the repo:

    heroku config:add OAUTH_KEY=your.key.com
    heroku config:add OAUTH_SECRET=abc123

You will also need to "freeze" assets by pre-converting Sass and Coffee
files into .js and .css:

    rake freeze

    # Assuming you're in the `heroku` branch:
    git add .
    git commit -m "Update assets."

    # If you need to get new updates:
    git pull --rebase . master

    # Deploy
    git push heroku heroku:master
