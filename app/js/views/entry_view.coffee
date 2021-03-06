# Can be instanciated as:
# new NN.EntryView model: ...
# new NN.EntryView el: ...
#
class NN.EntryView extends NN.View
  events:
    'click a.back':    'onBack'
    'click a.variant': 'onSwitchVariant'

  # The toolbar. (<nav.toolbar>)
  $toolbar: null

  # The 'you are reading:' thing. (<nav>)
  $nav: null

  initialize: ->
    @$el   = $ @el
    @$body = $ "body"

    @render()

  render: ->
    # Build the HTML if we're not given an element.
    if @model
      page = @templates.page
        entry:    @model
        feed:     @model.feed
        e:        @model.attributes

      @$el.html page

      # Standard issue for all news-pane views
      # (Usually populated remotely via the controller...
      # have to build it manually for this)
      @$el.attr 'class', 'news-pane entry'
      @$el.attr 'data-all-class', 'entry'
      @$el.attr 'data-dynamic',   'true'
      @$el.attr 'data-source',    @model.href

    $('body').scrollTop 0

    @_spawnToolbar()
    @_spawnNav()
    @_cureLinks()

  # Renders the nav thing.
  # (Delegate of render())
  _spawnNav: ->
    return true  unless @model

    @$nav = $ @templates.nav
      e:    @model.attributes
      next: @model.getNext()
      prev: @model.getPrev()
      feed: @model.attributes.feed

    @$el.append @$nav
    @$nav.ani 'fade in'

    @$nav.find('a').tipTip
      delay: 0, edgeOffset: 5, fadeIn: 80, maxWidth: "300px",
      defaultPosition: 'left'

  # Renders the toolbar.
  # (Delegate of render())
  _spawnToolbar: ->
    href = @$el.find('h1 a').attr('href')

    @$toolbar = $ @templates.toolbar
      href:  href

    @$el.append @$toolbar
    @$toolbar.ani 'slide in'

    @$toolbar.find('a').tipTip
      delay: 0, edgeOffset: 5, fadeIn: 80, maxWidth: "300px",
      defaultPosition: 'right'

  # Make all links open in a new window.
  _cureLinks: ->
    @$('a').each ->
      $this = $(this)
      return true  if $this.is('[href^=/]') or $this.is('[href^=#]')
      $(this).attr 'target', '_blank'

  # Switch a variant.
  # @example view.switchVariant 'font', 'large'
  switchVariant: (domain, variant) ->
    # Remove variants from the given domain.
    _.each @$body.attr('class').split(' '), (fragment) =>
      @$body.removeClass fragment  if fragment.substr(0, domain.length+1) == "#{domain}-"

    # Add it as font-large.
    @$body.addClass "#{domain}-#{variant}"

  # Change variants (large font, etc)
  onSwitchVariant: (e) ->
    [domain, variant] = $(e.target).attr('href').substr(1).split('/')

    @switchVariant domain, variant
    false

  onBack: (e) ->
    history.go -1
    false

  templates:
    page:
      _.template """
        <header>
          <div class='source'>
            <a href="<%= feed.path %>">
              <%= feed.attributes.title %>
            </a>
          </div>
          <h1>
            <a href="<%= e.url %>" rel="nofollow" target="_blank">
              <%= e.title %>
            </a>
          </h1>
        </header>

        <div class='contents'>
          <%= e.content %>
        </div>
      """

    nav:
      _.template """
        <nav class="nav">
          <% if (prev) { %>
            <a class='next' href="<%= prev.path %>">
              <span class='icon'>&lsaquo;</span>
              <small>Previous:</small>
              <strong><%= prev.attributes.title %></strong>
            </a>
            </dl>
          <% } %>

          <% if ((e.title) && (feed)) { %>
            <a class='status' href="<%= feed.path %>" title="Back to feed">
              <span class='icon'>&middot;</span>
              <strong><%= e.title %></strong>
              <small>from <%= feed.attributes.title %></small>
            </a>
          <% } %>

          <% if (next) { %>
            <a class='next' href="<%= next.path %>">
              <span class='icon'>&rsaquo;</span>
              <small>Next:</small>
              <strong><%= next.attributes.title %></strong>
            </a>
            </dl>
          <% } %>
        </nav>
      """

    toolbar:
      _.template """
        <nav class="toolbar">
          <nav>
            <a title="Back" href="#back" class="back">&lsaquo;</a>
          </nav>

          <% if (href) { %>
            <nav>
              <a title="View source" href="<%= href %>" target="_blank"   
              class="source" rel="nofollow">Src</a>
            </nav>
          <% } %>

          <nav>
            <a title="Small font" href="#size/small" class="variant size size-small">Aa</a>
            <a title="Medium font" href="#size/medium" class="variant size size-medium">Aa</a>
            <a title="Large font" href="#size/large" class="variant size size-large">Aa</a>
          </nav>

          <nav>
            <a title="Sans" href="#font/sans" class="variant font font-sans">Sn</a>
            <a title="Serif" href="#font/serif" class="variant font font-serif">Srf</a>
          </nav>

          <nav>
            <a title="Dark" href="#color/dark" class="variant color color-dark">D</a>
            <a title="Light" href="#color/light" class="variant color color-light">L</a>
          </nav>
        </nav>
      """

