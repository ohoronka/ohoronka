App.account = App.cable.subscriptions.create "AccountChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log(arguments)

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log(arguments)

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $('#msg-modal .modal-body').html(data)
    $('#msg-modal').modal()
