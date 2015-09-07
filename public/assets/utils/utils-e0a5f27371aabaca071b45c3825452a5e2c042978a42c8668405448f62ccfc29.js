(function() {
  var indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

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

  this.visit = function(url) {
    return window.location = url;
  };

  this.intersection = function(A, B) {
    var i, len, ref, results, value;
    if (A.length > B.length) {
      ref = [B, A], A = ref[0], B = ref[1];
    }
    results = [];
    for (i = 0, len = A.length; i < len; i++) {
      value = A[i];
      if (indexOf.call(B, value) >= 0) {
        results.push(value);
      }
    }
    return results;
  };

}).call(this);
