class Main
  get '/dashboard' do
    haml :dashboard
  end

  get '/feed/*' do |feed|
    @feed = client.feed(feed)

    haml :feed
  end
end
