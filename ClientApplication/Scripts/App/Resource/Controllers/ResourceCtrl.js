

angular.module("TOERH.Resource").controller("ResourceCtrl", ["$scope", "$rootScope", "$routeParams", "ResourceFactory",
    function ($scope, $rootScope, $routeParams, ResourceFactory) {
        var apidata = null;
        var resourcePromise = ResourceFactory.getAllResources();
        resourcePromise.success(function (data) {
            apidata = data;
            $scope.resources = data.resources;
        });
        resourcePromise.error(function (error) {
            console.log("@TODO: Handle Error");
        });

        $scope.loadPage = function (previousPage) {
            if (previousPage) {
                var promise = ResourceFactory.getAllResources(apidata.previousPage);
            } else {
                var promise = ResourceFactory.getAllResources(apidata.nextPage);
            }
            
            promise.success(function (data) {
                apidata = data;
                $scope.resources = data.resources;
            });

            promise.error(function (error) {
                console.log("@TODO: Handle Error");
            });
        };
    }
]);