
function openPage(page, content, callBack, param) {
  $(content).html('');
  var url = 'pages/' + page + '.jsp' + (param !== null && typeof param !== 'undefined' ? '?' + param : '');
  $.ajax({
    cache: false,
    async: true,
    dataType: 'html',
    url: url,
    success: function(data, textStatus, jqXHR) {
      $(content).html(data);
      if (callBack) {
        callBack();
      }
    },
    error: function(jqXHR, textStatus, errorThrown) {
      if (jqXHR === '' || jqXHR.status === 404) {
        alert('404 Não encontrado');
      } else {
        alert(textStatus);
      }
    }
  });
}