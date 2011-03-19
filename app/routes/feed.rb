class Main
  get '/feed/:feed' do |feed|
    @feed    = client.feed(feed) or not_found
    @entries = @feed.entries(limit: 7)

    haml :'news/feed'
  end

  get '/feed/:feed/entry/:entry' do |feed, entry|
    @feed    = client.feed(feed) or not_found
    @entry   = @feed.entries[entry]  or not_found

    haml :'news/entry'
  end

  get '/_feeds' do
    partial :'news/_feeds', tags: client.tags
  end
end
