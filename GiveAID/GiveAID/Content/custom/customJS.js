// thông báo thành công
function showSuccessMessage(text) {
    toastr.success(text);
}

// thông báo lỗi
function showErrorMessage(text) {
    toastr.error(text);
}

function handleException(response) {
    VipremoveClass("loading");
    var error = response.responseJSON;
    showErrorMessage(error.error);
}

function getFormObj(formId) {
    //form vip pro 123 456 789
    var formObj = {};
    var inputs = $('#' + formId).serializeArray();
    $.each(inputs, function (i, input) {
        formObj[input.name] = input.value;
    });
    return formObj;
}

//add Class
function VipaddClass(className) {
    //add Class
    $("body").addClass(className);
}

//remove Class
function VipremoveClass(className) {
    //remove Class
    $("body").removeClass(className);
}

function DivremoveClass(className) {
    //remove Class
    $("div").removeClass(className);
}



    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();   
});
