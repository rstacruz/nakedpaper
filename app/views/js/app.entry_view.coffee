NN.EntryView = NN.View.extend
  templates:
    toolbar:
      _.template """
        <nav class="toolbar">
          <nav>
            <a title="Back" href="#back" class="back">&lsaquo;</a>
          </nav>

          <nav>
            <a title="View source" href="#source" target="_blank" class="source" rel="nofollow">Src</a>
          </nav>

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

  events:
    'click a.back':    'onBack'
    'click a.variant': 'onSwitchVariant'

  initialize: ->
    @$el   = $ @el
    @$body = $ "body"
    @model = {
      title: @$('header h1').text()
      url:   @$('header h1 a').attr('href')
    }

    @_spawnToolbar()
    @_cureLinks()

    @$toolbar.find('a.source').attr 'href', @model.url

  _spawnToolbar: ->
    @$toolbar = $ @templates.toolbar()
    @$el.append @$toolbar
    @$toolbar.ani 'slide in'

    @$toolbar.find('a').tipTip
      delay: 0, edgeOffset: 5, fadeIn: 80, maxWidth: "300px", defaultPosition: 'right'

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

$('.news-pane.entry').livequery ->
  new NN.EntryView el: this
