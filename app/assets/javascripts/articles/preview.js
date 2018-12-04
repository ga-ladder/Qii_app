window.addEventListener("load",function() {
  function update_preview(text) {
    $.ajax({
      url: '/preview_markdown',
      type: 'POST',
      data: {
        text: text,
        dataType: 'json'
      }
    })
    .done(function(data) {
      $('#preview').html(data.text);
    })
    .fail(function(xhr, status, err) {
      $('#preview').html('エラー発生 ' + err);
    })
  };
  $('#article_content').on('keyup change', function() {
    update_preview($(this).val());
  });
});
