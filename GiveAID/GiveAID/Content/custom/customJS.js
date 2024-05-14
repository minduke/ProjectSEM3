// thông báo thành công
function showSuccessMessage(text) {
    toastr.success(text);
}

// thông báo lỗi
function showErrorMessage(text) {
    toastr.error(text);
}

function handleException(response) {
    //HayremoveClass("loading");
    var error = response.responseJSON;
    showErrorMessage(error.error);
}

function getFormObj(formId) {
    var formObj = {};
    var inputs = $('#' + formId).serializeArray();
    $.each(inputs, function (i, input) {
        formObj[input.name] = input.value;
    });
    return formObj;
}
