$(document).on('ready', function () {
  $("#question_tag_list").tagsInput({width: '100%',
    height: '1rem'});


  if (onPage("questions", "show")) {
    var question = $(".question-title").text();

    $.ajax({
      dataType: "json",
      url: "/proxy/bing.json",
      data: {"query": question},
      success: function (data) {
        var links = $.map(data.d.results, function (result) {
          return "<li><a href='" + result.Url + "'>" + result.Title + "</a></li>";
        });

        $("#bing-links")
          .find(".results")
          .html("<ul></ul>")
          .children("ul")
          .append(links);
        console.log("completed request");
      }
    });

    console.log("made ajax request");
  }
});

