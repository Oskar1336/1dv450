

angular.module("TOERH.Resource").controller("EditCtrl", ["$scope", "$rootScope", "$routeParams", "$modal", "ResourceFactory", "MessageService", "LicenceFactory",
    function ($scope, $rootScope, $routeParams, $modal, ResourceFactory, MessageService, LicenceFactory) {
        'use strict';

        $scope.openEditResourceModal = function (resource, index) {
            var modalInstance = $modal.open({
                templateUrl: "/Templates/AddResource.html",
                controller: EditResourceInstanceCtrl,
                resolve: {
                    resource: function () {
                        return resource;
                    },
                    index: function () {
                        return index;
                    }
                }
            });
        };

        var EditResourceInstanceCtrl = function ($scope, $modalInstance, resource, index) {
            $scope.isInEdit = true;

            $scope.resource = {};
            var tagString = "";
            for (var i = 0; i < resource.tags.length; i++) {
                tagString += resource.tags[i] + ":";
            }
            $scope.resource.resourceid = resource.resource_id;
            $scope.resource.resourcetype = resource.resource_type.resourcetype;
            $scope.resource.resourcelicense = resource.licence.licence;
            $scope.resource.resourcedesc = resource.description;
            $scope.resource.resourceurl = resource.url;
            $scope.resource.resourcename = resource.resource_name;
            $scope.resource.resourcetags = tagString.substring(0, tagString.length - 1);

            LicenceFactory.getAllLicences().success(function (data) {
                $scope.licences = data.licences;
            }).error(function (error) {
                $scope.licences = [];
            });

            $scope.create = function () {
                if (validate()) {
                    var tagString = $scope.resource.resourcetags;
                    var tags = [];
                    if (tagString !== "") {
                        tags = tagString.split(":");
                    }
                    var resource = {
                        resource_id: $scope.resource.resourceid,
                        resource_type: $scope.resource.resourcetype,
                        licence: $scope.resource.resourcelicense,
                        description: $scope.resource.resourcedesc,
                        url: $scope.resource.resourceurl,
                        resource_name: $scope.resource.resourcename,
                        tags: tags
                    };

                    ResourceFactory.updateResource(resource, $rootScope.authInfo.auth_token).success(function (data) {
                        MessageService.showMessage("<strong>Success:</strong> Resource updated.", "alert alert-success", "userMessage");
                        $rootScope.updateResourceList(data.resource, index);
                        $modalInstance.close();
                    }).error(function (error) {
                        MessageService.showMessage("<strong>Error:</strong> Error while updating resource.", "alert alert-danger", "addResourceMessage");
                    });
                }
            };

            $scope.cancel = function () {
                $modalInstance.dismiss("Cancel");
            };

            var validate = function () {
                var valid = true;
                if ($scope.resource.resourcetype == null || $scope.resource.resourcetype == "") {
                    MessageService.showMessage("<strong>Error:</strong> Resource type is required.", "alert alert-danger", "addResourceMessage");
                    valid = false;
                } if ($scope.resource.resourcelicense == null || $scope.resource.resourcelicense == "") {
                    MessageService.showMessage("<strong>Error:</strong> Resource licence is required.", "alert alert-danger", "addResourceMessage");
                    valid = false;
                } if ($scope.resource.resourcename == null || $scope.resource.resourcename == "") {
                    MessageService.showMessage("<strong>Error:</strong> Resource name is required.", "alert alert-danger", "addResourceMessage");
                    valid = false;
                } if ($scope.resource.resourceurl == null || $scope.resource.resourceurl == "") {
                    MessageService.showMessage("<strong>Error:</strong> Resource url is required.", "alert alert-danger", "addResourceMessage");
                    valid = false;
                }
                return valid;
            };
        };
    }
]);