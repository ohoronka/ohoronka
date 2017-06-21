App.guarded_object = App.cable.subscriptions.create "GuardedObjectChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log('connected to object', arguments)

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log('disconnected from object')

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log(data)
    this[data.e](data)

  event_added: (data) ->
    $('#events tbody').prepend(data.html)
    $('#events tbody tr:last').remove()