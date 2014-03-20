

angular.module("TOERH.Menu").controller("MenuCtrl", ["$scope", "$rootScope", "ResourceFactory", "MessageService",
    function ($scope, $rootScope, ResourceFactory, MessageService) {
        'use strict';
        $scope.isLoggedIn = $rootScope.isLoggedIn;

        $rootScope.$watch("isLoggedIn", function () {
            $scope.isLoggedIn = $rootScope.isLoggedIn;
        });

        $scope.getAllResources = function () {
            ResourceFactory.getAllResources().success(function (data) {
                $scope.$$nextSibling.$$childTail.resources = data.resources;
                $scope.$$nextSibling.$$childTail.apidata = data;
            }).error(function (error) {
                MessageService.showMessage("<strong>Error:</strong> " + error.errormessage + ".", "alert alert-info", "userMessage");
            });
        };
    }
]);