

angular.module("TOERH.Search").controller("SearchCtrl", ["$scope", "$rootScope", "$routeParams", "ResourceFactory", "MessageService", "TagFactory", "LicenceFactory", "ResourceTypeFactory", "UserFactory",
    function ($scope, $rootScope, $routeParams, ResourceFactory, MessageService, TagFactory, LicenceFactory, ResourceTypeFactory, UserFactory) {

        LicenceFactory.getAllLicences().success(function (data) {
            $scope.licences = data.licences;
        }).error(function (error) {
            $scope.licences = [];
        });

        $scope.searchTypes = [
            { name: "Resources", value: "Resource" },
            { name: "Tags", value: "Tag" },
            { name: "Resource type", value: "ResourceType" },
            { name: "License", value: "Licence" },
            { name: "Users", value: "User" }
        ];

        $scope.searchType = null;
        $scope.licence = null;

        $scope.showTextSearch = function () {
            var searchType = $scope.searchType;
            if (searchType == null) {
                return true;
            }
            return searchType.value === "Resource" || searchType.value === "Tag" || searchType.value === "ResourceType" || searchType.value === "User";
        };

        $scope.search = function () {
            if ($scope.searchType == null || $scope.searchType.value == "Resource") {
                var promise = ResourceFactory.searchForResources(undefined, $scope.search.value);
            } else if ($scope.searchType.value == "Tag") {
                var promise = TagFactory.searchForResourcesByTag($scope.search.value);
            } else if ($scope.searchType.value == "ResourceType") {
                var promise = ResourceTypeFactory.searchForResourcesByResourceType($scope.search.value);
            } else if ($scope.searchType.value == "Licence") {
                var promise = LicenceFactory.searchForResourcesByLicence($scope.licence.id);
            } else if ($scope.searchType.value == "User") {
                var promise = UserFactory.searchForResourcesByUser($scope.search.value);
            }

            promise.success(function (data) {
                if (data.resources.length > 0) {
                    $scope.$parent.$$nextSibling.$$childTail.resources = data.resources;
                    $scope.$parent.$$nextSibling.$$childTail.apidata = data;
                } else {
                    MessageService.showMessage("<strong>Error:</strong> Found resources.", "alert alert-info", "userMessage");
                }
            });
            promise.error(function (error) {
                if (error.status === 404) {
                    MessageService.showMessage("<strong>Error:</strong> Found no such resource.", "alert alert-danger", "userMessage");
                } else {
                    MessageService.showMessage("<strong>Error:</strong> Error while fetching resources.", "alert alert-danger", "userMessage");
                }
            });
        };
    }
]);