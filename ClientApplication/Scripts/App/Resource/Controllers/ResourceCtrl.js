

angular.module("TOERH.Resource").controller("ResourceCtrl", [
    "$scope", "$rootScope", "$routeParams", "ResourceFactory", function ($scope, $rootScope, $routeParams, ResourceFactory) {
        var resourcePromise = ResourceFactory.getAllResources();
        resourcePromise.success(function (data) {
            console.log(data);
            $scope.resources = data.resources;
        });
        resourcePromise.error(function (error) {
            console.log("@TODO: Handle Error");
        });
    }
]);