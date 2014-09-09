#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require_self

# for more details see: http://emberjs.com/guides/application/

get_updates = ()->
  window.update_start_at = new Date().getTime()
  $.ajax({
    url: '/messages?last_id=' + last_id,
    dataType: 'json',
    success: receive_updates
  })

delayed_item = (item, delay) ->
  setTimeout(() ->
    $('#messages').prepend($('<li />').text(item.text))
  , delay)


receive_updates(data) ->
    time_taken = new Date().getTime() - update_start_at

    console.log("update took", time_taken, " data: ", data)
    messages = data
    // stagger updates to make it seem fluent
    if (messages.length) {
      stagger_time = update_interval / messages.length
      for (i = 0; i < messages.length; i++) {
        delayed_item(messages[i], stagger_time * i)
      }
    }
    messages.forEach(function (item) {
    last_id = item.id // set the last_id to the last one
    })
    setTimeout(get_updates, Math.max(0, update_interval - time_taken))
    }