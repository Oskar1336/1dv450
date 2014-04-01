

angular.module("TOERH.Resource").controller("ResourceCtrl", ["$scope", "$rootScope", "$location", "$route", "ResourceFactory", "MessageService", "TagFactory",
    function ($scope, $rootScope, $location, $route, ResourceFactory, MessageService, TagFactory) {
        'use strict';

        $scope.currentTags = [];
        $scope.selectedTags = [];
        $scope.apidata = null;
        $scope.isLoggedIn = $rootScope.isLoggedIn;
        $rootScope.$watch("isLoggedIn", function () {
            $scope.isLoggedIn = $rootScope.isLoggedIn;
            if ($rootScope.authInfo.username !== null) {
                $scope.currentUser = $rootScope.authInfo.username;
            } else {
                $scope.currentUser = "";
            }
        });
        $scope.$watch("resources", function () {
            $scope.currentTags = getAllCurrentTags();
        });

        var getAllCurrentTags = function () {
            var tags = [];
            angular.forEach($scope.resources, function (resource) {
                angular.forEach(resource.tags, function (tag) {
                    if (tags.indexOf(tag.tag) === -1) {
                        tags.push(tag.tag);
                    }
                });
            });
            return tags;
        };

        ResourceFactory.getAllResources().success(function (data) {
            $scope.apidata = data;
            $scope.resources = data.resources;
            $scope.currentTags = getAllCurrentTags();
        }).error(function (error) {
            if (error.status === 404) {
                MessageService.showMessage("<strong>Error:</strong> " + error.errormessage + ".", "alert alert-info", "userMessage");
            } else {
                MessageService.showMessage("<strong>Error:</strong> Error while fetching resources.", "alert alert-danger", "userMessage");
            }
        });

        // Delete a resource.
        $scope.delete = function (resource) {
            ResourceFactory.deleteResource(resource.resource_id, $rootScope.authInfo.auth_token).success(function (data) {
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
            TagFactory.searchForResourcesByTag(tag).success(function (data) {
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

        $rootScope.updateResourceList = function (resource, index) {
            if (index == undefined) {
                var resources = $scope.resources;
                if (resources.length != 10) {
                    resources.push(resource);
                    $scope.resources = resources;
                }
            } else {
                $scope.resources[index] = resource;
            }
        };

        $scope.setSelectedTag = function (tag) {
            var index = $scope.selectedTags.indexOf(tag);
            if (index === -1) {
                $scope.selectedTags = [];
                $scope.selectedTags.push(tag);
            } else {
                $scope.selectedTags.splice(index, 1);
            }
            return false;
        };

        $scope.isSelected = function (tag) {
            if ($scope.selectedTags.indexOf(tag) !== -1) {
                return "glyphicon glyphicon-ok pull-right";
            } else {
                return false;
            }
        };
    }
]);