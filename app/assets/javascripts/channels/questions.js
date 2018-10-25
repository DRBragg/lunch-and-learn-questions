App.questions = App.cable.subscriptions.create("QuestionsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    $('#questions').prepend(data.html);
  }
});
