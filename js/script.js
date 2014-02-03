// JavaScript Document

$(window).resize(function() {
    divPostion();
});

function divPostion()
{
    $('.pageNav').css({
        position: 'absolute',
        left: ($(window).width() - $('.pageNav').outerWidth()) / 2
    });

    $('.tables').css({
        position: 'absolute',
        left: ($(window).width() - $('.tables').outerWidth()) / 2
    });
}

function tableSelect()
{
    document.forms[0].submit();
}

function showResponse(responseText)
{
    $('#addSubmitBtn').button('reset');
    if (responseText === 'Succesfully Inserted') {
        $('#addForm')[0].reset();
        $('#ajaxResponse').css("color", "green");
    }
    else {
        $('#ajaxResponse').css("color", "red");
    }
}

function showResponseUpdate(responseText)
{
    $('#updateSubmitBtn').button('reset');
    if (responseText === 'Succesfully Updated') {
        $('#ajaxResponse2').css("color", "green");
    }
    else {
        $('#ajaxResponse2').css("color", "red");
    }
}

function showResponseRegister(responseText)
{
    $('#registerBtn').button('reset');
    if (responseText === 'Succesfully Registered') {
        $('#registerForm')[0].reset();
        $('#ajaxResponseRegister').css("color", "green");
    }
    else {
        $('#ajaxResponseRegister').css("color", "red");
    }
}

function showResponseDelete()
{
    location.reload();
    $('#deleteBtn').button('reset');
}

function showRequest()
{
    $('#addSubmitBtn').button('loading');
    $('#updateSubmitBtn').button('loading');
    $('#registerBtn').button('loading');
    return true;
}

$(document).ready(function() {
    var key;
    var table;
    
    var options = {
        target: '#ajaxResponse',
        beforeSubmit: showRequest,
        success: showResponse
    };
    
    var options2 = {
        target: '#ajaxResponse2',
        beforeSubmit: showRequest,
        success: showResponseUpdate
    };
    
    var options3 = {
        beforeSubmit: showRequest,
        success: showResponseDelete
    };
    
    var options4 = {
        target: '#ajaxResponseRegister',
        beforeSubmit: showRequest,
        success: showResponseRegister
    };

    $('.container_pageNav').load(divPostion());
    $(window).resize();

    $('#addForm').ajaxForm(options);
    $('#addModal').on('hidden.bs.modal', function() {
        location.reload();
    });
    $("#addForm").validate();

    $('#addSubmitBtn').click(function() {
        if ($("#addForm").valid()) {
            $('#addForm').submit();
        }
    });
    
    $('#updateForm').ajaxForm(options2);
    $('#updateModal').on('hidden.bs.modal', function() {
        location.reload();
    });
    $("#updateForm").validate();
    $('#updateSubmitBtn').click(function() {
        if ($("#updateForm").valid()) {
            $('#updateForm').submit();
        }
    });
    $('#updateModal').on('show.bs.modal', function() {
        $.ajax({
            url: "functions/retrieveRow.php",
            type: "POST",
            data: {table: table, key: key}
        }).done(function(responseText) {
            var stringParts = responseText.split("|");
            
            if (table === "books") {
                $('#imdbBook', $('#updateModal')).val(stringParts[0]);
                $('#nameBook', $('#updateModal')).val(stringParts[1]);
                $('#author', $('#updateModal')).val(stringParts[2]);
                $('#yearOfPub', $('#updateModal')).val(stringParts[3]);
                $('#costBook', $('#updateModal')).val(stringParts[4]);
            }
            else {
                $('#imdbDvd', $('#updateModal')).val(stringParts[0]);
                $('#nameDvd', $('#updateModal')).val(stringParts[1]);
                $('#director', $('#updateModal')).val(stringParts[2]);
                $('#yearOfRelease', $('#updateModal')).val(stringParts[3]);
                $('#costDvd', $('#updateModal')).val(stringParts[4]);
            } 
        });
    });

    $('#deleteStuff').ajaxForm(options3);
    $('#deleteBtn').click(function() {
        $('#deleteBtn').button('loading');
        $(".tableControl").submit();
    });
    
    $('#registerForm').ajaxForm(options4);
    $('#registerModal').on('hidden.bs.modal', function() {
        location.reload();
    });
    $("#registerForm").validate();

    $('#registerBtn').click(function() {
        if ($("#registerForm").valid()) {
            $('#registerForm').submit();
        }
    });

    $('#yearOfPub', $('#addModal')).datepicker({
        autoclose: true
    });
    
    $('#yearOfPub', $('#updateModal')).datepicker({
        autoclose: true
    });
    
    $('#yearOfRelease', $('#addModal')).datepicker({
        autoclose: true
    });
    
    $('#yearOfRelease', $('#updateModal')).datepicker({
        autoclose: true
    });

    $("input:radio[name=optionsRadios]").click(function() {
        key = $(this).val();
        table = $("#table").val();
    });
});