$(document).ready(function(){
  $.getJSON("/states/" + $("#word-cloud").data("id") + ".json").then (function(words) {
    $("#word-cloud").jQCloud(words);
  });
});
