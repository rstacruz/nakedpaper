NN.Workspace = Backbone.Controller.extend
  routes:
    '*path':   'load'

  load: (path) ->
    NN.loader.start()

    $.get '/'+path, (data) ->
      NN.loader.stop()

      $data = $("<div>").html(data)

      $("#all").attr 'class', $data.find('#all').attr('class')

      $("#news").html $data.find("#news").html()

new NN.Workspace
Backbone.history.start()
