# A feed entry.
#
# == Instanciating
#   new NN.Entry id: x, feed: y
#
# == Attributes
#  - feed
#  - href
#  - url
#  - title
#  - image
#  - summary
#  - content
#  - published
#
class NN.Entry extends Backbone.Model
  # URL path.
  path: null

  initialize: ->
    @path = "#{@get('feed').path}/entry/#{@id}"

  exists: ->
    attributes.title?

  getNext: (offset) ->
    list = @get('feed').getEntriesList()
    i = _.indexOf(list, this)
    list[i+(offset||1)]  if i?

  getPrev: ->
    @getNext -1

  # The feed it belongs to. [Nn.Feed]
  feed: null

