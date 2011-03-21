NN.Workspace = Backbone.Controller.extend
  routes:
    'feed/:feed/entry/:entry': 'entry'
    '*path': 'load'

  load: (path) ->
    NN.loader.start()

    # If it already exists, use it
    $news  = $("#news-panes > [data-source='/#{path}']")
    exists = !! $news.length

    if exists
      # Back
      console.log "Cache hit for /#{path}"
      @_switchPane $news

    else
      # Prepare it
      $.get '/'+path, (data) =>
        $data = $("<div>").html(data)

        # Build it and put some metadata
        $news = $("<div>")
        $news.attr 'data-source', "/#{path}"
        $news.attr 'data-all-class', $data.find('#all').attr('class')
        $news.attr 'class', $data.find('#news').attr('class')

        # Push it hidden
        $news.hide().html $data.find("#news").html()
        @_loadPane $news

  entry: (feed_id, entry_id) ->
    feed  = NN.Feed.find(feed_id)
    entry = feed.entry(entry_id)

    # This should be `pass`...
    return true  unless entry.exists?

    view = new NN.EntryView(model: entry)
    NN.Page._loadPane $(view.el)

  _loadPane: ($news) ->
    # Add it
    $("#news-panes").append $news
    @_switchPane $news

  _switchPane: ($news) ->
    # Now lets transition
    $("#news").hide().removeAttr('id')
    $("#all").attr 'class', $news.attr('data-all-class')
    $news.attr 'id', 'news'
    $news.show()

    $(document).trigger 'after_navigate'

NN.Page = new NN.Workspace
Backbone.history.start()

$ ->
  $("#news").attr 'data-source', window.location.pathname
  $("#news").attr 'data-all-class', $("#all").attr('class')

# Model fetchers
$('.news-pane.feed').livequery ->
  id    = $(this).find('header').attr('data-feed_id')
  title = $(this).find('header h1').text()

  # Build the model
  feed = NN.Feed.find(id)
  feed.set title: title
  feed._updateEntries $(this).find('article')

  # Build the view
  feed.view ||= new NN.FeedView(el: this, model: feed)

$('.news-pane.entry').livequery ->
  new NN.EntryView el: this  unless $(this).is('[data-dynamic]')
