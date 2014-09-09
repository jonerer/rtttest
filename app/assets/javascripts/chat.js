function get_updates() {
  window.update_start_at = new Date().getTime()
  $.ajax({
    url: '/messages?last_id=' + last_id,
    dataType: 'json',
    success: receive_updates
  })
}

function delayed_item(item, delay) {
  setTimeout(function() {
    $('#messages').prepend($('<li />').text(item.text))
  }, delay)
}

function receive_updates(data) {
  var time_taken = new Date().getTime() - update_start_at

  console.log("update took", time_taken, " data: ", data)
  var messages = data
  // stagger updates to make it seem fluent
  if (messages.length) {
    var stagger_time = update_interval / messages.length;
    for (var i = 0; i < messages.length; i++) {
      delayed_item(messages[i], stagger_time * i)
    }
  }
  messages.forEach(function (item) {
    last_id = item.id // set the last_id to the last one
  })
  setTimeout(get_updates, Math.max(0, update_interval - time_taken))
}