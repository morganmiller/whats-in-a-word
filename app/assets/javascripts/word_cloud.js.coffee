$(document).on "ready", ->
  $.ajax("/states.json").then (words) ->
    console.log(words)
    $("#word-cloud").jQCloud words
