class Main
  get '/js/app.js' do
    js = settings.js_files

    content_type :js
    last_modified js.mtime
    etag js.mtime.to_i
    cache_control :public, :must_revalidate, :max_age => 86400*30

    js.compressed
  end

  get '/js/:name.js' do |name|
    fname = Dir[Main.root("app/views/js/#{name}.{js,coffee}")].first  or not_found

    content_type :js
    last_modified File.mtime(fname)
    cache_control :public, :must_revalidate, :max_age => 86400*30

    if fname =~ /\.coffee$/
      coffee :"js/#{name}"
    else
      send_file fname
    end
  end
end
