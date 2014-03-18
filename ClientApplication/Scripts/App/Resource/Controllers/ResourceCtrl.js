﻿

angular.module("TOERH.Resource").controller("ResourceCtrl", ["$scope", "$rootScope", "$routeParams", "$location", "ResourceFactory", "MessageService", "TagFactory",
    function ($scope, $rootScope, $routeParams, $location, ResourceFactory, MessageService, TagFactory) {
        $scope.apidata = null;
        $scope.isLoggedIn = $rootScope.isLoggedIn;

        ResourceFactory.getAllResources().success(function (data) {
            $scope.apidata = data;
            $scope.resources = data.resources;
        }).error(function (error) {
            MessageService.showMessage("<strong>Error:</strong> Error while fetching resources.", "alert alert-danger", "userMessage");
        });

        // Delete a resource.
        $scope.delete = function (resource) {
            ResourceFactory.deleteResource(resource.resource_id).success(function (data) {
                var index = $scope.resources.indexOf(resource);
                $scope.resources.splice(index, 1);
                MessageService.showMessage("<strong>Success:</strong> " + resource.resource_name + " deleted.", "alert alert-success", "userMessage");
            }).error(function (error) {
                if (error.status === 403) {
                    MessageService.showMessage("<strong>Error:</strong> Not authorized to access " + resource.resource_name + ".", "alert alert-danger", "userMessage");
                } else {
                    MessageService.showMessage("<strong>Error:</strong> Error while deleting " + resource.resource_name + ".", "alert alert-danger", "userMessage");
                }
            });
        };

        // Loads next or previous page.
        $scope.loadNextOrPreviousPage = function (previousPage) {
            if (previousPage) {
                var promise = ResourceFactory.getAllResources($scope.apidata.previousPage);
            } else {
                var promise = ResourceFactory.getAllResources($scope.apidata.nextPage);
            }

            promise.success(function (data) {
                if (data.resources.length > 0) {
                    $scope.apidata = data;
                    $scope.resources = data.resources;
                } else {
                    MessageService.showMessage("<strong>Error:</strong> Found no more resources.", "alert alert-info", "userMessage");
                }
            });
            promise.error(function (error) {
                if (error.status === 404) {
                    MessageService.showMessage("<strong>Error:</strong> Found no more resources.", "alert alert-info", "userMessage");
                } else {
                    MessageService.showMessage("<strong>Error:</strong> Error while fetching resources.", "alert alert-danger", "userMessage");
                }
            });
        };

        $scope.getResourcesByTag = function (tag) {
            TagFactory.searchForResourcesByTag(undefined, tag).success(function (data) {
                $scope.resources = data.resources;
                $scope.apidata = data;
            }).error(function (error) {
                if (error.status === 404) {
                    MessageService.showMessage("<strong>Error:</strong> Found no such resource.", "alert alert-danger", "userMessage");
                } else {
                    MessageService.showMessage("<strong>Error:</strong> Error while fetching resources.", "alert alert-danger", "userMessage");
                }
            });
        };
    }
]);