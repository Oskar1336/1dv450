

angular.module("TOERH").config(["$routeProvider", "$httpProvider",
    function ($routeProvider, $httpProvider) {
        'use strict';

        $routeProvider.when("/", {
            controller: "ResourceCtrl",
            templateUrl: "/Templates/Resourcelist.html"
        }).when("/search", {

        }).otherwise({
            redirectTo: "/"
        });
    }]
);