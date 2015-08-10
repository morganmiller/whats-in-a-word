$(document).ready(function(){
  $.getJSON("/states/" + $("#word-cloud").data("id") + ".json").then(function(words) {
    $("#word-cloud").jQCloud(words.map(addClickHandler));
  });
});

function addClickHandler(word) {
  word.handlers = {
    click: function () {
      // Your code here.
      console.log(word);
    }
  };
  return word;
}
