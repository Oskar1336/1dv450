

angular.module("TOERH.Search").controller("SearchCtrl", ["$scope", "$rootScope", "$routeParams", "ResourceFactory", "MessageService",
    function ($scope, $rootScope, $routeParams, ResourceFactory, MessageService) {
        $scope.searchTypes = [
            { name: "Resources", value: "Resource" },
            { name: "Tags", value: "Tag" },
            { name: "Resource type", value: "ResourceType" },
            { name: "License", value: "Licence" },
            { name: "Users", value: "User" }
        ];

        $scope.searchType = null;

        $scope.search = function () {
            if ($scope.searchType == null || $scope.searchType.value == "Resource") {
                console.log(ResourceFactory);
                var promise = ResourceFactory.searchForResources(undefined, $scope.search.value);
            } else if ($scope.searchType.value == "Tag") {
                console.log("@TODO: Add function");
            } else if ($scope.searchType.value == "ResourceType") {
                console.log("@TODO: Add function");
            } else if ($scope.searchType.value == "Licence") {
                console.log("@TODO: Add function");
            } else if ($scope.searchType.value == "User") {
                console.log("@TODO: Add function");
            }

            promise.success(function (data) {
                $scope.$parent.$$nextSibling.$$childTail.resources = data.resources;
                $scope.$parent.$$nextSibling.$$childTail.apidata = data;
            });
            promise.error(function (error) {
                console.log(error);
                if (error.status === 404) {
                    MessageService.showMessage("<strong>Error:</strong> Found no such resource.", "alert alert-danger", "userMessage");
                } else {
                    MessageService.showMessage("<strong>Error:</strong> Error while fetching resources.", "alert alert-danger", "userMessage");
                }
            });
        };
    }
]);