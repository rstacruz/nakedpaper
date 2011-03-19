NN.Workspace = Backbone.Controller.extend
  routes:
    '*path':   'load'

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

        # Push it hidden
        $news.hide().html $data.find("#news").html()
        $("#news-panes").append $news

        @_loadPane $news

  _loadPane: ($news) ->
    # Now lets transition
    $("#news").hide().removeAttr('id')
    $("#all").attr 'class', $news.attr('data-all-class')
    $news.attr 'id', 'news'
    $news.show()

    $(document).trigger 'after_navigate'

new NN.Workspace
Backbone.history.start()
