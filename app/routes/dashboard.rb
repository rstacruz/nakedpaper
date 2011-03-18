class Main
  get '/dashboard' do
    haml :dashboard
  end

  get '/feed/*' do |feed|
    @feed    = client.feed(feed) or not_found
    @entries = @feed.entries(limit: 7)

    haml :feed
  end
end
