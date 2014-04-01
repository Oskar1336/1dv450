

angular.module("TOERH.Search").controller("SearchCtrl", ["$scope", "$rootScope", "$routeParams", "ResourceFactory", "MessageService", "TagFactory", "LicenceFactory", "ResourceTypeFactory", "UserFactory",
    function ($scope, $rootScope, $routeParams, ResourceFactory, MessageService, TagFactory, LicenceFactory, ResourceTypeFactory, UserFactory) {
        'use strict';

        LicenceFactory.getAllLicences().success(function (data) {
            $scope.licences = data.licences;
        }).error(function (error) {
            $scope.licences = [];
        });

        TagFactory.getAllTags().success(function (data) {
            $scope.tags = data.tags;
        }).error(function (error) {
            $scope.tags = [];
        });

        ResourceTypeFactory.getAllResourceType().success(function (data) {
            $scope.resourceTypes = data.resourcetypes;
        }).error(function () {
            $scope.resourceTypes = [];
        });

        UserFactory.getAllUsers().success(function (data) {
            $scope.users = data.users;
        }).error(function () {
            $scope.users = [];
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
            if ($scope.searchType == null) {
                return true;
            }
            return $scope.searchType.value === "Resource";
        };

        $scope.licenceSelected = function () {
            if ($scope.searchType !== null) {
                return $scope.searchType.value === "Licence";
            }
            return false;
        };

        $scope.tagSelected = function () {
            if ($scope.searchType !== null) {
                return $scope.searchType.value === "Tag";
            }
            return false;
        };

        $scope.resourcetypeSelected = function () {
            if ($scope.searchType !== null) {
                return $scope.searchType.value === "ResourceType";
            }
            return false;
        };

        $scope.userSelected = function () {
            if ($scope.searchType !== null) {
                return $scope.searchType.value === "User";
            }
            return false;
        };

        $scope.search = function () {
            var promise = null;
            if ($scope.searchType == null || $scope.searchType.value == "Resource") {
                var promise = ResourceFactory.searchForResources($scope.search.value);
            } else if ($scope.searchType.value == "Tag") {
                if ($scope.tag !== null) {
                    var promise = TagFactory.searchForResourcesByTag($scope.tag.tag);
                } else {
                    MessageService.showMessage("<strong>Error:</strong> No tag selected.", "alert alert-info", "userMessage");
                }
            } else if ($scope.searchType.value == "ResourceType") {
                if ($scope.resourcetype !== null) {
                    var promise = ResourceTypeFactory.searchForResourcesByResourceType($scope.resourcetype.resourcetype);
                } else {
                    MessageService.showMessage("<strong>Error:</strong> No resource type selected.", "alert alert-info", "userMessage");
                }
            } else if ($scope.searchType.value == "Licence") {
                if ($scope.licence !== null) {
                    var promise = LicenceFactory.searchForResourcesByLicence($scope.licence.id);
                } else {
                    MessageService.showMessage("<strong>Error:</strong> No license selected.", "alert alert-info", "userMessage");
                }
            } else if ($scope.searchType.value == "User") {
                if ($scope.user !== null) {
                    var promise = UserFactory.searchForResourcesByUser($scope.user);
                } else {
                    MessageService.showMessage("<strong>Error:</strong> No user selected.", "alert alert-info", "userMessage");
                }
            }

            if (promise !== null) {
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
            }
        };

        
    }
]);