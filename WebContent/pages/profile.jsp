
<div>
  <!-- PAGE HEADER -->
  <div class="page-header">
    <h2><i class="uk-icon-tags"></i>&nbsp;Perfis</h2>
    <div class="page-header-actions">
      <button id="button-new" class="button-default"><span style="text-decoration:underline">N</span>ovo Perfil</button>
    </div>
  </div>

  <!-- PAGE CONTENT -->
  <div class="page-content">
    <div>
      <table id="table-items" class="uk-table">
        <thead>
          <tr>
            <th>Nome</th>
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
        <span>Perfil</span>
      </div>
      <!-- CONTENT -->
      <form class="uk-form uk-form-horizontal" style="margin-left:15px;">
        <input id="input-id" type="hidden" value=""/>
        <div style="height: 50px; padding-top: 15px;">
          <div class="uk-form-row">
            <label for="input-name" class="uk-form-label" style="width: 100px;">Nome *</label>
            <div>
              <input id="input-name" type="text" autofocus="autofocus" style="width: calc(100% - 100px);"/>
            </div> 
          </div>
        </div>
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
<script>
  var ajaxUrl = '<%=request.getContextPath()%>' + '/servlets/profile';
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
      {'data': 'name'}
    ],
    'language': defineLanguageSettings()
  };

  // ----------------------------------------------------------------------------------------------------
  // Dialogs
  // ----------------------------------------------------------------------------------------------------
  PageContent.dialogs = {};
  PageContent.dialogs.edit = UIkit.modal($('#dialog-edit'), {center: true, keyboard: true, modal: true, bgclose: false});

  // ----------------------------------------------------------------------------------------------------
  // Fields
  // ----------------------------------------------------------------------------------------------------
  PageContent.fields = {};
  PageContent.fields.id = $('#input-id');
  PageContent.fields.name = $('#input-name');

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

    PageContent.messages.removeconfirm.hide();

    PageContent.buttons.removeitem.hide();
    PageContent.buttons.removeitemconfirm.hide();

    PageContent.dialogs.edit.show();
  }

  function saveItem() {
    var id = PageContent.fields.id.val();
    var name = PageContent.fields.name.val().trim();

    // Fields validation
    if (name === '') {
      showMessageError(message_mandatoryFields);
      return;
    }

    // Send data to controller
    $.ajax({
      url: ajaxUrl,
      type: 'POST',
      method: 'POST',
      data: {'action':'save', 'id': id, 'name': name},
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
      type: 'POST',
      method: 'POST',
      data: {'action':'edit', 'id': id},
      dataType: 'json'
    })
    .done(function(json) {
      if (json.success) {
        PageContent.fields.id.val(id);
        PageContent.fields.name.val(json.data.name);

        PageContent.messages.removeconfirm.hide();

        PageContent.buttons.removeitem.show();
        PageContent.buttons.removeitemconfirm.hide();

        PageContent.dialogs.edit.show();
      } else {
        showMessageError(json.message);
      }
     })
     .fail(function(json) {
       alert("ERRO");
     });
  }

  function confirmRemoveItem() {
    PageContent.messages.removeconfirm.html(message_confirm_delete_profile);
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
  
  function defineShortcuts() {
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

  // ----------------------------------------------------------------------------------------------------
  // Document Ready
  // ----------------------------------------------------------------------------------------------------
  $('document').ready(function() {
    defineShortcuts();
    loadItems();
  });

</script>
