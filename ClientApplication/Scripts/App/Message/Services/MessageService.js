

angular.module("TOERH.Resource").service("MessageService", ["$rootScope",
    function ($rootScope) {
        this.showMessage = function (message, classlist, divID) {
            $("#"+divID).removeClass("hidden")
                .addClass(classlist)
                .append(message+"<br />")
                .delay(5000).fadeOut(300, function () {
                    $("#"+divID).removeAttr("style")
                        .removeClass("alert alert-danger")
                        .addClass("hidden")
                        .empty();
                });
        };
    }
]);