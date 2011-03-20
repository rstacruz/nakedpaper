# This is spawned by the NN.Feed model
NN.FeedView = NN.View.extend
  events:
    'click .views a':  'onSwitchView'

  # The model (NN.Feed instance)
  # This is always set, don't worry
  model: null

  initialize: ->
    @$el      = $ @el
    @$entries = @$ '.entries'
    @$views   = @$ '.views'

    @subtypes =
      'line':    NN.LineFeedView
      'compact': NN.CompactFeedView

    @switchTo @subtypes['compact']

  # Switches to a given view.
  # @example  news.switchTo NN.LineFeedView
  switchTo: (view) ->
    @destroyView()

    # Switch
    _.extend this, view
    @$el.attr 'class', "news-pane feed #{@classname}"
    @buildView()

    @$view.ani 'fade in'

    # Activate the button
    @$views.find('.active').removeClass 'active'
    @$views.find("a[href=##{@classname}]").addClass 'active'

  # Removes the view pane from the DOM.
  # Called before switching.
  destroyView: ->
    view = @$ '.view'
    view.remove()

  # Override me if you need to.
  # This is expected to set @$view
  buildView: ->
    @$view = $("<div class='view'>")
    @$view.html @template('entries': @entries())

    @$el.append @$view

  # Gets the entries model. [NN.Entry[]]
  entries: ->
    @model.entries_list()

  onSwitchView: (e) ->
    $target = $(e.target)
    return false  if $target.is('.active')

    view    = $target.attr('href').substr(1)
    view    = @subtypes[view]

    @switchTo view  if view?
    false

NN.LineFeedView =
  classname: 'line'

  template:
    _.template """
    <% _.each(entries, function(entry) { %>
      <% e = entry.attributes; %>
      <article>
        <a href="<%= e.href %>">
          <span class="date">
            <%= e.published.toLocaleString() %>
          </span>
          <% if (e.image) { %>
            <span class="image" style="background-image:
              url(<%= e.image %>);"></span>
          <% } %>
          <strong>
            <%= e.title %>
          </strong>
          <div class="summary">
            <%= e.summary %>
          </div>
        </a>
      </article>
    <% }); %>
    """

NN.CompactFeedView =
  classname: 'compact'

  template:
    _.template """
    <% _.each(entries, function(entry) { %>
      <% e = entry.attributes; %>
      <article>
        <a href="<%= e.href %>">
          <% if (e.image) { %>
            <span class="image" href="<%= e.href %>" style="background-image: 
            url(<%= e.image %>);"></span>
          <% } %>

          <h2><%= e.title %></h2>

          <div class="summary"><%= e.summary %></div>
        </a>
      </article>
    <% }); %>
    """
