$(document).ready(function(){
  $.getJSON("/states/" + $("#word-cloud").data("id") + ".json").success (function(words) {
    $("#word-cloud").jQCloud(words);
    bleh();
  });
});


function bleh() {
  return $(".cloud-link").on('click', function(event) {
    event.preventDefault();
    console.log("HeeeeYyyyY");
    var word = this.text;
    $("." + word).show();
  })
};
