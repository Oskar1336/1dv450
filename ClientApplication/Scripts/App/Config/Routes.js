

angular.module("TOERH").config(["$routeProvider", "$httpProvider",
    function ($routeProvider, $httpProvider) {
        'use strict';

        $routeProvider.when("/", {
            controller: "ResourceCtrl",
            templateUrl: "/Templates/Resourcelist.html"
        }).when("/resource/add", {
            controller: "AddCtrl",
            templateUrl: "/Templates/AddResource.html"
        }).otherwise({
            redirectTo: "/"
        });
    }]
);