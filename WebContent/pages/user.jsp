<%@ page import="com.ctseducare.template.session.SessionData" %>
<div>
  <!-- PAGE HEADER -->
  <div class="page-header">
    <h2><i class="uk-icon-tags"></i>&nbsp;Usuários</h2>
    <div class="page-header-actions">
      <button id="button-new" class="button-default"><span style="text-decoration:underline">N</span>ovo Usuário</button>
    </div>
  </div>

  <!-- PAGE CONTENT -->
  <div class="page-content">
    <div>
      <table id="table-items" class="uk-table">
        <thead>
          <tr>
            <th>Nome</th>
            <th>Telefone</th>
            <th>E-mail</th>
            <th>Login</th>
          </tr>
        </thead>
        <tbody id="table-items-body">
        </tbody>
      </table>
    </div>
  </div>

  <!-- DIALOG FOR EDITION -->
  <div id="dialog-edit" class="uk-modal">
    <div class="uk-modal-dialog" style="width: 500px;">
      <!-- HEADER -->
      <div class="uk-modal-header">
        <i class="uk-icon-tags"></i>&nbsp;
        <span>Usuário</span>
      </div>
      <!-- TABS -->
      <div class="uk-modal-subheader">
        <ul class="uk-tab" data-uk-tab="{connect:'#tabs-edit', swiping: false}">
          <li id="tab-data" class="uk-active"><a href="#"><i class="uk-icon-tag"></i>&nbsp;Dados</a></li>
          <li id="tab-profiles"><a href="#"><i class="uk-icon-globe"></i>&nbsp;Perfis</a></li>
        </ul>
      </div>
      <form class="uk-form uk-form-horizontal" style="margin-left:15px;">
        <input id="input-id" type="hidden" value=""/>
        <ul id="tabs-edit" class="uk-switcher">
          <!-- CONTENT OF TAB DATA -->
          <li id="tab-data-content" class="uk-active" style="height: 300px;">
            <div style="height: 100px; padding-top: 15px;">
              <div class="uk-form-row">
                <label for="input-name" class="uk-form-label" style="width: 100px;">Nome *</label>
                <div>
                 <input id="input-name" type="text" autofocus="autofocus" style="width: calc(100% - 100px);"/>
                </div>
              </div>
              <div class="uk-form-row">
                <label for="input-telephone" class="uk-form-label" style="width: 100px;">Telefone</label>
                <div>
                  <input id="input-telephone" type="text" style="width: calc(100% - 100px);"/>
                </div>
              </div>
              <div class="uk-form-row">
                <label for="input-email" class="uk-form-label" style="width: 100px;">E-mail</label>
                <div>
                  <input id="input-email" type="text" style="width: calc(100% - 100px);"/>
                </div>
              </div>
              <div class="uk-form-row">
                <label for="input-login" class="uk-form-label" style="width: 100px;">Login *</label>
                <div>
                  <input id="input-login" type="text" style="width: calc(100% - 100px);"/>
                </div>
              </div>
              <div class="uk-form-row">
                <label for="input-password" class="uk-form-label" style="width: 100px;">Senha *</label>
                <div>
                  <input id="input-password" type="password" style="width: calc(100% - 100px);"/>
                </div>
              </div>
            </div>
          </li>
          <!-- CONTENT OF TAB PROFILE -->
          <li id="tab-profile-content" style="height: 300px;">
            <div style="display: flex; width: 100%; height: calc(100% - 55px); padding-top: 10px; justify-content: space-between;">
              <div class="association-list-section">
                <div><p class="association-list-section-title">Disponíveis</p></div>
                <div id="div-profiles-free" style="height: calc(100% - 34px); width: 100%; overflow: auto;" ondrop="drop(event, this)" ondragover="allowDrop(event)"></div>
              </div>
              <div class="association-list-section">
                <div><p class="association-list-section-title">Utilizados</p></div>
                <div id="div-profiles-used" style="height: calc(100% - 34px); width: 100%; overflow: auto;" ondrop="drop(event, this)" ondragover="allowDrop(event)"></div>
              </div>
            </div>
          </li>
        </ul>
      </form>
      <!-- FOOTER -->
      <span id="span-message-remove-confirm" class="message-remove-confirm" style="margin-left:15px;"></span>
      <div class="modal-actions">
        <button id="button-save" class="button-default"><span style="text-decoration:underline">S</span>alvar</button>
        <button id="button-cancel" class="button-cancel"><span style="text-decoration:underline">C</span>ancelar</button>
        <button id="button-remove" class="button-remove" style="display:none;"><span style="text-decoration:underline">E</span>xcluir</button>
        <button id="button-remove-confirm" class="button-remove" style="display:none;">Con<span style="text-decoration:underline">f</span>irmar</button>
      </div>
    </div>
  </div>
</div>

<% 
  SessionData sessionData = (SessionData)request.getSession().getAttribute("sessionData");
%>

<script>
  var ajaxUrl = '<%=request.getContextPath()%>' + '/servlets/user';
  var userLogged = '<%=sessionData.getUserLogin()%>';
  var PageContent = {};

  // ----------------------------------------------------------------------------------------------------
  // Datatable Settings
  // ----------------------------------------------------------------------------------------------------
  PageContent.datatableSettings = {
    'destroy': true,
    'retrieve': false,
    'processing': true,
    'serverSide': true,
    'deferRender': true,
    'dom': '<"search-length"li>rtp',
    'pagingType': 'full_numbers',
    'rowId': 'id',
    'ajax':
      $.fn.dataTable.pipeline({
        url: ajaxUrl,
        data: function(d) {
          d.action = 'load';
        }
      }),
    'columns':
    [
      {'data': 'name'},
      {'data': 'telephone'},
      {'data': 'email'},
      {'data': 'login'}
    ],
    'language': defineLanguageSettings()
  };

  // ----------------------------------------------------------------------------------------------------
  // Dialogs
  // ----------------------------------------------------------------------------------------------------
  PageContent.dialogs = {};
  PageContent.dialogs.edit = UIkit.modal($('#dialog-edit'), {center: true, keyboard: true, modal: true, bgclose: false});

  // ----------------------------------------------------------------------------------------------------
  // Tabs
  // ----------------------------------------------------------------------------------------------------
  PageContent.tabs = {};
  PageContent.tabs.data = $('#tab-data');
  PageContent.tabs.profiles = $('#tab-profiles');
  
  // ----------------------------------------------------------------------------------------------------
  // Fields
  // ----------------------------------------------------------------------------------------------------
  PageContent.fields = {};
  PageContent.fields.id = $('#input-id');
  PageContent.fields.name = $('#input-name');
  PageContent.fields.telephone = $('#input-telephone');
  PageContent.fields.email = $('#input-email');
  PageContent.fields.login = $('#input-login');
  PageContent.fields.password = $('#input-password');

  // ----------------------------------------------------------------------------------------------------
  // Messages
  // ----------------------------------------------------------------------------------------------------
  PageContent.messages = {};
  PageContent.messages.removeconfirm = $('#span-message-remove-confirm');

  // ----------------------------------------------------------------------------------------------------
  // Buttons
  // ----------------------------------------------------------------------------------------------------
  PageContent.buttons = {};
  PageContent.buttons.newitem = $('#button-new');
  PageContent.buttons.newitem.on('click', function() {
    newItem();
  });
  PageContent.buttons.saveitem = $('#button-save');
  PageContent.buttons.saveitem.on('click', function() {
    saveItem();
  });
  PageContent.buttons.cancelitem = $('#button-cancel');
  PageContent.buttons.cancelitem.on('click', function() {
    cancelItem();
  });
  PageContent.buttons.removeitem = $('#button-remove');
  PageContent.buttons.removeitem.on('click', function() {
    confirmRemoveItem();
  });
  PageContent.buttons.removeitemconfirm = $('#button-remove-confirm');
  PageContent.buttons.removeitemconfirm.on('click', function() {
    removeItem();
  });

  // ----------------------------------------------------------------------------------------------------
  // Functions
  // ----------------------------------------------------------------------------------------------------
  function loadItems() {
    if (typeof PageContent.table === 'undefined') {
      PageContent.table = $('#table-items').dataTable(PageContent.datatableSettings);
    } else {
      PageContent.table.fnSettings().clearCache = true;
      PageContent.table.fnDraw();
    }
    $('#table-items-body').on('click', 'tr', function() {
      var id = $(this).prop('id');
      if (id != null && id !== '' && id !== 0 && id !== '0') {
        editItem(id);
      }
    });
  }

  function newItem() {
    PageContent.fields.id.val('0');
    PageContent.fields.name.val('');
    PageContent.fields.telephone.val('');
    PageContent.fields.email.val('');
    PageContent.fields.login.val('');
    PageContent.fields.password.val('');

    $('#div-profiles-free').empty();
    $('#div-profiles-used').empty();
    loadProfilesFree();

    PageContent.messages.removeconfirm.hide();

    PageContent.buttons.removeitem.hide();
    PageContent.buttons.removeitemconfirm.hide();

    PageContent.dialogs.edit.show();
    PageContent.tabs.data.click();
  }

  function saveItem() {
    var id = PageContent.fields.id.val();
    var name = PageContent.fields.name.val().trim();
    var telephone = PageContent.fields.telephone.val().trim();
    var email = PageContent.fields.email.val().trim();
    var login = PageContent.fields.login.val().trim();
    var password = PageContent.fields.password.val().trim();
    
    // Fields validation
    if (name === '' || login === '' || password === '') {
      showMessageError(message_mandatoryFields);
      return;
    }

    // Get Profiles used
    profiles = [];
    $('#div-profiles-used').find('div').each(function() {
      profiles.push($(this).attr('profile'));
    });
    if (profiles.length === 0) {
      showMessageError(message_mandatoryProfiles);
      return;
    }
    
    // Send data to controller
    $.ajax({
      url: ajaxUrl,
      type: 'POST',
      method: 'POST',
      data: {'action':'save', 'id': id, 'name': name, 'telephone': telephone, 'email': email, 'login': login, 'password': password, 'profiles': profiles},
      dataType: 'json'
    })
    .done(function(json) {
      if (json.success) {
        showMessageSuccess(json.message);
        PageContent.dialogs.edit.hide();
        loadItems();
      } else {
        showMessageError(json.message);
      }
    })
    .fail(function(json) {
      alert("ERRO");
    });
  }

  function cancelItem() {
    PageContent.dialogs.edit.hide();
  }

  function editItem(id) {
    $.ajax({
      url: ajaxUrl,
      type: 'GET',
      method: 'GET',
      data: {'action':'edit', 'id': id},
      dataType: 'json'
    })
    .done(function(json) {
      if (json.success) {
        PageContent.fields.id.val(id);
        PageContent.fields.name.val(json.data.name);
        PageContent.fields.telephone.val(json.data.telephone);
        PageContent.fields.email.val(json.data.email);
        PageContent.fields.login.val(json.data.login);
        PageContent.fields.password.val(json.data.password);

        $('#div-profiles-free').empty();
        loadProfilesFree();

        $('#div-profiles-used').empty();
        $.each(json.data.profiles, function(index, item) {
          var html = '<div draggable="true" ondragstart="drag(event)" class="association-list-item" id="div-profile-' + item.id + '" profile="' + item.id + '">';
          html += '<p align="center" style="margin: 0;">';
          html += item.name;
          html += '</p>';
          html += '</div>';
          $('#div-profiles-used').append(html);
        });

        PageContent.messages.removeconfirm.hide();

        if (json.data.login === userLogged) {
          PageContent.buttons.removeitem.hide();
          PageContent.buttons.removeitemconfirm.hide();
        } else {
          PageContent.buttons.removeitem.show();
          PageContent.buttons.removeitemconfirm.hide();
          shortcut.add("Ctrl+Alt+E", function() {
            if (PageContent.dialogs.edit.active && PageContent.buttons.removeitem.is(":visible")) {
              confirmRemoveItem();
            }
          });
          shortcut.add("Ctrl+Alt+F", function() {
            if (PageContent.dialogs.edit.active && PageContent.buttons.removeitemconfirm.is(":visible")) {
              removeItem();
            }	
          });
        }
        PageContent.dialogs.edit.show();
        PageContent.tabs.data.click();
      } else {
        showMessageError(json.message);
      }
     })
     .fail(function(json) {
       alert("ERRO");
     });
  }

  function confirmRemoveItem() {
    PageContent.messages.removeconfirm.html(message_confirm_delete_user);
    PageContent.messages.removeconfirm.show();

    PageContent.buttons.removeitem.hide();
    PageContent.buttons.removeitemconfirm.show();
  }

  function removeItem() {
    $.ajax({
      url: ajaxUrl,
      type: 'POST',
      method: 'POST',
      data: {'action':'remove', 'id': PageContent.fields.id.val()},
      dataType: 'json'
    })
    .done(function(json) {
      if (json.success) {
        $('#table-items-body > #' + PageContent.fields.id.val()).remove();
        PageContent.dialogs.edit.hide();
        showMessageSuccess(json.message);
      } else {
        showMessageError(json.message);
      }
    })
    .fail(function(json) {
      alert("ERRO");
    });
  }

  function loadProfilesFree() {
    $.ajax({
      url: '<%=request.getContextPath()%>' + '/servlets/profile',
      type: 'GET',
      method: 'GET',
      data: {'action':'loadProfilesFree', 'userId': PageContent.fields.id.val()},
      dataType: 'json'
    })
    .done(function(json) {
      if (json.success) {
        $.each(json.data, function(index, item) {
          var html = '<div draggable="true" ondragstart="drag(event)" class="association-list-item" id="div-profile-' + item.id + '" profile="' + item.id + '">';
          html += '<p align="center" style="margin: 0;">';
          html += item.name;
          html += '</p>';
          html += '</div>';
          $('#div-profiles-free').append(html);
        });
      } else {
        showMessageError(json.message);
      }
    })
    .fail(function(json) {
      alert("ERRO");
    });
  }
  
  function defineShortcuts(userInEdition) {
    shortcut.removeAll();
    shortcut.add("Ctrl+Alt+N",function() {
      newItem();	
    });
    shortcut.add("Ctrl+Alt+S", function() {
      if (PageContent.dialogs.edit.active) {
        saveItem();
      }  
    });
    shortcut.add("Ctrl+Alt+C", function() {
      if (PageContent.dialogs.edit.active) {
    	cancelItem();
      } 	
    });
  }

  // ----------------------------------------------------------------------------------------------------
  // Drag and Drop
  // ----------------------------------------------------------------------------------------------------
  function drag(event) {
    event.dataTransfer.setData('Draged', event.target.id);
  }

  function drop(event, container) {
    event.preventDefault();
    var data = event.dataTransfer.getData('Draged');
    var element = document.getElementById(data);
    if (container != null && element != null) {
      container.appendChild(element);
    }
  }

  function allowDrop(event) {
    event.preventDefault();
  }

  // ----------------------------------------------------------------------------------------------------
  // Document Ready
  // ----------------------------------------------------------------------------------------------------
  $('document').ready(function() {
    defineShortcuts();
	loadItems();
  });

</script>
