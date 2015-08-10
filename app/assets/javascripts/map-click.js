$(document).ready(function() {
  $('#map').usmap({
    click: function(event, data) {
      window.location.replace("/states/" + data.name);
    }
  });
});
