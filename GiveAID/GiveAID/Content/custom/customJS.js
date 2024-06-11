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




    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();   
});

//back to Top
$(window).scroll(function () {
    var backToTopBtn = $("#backToTopBtn");
    if ($(window).scrollTop() > 200) {
        backToTopBtn.css("display", "block");
    } else {
        backToTopBtn.css("display", "none");
    }
});

$("#backToTopBtn").click(function () {
    $("html, body").animate({ scrollTop: 0 }, "slow");
});
//back to Top

function fbShare(url, image, winWidth, winHeight) {
    var winTop = (screen.height / 2) - (winHeight / 2);
    var winLeft = (screen.width / 2) - (winWidth / 2);
    var url = $(location).attr('host');

    window.open('https://www.facebook.com/sharer.php?u=' + window.location.href, 'sharer', 'top=' + winTop + ',left=' + winLeft + ',toolbar=0,status=0,width=' + winWidth + ',height=' + winHeight);
}



$(document).ready(function () {
    var maxChars = parseInt($('#title').attr('maxlength'));

    $('#title').on('input', function () {
        var inputText = $(this).val();
        var charCount = inputText.length;

        if (charCount > maxChars) {
            $(this).val(inputText.substr(0, maxChars));
            charCount = maxChars;
        }

        $('#charCount').text(charCount + '/' + maxChars);
    });

    $('#title').trigger('input'); // Kích hoạt sự kiện input ban đầu
});

//$(document).ready(function () {
//    var maxChars = parseInt($('#introduceFooter').attr('maxlength'));

//    $('#introduceFooter').on('input', function () {
//        var inputText = $(this).val();
//        var charCount = inputText.length;

//        if (charCount > maxChars) {
//            $(this).val(inputText.substr(0, maxChars));
//            charCount = maxChars;
//        }

//        $('#charCount2').text(charCount + '/' + maxChars);
//    });
//});


$(document).ready(function () {
    var maxChars = parseInt($('#introduceFooter').attr('maxlength'));

    $('#introduceFooter').on('input', function () {
        var inputText = $(this).val();
        var charCount = inputText.length;

        if (charCount > maxChars) {
            $(this).val(inputText.substr(0, maxChars));
            charCount = maxChars;
        }

        $('#charCount2').text(charCount + '/' + maxChars);
    });

    $('#introduceFooter').trigger('input'); // Kích hoạt sự kiện input ban đầu
});