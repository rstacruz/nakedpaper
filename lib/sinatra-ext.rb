# CoffeeScript support.
#
# Adds a route for JavaScript files.
#
# == Example
#
#   register Sinatra::CoffeeSupport
#   serve_js '/js', from: root('app/views/js')
#
#   # reads app/views/js/jquery.{js,coffee}
#   $ curl "http://localhost:4567/js/jquery.js"
#
module Sinatra::CoffeeSupport
  def self.registered(app)
    app.set :js_max_age, 86400*30
  end

  def serve_js(url_prefix, options={})
    path   = File.join(url_prefix, '*.js')
    prefix = options[:from]

    get path do |name|
      fname = Dir[File.join(prefix, "#{name}.{js,coffee}")].first  or pass

      content_type :js
      last_modified File.mtime(fname)
      cache_control :public, :must_revalidate, :max_age => settings.js_max_age

      if fname =~ /\.coffee$/
        coffee File.read(fname)
      else
        send_file fname
      end
    end
  end
end

module Sinatra::CssSupport
  def self.registered(app)
    app.set :css_max_age, 86400*30
  end

  def serve_css(url_prefix, options={})
    path   = File.join(url_prefix, '*.css')
    prefix = options[:from]

    get path do |name|
      fname = Dir[File.join(prefix, "#{name}.{css,scss,less}")].first  or pass

      content_type :css, :charset => 'utf-8'
      last_modified File.mtime(fname)
      cache_control :public, :must_revalidate, :max_age => settings.js_max_age

      if fname =~ /\.scss$/
        scss File.read(fname)
      elsif fname =~ /\.scss$/
        sass File.read(fname)
      elsif fname =~ /\.less$/
        less File.read(fname)
      else
        send_file fname
      end
    end
  end
end
