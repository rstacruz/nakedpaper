NN.Feed = NN.Model.extend
  # A list of entries. [NN.Entry[]]
  entries: {}

  # The associated view. [NN.FeedView]
  view: null

  # Fetches entries from the DOM.
  _updateEntries: ($articles) ->
    _.each $articles, ($e) =>
      $e    = $($e)
      id    = $e.attr('data-entry_id')

      entry = @entry(id)
      entry.feed = this
      entry.set
        href:      $e.find('>.title').attr('href')
        url:       $e.find('>.external').attr('href')
        title:     $e.find('>.title').html()
        image:     $e.find('>.image').attr('src')
        summary:   $e.find('>.summary').html()
        content:   $e.find('>.content').html()
        published: new Date(+$e.find('>.published').text())

      @entries[id] = entry

  entries_list: ->
    _.map @entries, (a) -> a

  path: ->
    "/feed/#{@id}"

  # Fetches an entry of a given ID.
  entry: (id) ->
    @entries[id] ||= new NN.Entry(id: id)

NN.Feed.cache = {}
NN.Feed.find  = (id) ->
  NN.Feed.cache[id] ||= new NN.Feed(id: id)

