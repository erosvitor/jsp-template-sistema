<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8"/>

  <title>TemplateJsp</title>

  <!-- JQUERY -->
  <script type="text/javascript" charset="utf-8" src="static/vendors/jquery 3.1.1/jquery-3.1.1.min.js"></script>

  <!-- UIKIT -->
  <link rel="stylesheet" type="text/css" href="static/vendors/uikit 2.27.2/css/uikit.css">
  <link rel="stylesheet" type="text/css" href="static/vendors/uikit 2.27.2/css/components/notify.css">
  <script type="text/javascript" charset="utf-8" src="static/vendors/uikit 2.27.2/js/uikit.min.js"></script>
  <script type="text/javascript" charset="utf-8" src="static/vendors/uikit 2.27.2/js/components/notify.min.js"></script>

  <!-- SHORTCUT -->
  <script type="text/javascript" charset="utf-8" src="static/vendors/shortcut 2.01.b/js/shortcut.js"></script>
  
  <!-- CUSTOM -->
  <link rel="stylesheet" type="text/css" href="static/css/login.css">
  <script type="text/javascript" charset="utf-8" src="static/js/messages.js"></script>
</head>
<body>
  <div id="content">
    <div>
      <img src="static/img/logo.png"/>
    </div>
    <hr/>
    <form class="uk-form uk-form-horizontal">
      <fieldset>
        <div class="uk-form-row">
          <label for="input-login" style="width: 80px; float: left;">Login*</label>
          <input id="input-login" type="text" autofocus="autofocus" style="width: calc(100% - 80px);"/>
        </div>
        <div class="uk-form-row">
          <label for="input-password" style="width: 80px; float: left;">Senha*</label>
          <input id="input-password" type="password" style="width: calc(100% - 80px);"/>
        </div>
        <div class="actions">
          <button id="button-login" type="submit"><span style="text-decoration:underline">E</span>ntrar</button>
        </div>
      </fieldset>
    </form>
  </div>
</body>
<script>
  var ajaxUrl = '<%=request.getContextPath()%>' + '/servlets/login';
  var PageContent = {};

  //----------------------------------------------------------------------------------------------------
  // Fields
  // ----------------------------------------------------------------------------------------------------
  PageContent.fields = {};
  PageContent.fields.login = $('#input-login');
  PageContent.fields.password = $('#input-password');

  // ----------------------------------------------------------------------------------------------------
  // Buttons
  // ----------------------------------------------------------------------------------------------------
  PageContent.buttons = {};
  PageContent.buttons.login = $('#button-login');
  PageContent.buttons.login.on('click', function() {
    login();
  });

  // ----------------------------------------------------------------------------------------------------
  // Functions
  // ----------------------------------------------------------------------------------------------------
  function login() {
    event.preventDefault();
	
    var login = PageContent.fields.login.val().trim();
    var password = PageContent.fields.password.val().trim();

    // Fields validation
    if (login === '' || password === '') {
      showMessageError(message_mandatoryFields);
      return;
    }

    // Send data to controller
    $.ajax({
        url: ajaxUrl,
        type: 'POST',
        method: 'POST',
        data: {'action':'login', 'login': login, 'password': password},
        dataType: 'json'
      })
      .done(function(json) {
        if (json.success) {
          window.location = 'index.jsp';
        } else {
          showMessageError(json.message);
        }
      })
      .fail(function(json) {
        alert("ERRO");
      });
  }
  
  function defineShortcuts() {
    shortcut.removeAll();
    shortcut.add("Ctrl+Alt+E",function() {
      login();	
    });
  }
  
  // ----------------------------------------------------------------------------------------------------
  // Document Ready
  // ----------------------------------------------------------------------------------------------------
  $('document').ready(function() {
    defineShortcuts();
  });

</script>
</html>
