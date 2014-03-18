

angular.module("TOERH.Resource").controller("AddCtrl", ["$scope", "$rootScope", "$routeParams", "$modal", "ResourceFactory", "MessageService", "LicenceFactory",
    function ($scope, $rootScope, $routeParams, $modal, ResourceFactory, MessageService, LicenceFactory) {

        $scope.openAddResourceModal = function () {
            var modalInstance = $modal.open({
                templateUrl: "/Templates/AddResource.html",
                controller: AddResourceInstanceCtrl
            });
        };

        var AddResourceInstanceCtrl = function ($scope, $modalInstance, ResourceFactory) {
            $scope.resource = {};

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
                        "resource_type": $scope.resource.resourcetype,
                        "licence": $scope.resource.resourcelicense,
                        "description": $scope.resource.resourcedesc,
                        "url": $scope.resource.resourceurl,
                        "resource_name": $scope.resource.resourcename,
                        "tags": tags
                    };

                    ResourceFactory.insertResource(resource).success(function (data) {
                        MessageService.showMessage("<strong>Success:</strong> Resource added.", "alert alert-success", "addResourceMessage");
                        $scope.resource = {};
                        // @TODO: Update list when adding new item.
                        $scope.$$prevSibling.apidata.resources.push(data.resource);
                        $scope.$$prevSibling.resources.push(data.resource);
                    }).error(function (error) {
                        MessageService.showMessage("<strong>Error:</strong> Error while adding resource.", "alert alert-danger", "addResourceMessage");
                    });
                }
            };

            $scope.cancel = function () {
                $modalInstance.close();
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