
var message_mandatoryFields = 'Campos assinalados com asterisco (*) devem ser preenchidos.';
var message_mandatoryProfiles = 'O perfil do usuário não foi selecionado.';
var message_confirm_delete_profile = 'Deseja mesmo remover este perfil?';
var message_confirm_delete_user = 'Deseja mesmo remover este usuário?';

function showMessageInfo(message) {
  $.UIkit.notify('<div id="text-div">' + message + '</div>', {status:'info', timeout: 5000, pos:'bottom-right'});
}

function showMessageSuccess(message) {
  $.UIkit.notify('<div id="text-div">' + message + '</div>', {status:'success', timeout: 5000, pos:'bottom-right'});
}

function showMessageWarning(message) {
  $.UIkit.notify('<div id="text-div">' + message + '</div>', {status:'warning', timeout: 5000, pos:'bottom-right'});
}

function showMessageError(message) {
  $.UIkit.notify('<div id="text-div">' + message + '</div>', {status:'danger', timeout: 5000, pos:'bottom-right'});
}
