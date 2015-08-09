(function() {
  this.formatted_date = function(date) {
    var d;
    d = new Date(date);
    return moment(d).format('HH:MM MMMM Do, YYYY');
  };

  this.time_ago = function(date) {
    var d;
    d = new Date(date);
    return moment(d).fromNow();
  };

  this.word_count = function(entry) {
    return (entry.body === !null) && entry.body.split.size || 0;
  };

  this.formatted_body = function(entry) {
    if (!(entry === null || entry.body === null)) {
      return entry.body.replace("\n", "\n\n");
    }
  };

  this.rand = function(min, max) {
    return Math.floor(Math.random() * (max - min) + min);
  };

}).call(this);
