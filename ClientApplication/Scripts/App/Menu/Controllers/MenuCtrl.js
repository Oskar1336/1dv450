

angular.module("TOERH.Menu").controller("MenuCtrl", ["$scope", "$rootScope", "$routeParams", "ResourceFactory",
    function ($scope, $rootScope, $routeParams, ResourceFactory) {
        $scope.isLoggedIn = true; // $rootScope.isLoggedIn;

        $scope.getAllResources = function () {
            ResourceFactory.getAllResources().success(function (data) {
                $scope.$$nextSibling.$$childTail.resources = data.resources;
                $scope.$$nextSibling.$$childTail.apidata = data;
            }).error(function (error) {
                console.log("@TODO: Handle error.");
            });
        };
    }
]);