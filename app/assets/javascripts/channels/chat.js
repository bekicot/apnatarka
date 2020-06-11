App.chat = App.cable.subscriptions.create("ChatChannel", {
  connected: function() {
  },
  disconnected: function() {},
  received: function(data) {
  	var orders = $('#append_new_order');
  	orders.append(data['order']);
  	// messages.scrollTop(messages[0].scrollHeight);
  }
});