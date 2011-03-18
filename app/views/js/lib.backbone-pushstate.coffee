# 
# Replaces Backbone.History with support for HTML5 history API if browser supports it.
# To use, setup your controllers as usual and try it with a browser that supports the HTML5 history API.
# For browsers that don't support the HTML5 API, this will fall back to using the default Backbone hash routing.
# 
# I have only tested this on my project in Firefox, Safari and Chrome so let me know.
# 
pushSupport = window.history? and window.history.pushState?
if pushSupport and Backbone? and Backbone.History?
  rootUrl = document.location.protocol+'//'+(document.location.host or document.location.hostname)
  _.extend Backbone.History.prototype,
    # Simply return the browser's whole path
    getFragment: ->
      return window.location.pathname.substring(1)

    # Set all hrefs to be saved in the browser history and then routed through your controllers.
    # Handy for single page apps with no server side templating.
    # You can remove this and the call to it in start if you don't want it.
    # In that case, call Backbone.history.saveLocation and Backbone.history.loadUrl directly
    ajaxifyInternalLinks: ->
      self = this
      console.log 'ajaxing'
      $('a[href^=/]').live 'click', (e) ->
        return true  if e.metaKey or e.shiftKey or e.ctrlKey
        return true  if $(this).attr('target')
        href = $(this).attr('href')
        self.saveLocation(href)
        self.loadUrl(href.substring(1))
        e.preventDefault()
        return false

    # Overwriting this function basically replaces Backbone's history mechanism with everything in this module.      
    start: ->
      _.bindAll(this, 'loadUrl')

      # Remove this call if you don't all links to be routed through your controller automatically,
      @ajaxifyInternalLinks()

      # Route the initial browser url from page load
      # @loadUrl()

      # Handle history navigation, such as browser back/forward clicks by listening for popstate
      # We don't use JQuery event binding here because the popstate event isn't passed properly.
      # If there is no event.state then it must be a page load event, ignore it.
      self = this
      window.onpopstate = (event) -> if event.state? then self.loadUrl()

    # This has been modified to allow the fragment to be passed in directly.
    # If fragment is not passed it will be loaded from getFragment as usual.
    loadUrl: (fragment) ->
      # Such a nice assignment/check in CoffeeScript...
      fragment = @fragment = fragment ? @getFragment()
      # We skip all the other stuff Backbone does for hashes and go straight to the routes
      _.each @handlers, (handler) ->
        if handler.route.test(fragment) then handler.callback(fragment)  

    # This has been modified to allow the browser history to be replaced by passing true for replace.
    # This is handy for times you need to patch the history from inside the controller routes or somewhere
    # else in your app.
    saveLocation: (fragment, replace) ->
      return if not fragment?
      return if @fragment is fragment
      @fragment = fragment
      loc = window.location
      url = loc.protocol + "//" + loc.host + fragment
      state = {ts: new Date()}
      if replace? then window.history.replaceState(state, document.title, url)
      else window.history.pushState(state, document.title, url)
