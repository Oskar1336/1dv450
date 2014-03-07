

angular.module("TOERH").config(["$routeProvider", "$httpProvider", function ($routeProvider, $httpProvider) {
    'use strict';
    
    $httpProvider.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";

    $routeProvider.when("/", {
        controller: "ResourceCtrl",
        templateUrl: "/Templates/Resourcelist.html"
    }).otherwise({
        redirectTo: "/"
    });
}]);