class Main
  get '/feed/*' do |feed|
    @feed    = client.feed(feed) or not_found
    @entries = @feed.entries(limit: 7)

    haml :feed
  end

  get '/_feeds' do
    partial :_feeds, tags: client.tags
  end
end
