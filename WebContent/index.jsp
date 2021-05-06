<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.ctseducare.template.session.SessionData" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8"/>

  <title>TemplateJsp</title>

  <!-- JQUERY -->
  <script type="text/javascript" charset="utf-8" src="static/vendors/jquery 3.1.1/jquery-3.1.1.min.js"></script>
  <script type="text/javascript" charset="utf-8" src="static/vendors/jquery 3.1.1/addons/jquery.blockUI.js"></script>

  <!-- UIKIT -->
  <link rel="stylesheet" type="text/css" href="static/vendors/uikit 2.27.2/css/uikit.css">
  <link rel="stylesheet" type="text/css" href="static/vendors/uikit 2.27.2/css/components/notify.css">
  <script type="text/javascript" charset="utf-8" src="static/vendors/uikit 2.27.2/js/uikit.min.js"></script>
  <script type="text/javascript" charset="utf-8" src="static/vendors/uikit 2.27.2/js/components/notify.min.js"></script>

  <!-- DATATABLES -->
  <link rel="stylesheet" type="text/css" href="static/vendors/datatables 1.10.12/media/css/jquery.dataTables_themeroller.css"/>
  <script type="text/javascript" charset="utf-8" src="static/vendors/datatables 1.10.12/media/js/jquery.dataTables.js"></script>
  
  <!-- SHORTCUT -->
  <script type="text/javascript" charset="utf-8" src="static/vendors/shortcut 2.01.b/js/shortcut.js"></script>

  <!-- CUSTOM -->
  <link rel="stylesheet" type="text/css" href="static/css/base.css">
  <link rel="stylesheet" type="text/css" href="static/css/dragdrop.css">
  <link rel="stylesheet" type="text/css" href="static/override/uikit-override.css">
  <link rel="stylesheet" type="text/css" href="static/override/dataTables.uikit-override.css">
  <script type="text/javascript" charset="utf-8" src="static/js/base.js"></script>
  <script type="text/javascript" charset="utf-8" src="static/js/messages.js"></script>
  <script type="text/javascript" charset="utf-8" src="static/override/jquery.dataTables-pipeline.js"></script>
  
<style>
.user-logged {
  text-transform: uppercase;
}
</style>

</head>

<% 
  SessionData sessionData = (SessionData)request.getSession().getAttribute("sessionData");
%>
 
<body>
  <nav id="main-menu" class="uk-navbar menu-navbar">
    <ul id="menubar" class="uk-navbar-nav" style="width:100%;">
      <li>
        <a id="menuHome" href="javascript:void(0);" onclick="javascript:window.location='index.jsp'"><i class="uk-icon-home"></i>&nbsp;Home</a>
      </li>
      <li class="uk-parent" data-uk-dropdown="" style="float: right;">
        <a id="menuUserLogged" href="javascript:void(0);"><i class="uk-icon-user"></i>&nbsp;<%=sessionData.getUserLogin().toUpperCase()%>&nbsp;<i class="uk-icon-chevron-down"></i></a>
        <div class="menu-block uk-dropdown uk-dropdown-navbar">
          <ul class="uk-nav uk-nav-navbar">
            <li>
              <a id="menuUserLoggedExit" href="javascript:void(0);" onclick="javascript:logout();"><i class="uk-icon-sign-out"></i>&nbsp;Logout</a>
            </li>
          </ul>
        </div>
      </li>
      <li class="uk-parent" data-uk-dropdown="">
        <a id="menuSystem" href="javascript:void(0);"><i class="uk-icon-gear"></i>Sistema&nbsp;&nbsp;<i class="uk-icon-chevron-down"></i></a>
        <div class="menu-block uk-dropdown uk-dropdown-navbar" style="width:225px;">
          <ul class="uk-nav uk-nav-navbar">
            <li>
              <a id="menuSystemProfile" href="javascript:void(0);" onclick="openPage('profile', '#wrapper-main', null, null)"><i class="uk-icon-tags"></i>&nbsp;Perfis</a>
            </li>
            <li>
              <a id="menuSystemUser" href="javascript:void(0);" onclick="openPage('user', '#wrapper-main', null, null)"><i class="uk-icon-user"></i>&nbsp;Usuários</a>
            </li>
          </ul>
        </div>
      </li>
    </ul>
  </nav>
  <div id="wrapper-main">

  </div>
</body>
<script>
  function logout() {
    event.preventDefault();

    $.ajax({
        url: '<%=request.getContextPath()%>' + '/servlets/login',
        type: 'POST',
        method: 'POST',
        data: {'action':'logout'},
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
</script>
</html>
