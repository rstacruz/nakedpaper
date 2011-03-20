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
      @_loadPane $news

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
    view.render()

  _loadPane: ($news) ->
    # Add it
    $("#news-panes").append $news

    # Now lets transition
    $("#news").hide().removeAttr('id')
    $("#all").attr 'class', $news.attr('data-all-class')
    $news.attr 'id', 'news'
    $news.show()

    $(document).trigger 'after_navigate'

NN.Page = new NN.Workspace
Backbone.history.start()

# Model fetchers
$('.news-pane.feed').livequery ->
  id    = $(this).find('header').attr('data-feed_id')
  title = $(this).find('header h1').text()

  # Build the model
  model = NN.Feed.find(id)
  model._updateEntries $(this).find('article')
  model.set title: title

  # Build the view
  model.view = new NN.FeedView(el: this, model: model)
