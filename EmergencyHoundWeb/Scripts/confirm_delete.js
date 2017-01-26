
$(function () {
    $("a.delete-link").click(function () {
        var deleteLink = $(this);
        deleteLink.hide();
        var confirmButton = deleteLink.siblings(".delete-confirm");
        //confirmButton.show("slide", { direction: "left" }, 1500);
        confirmButton.delay(100).fadeIn(700);

        var cancelDelete = function () {
            removeEvents();
            showDeleteLink();
        };

        //updated to handle MVC
        var delPath = "";
        if (confirmButton.attr('data-delete-path') != null)
            delPath = confirmButton.attr('data-delete-path') + confirmButton.attr('data-delete-p');
        else
            delPath = confirmButton.attr('data-delete-p');


        var deleteItem = function () {
            removeEvents();
            confirmButton.fadeOut(700);
            $.post(
                delPath,
                AddAntiForgeryToken({ id: confirmButton.attr('data-delete-id'), id2: confirmButton.attr('data-delete-id2') }))
               .done(function () {
                   var idType = confirmButton.attr('data-delete-type');

                   if (idType == 'team') //special handling for team control
                   {
                       var parentRow = deleteLink.parents(".treecont:first");
                       parentRow.fadeOut('slow', function () {
                           parentRow.remove();
                       });
                   }
                   else
                   {
                       var parentRow = deleteLink.parents("tr:first");
                       parentRow.fadeOut('slow', function () {
                           parentRow.remove();
                       });
                   }
               }).fail(function (data) {
                   alert("Record cannot be deleted.");
               });
            return false;
        };

        var removeEvents = function () {
            confirmButton.off("click", deleteItem);
            $(document).on("click", cancelDelete);
        };

        var showDeleteLink = function () {
            confirmButton.hide();
            deleteLink.fadeIn(700);
        };

        confirmButton.on("click", deleteItem);
        $(document).on("click", cancelDelete);

        return false;
    });

    AddAntiForgeryToken = function (data) {
        data.__RequestVerificationToken = $('input[name=__RequestVerificationToken]').val();
        return data;
    };
});