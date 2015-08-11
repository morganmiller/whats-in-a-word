$(document).ready(function(){
  $.getJSON("/states/" + $("#word-cloud").data("id") + ".json").then(function(words) {
    $("#word-cloud").jQCloud(words.map(addClickHandler));
  });
});

function addClickHandler(word) {
  word.handlers = {
    click: function (e) {
      e.preventDefault();
      $(".toggle").hide();
      var toShow = this.children[0].text;
      $("#" + toShow).show();
      console.log(word);
    }
  };
  return word;
}
