App.account = App.cable.subscriptions.create "AccountChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log('connected')

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log(arguments)

  received: (data) ->
    console.log(data)
    this[data.e](data)

  alarm: (data) ->
    $.ajax({
      url: '/facilities/' + data.facility.id + '/update_facility',
      dataType: 'script'
    });
    this.show_msg('Alarm', 'Alarm fired on ' + data.facility.name)

  test: (data) ->
    console.log(data)

  show_msg: (title, msg) ->
    $('#msg-modal .modal-title').html(title)
    $('#msg-modal .modal-body').html(msg)
    $('#msg-modal').modal()
