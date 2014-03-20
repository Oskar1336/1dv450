

angular.module("TOERH.Message").service("MessageService", [function () {
        'use strict';
        this.showMessage = function (message, classlist, divID) {
            $("#" + divID).removeClass("hidden")
                .addClass(classlist)
                .append(message + "<br />")
                .delay(5000).fadeOut(300, function () {
                    $("#" + divID).removeAttr("style")
                        .removeClass("alert alert-danger")
                        .addClass("hidden")
                        .empty();
                });
        };
    }
]);