

angular.module("TOERH.Resource").controller("AddCtrl", ["$scope", "$rootScope", "$routeParams", "$modal", "ResourceFactory", "MessageService",
    function ($scope, $rootScope, $routeParams, $modal, ResourceFactory, MessageService) {

        $scope.openAddResourceModal = function () {
            var modalInstance = $modal.open({
                templateUrl: "/Templates/AddResource.html",
                controller: AddResourceInstanceCtrl
            });
        };

        var AddResourceInstanceCtrl = function ($scope, $modalInstance, ResourceFactory) {
            $scope.resource = {};

            $scope.create = function () {
                var tagString = $scope.resource.resourcetags;
                var resource = {
                    "resource_type": $scope.resource.resourcetype,
                    "licence": $scope.resource.resourcelicense,
                    "description": $scope.resource.resourcedesc,
                    "url": $scope.resource.resourceurl,
                    "resource_name": $scope.resource.resourcename,
                    "tags": tagString.split(":")
                };

                ResourceFactory.insertResource(resource).success(function (data) {
                    MessageService.showMessage("<strong>Success:</strong> Resource added.", "alert alert-success", "addResourceMessage");
                    console.log(data);
                    $scope.resource = {};
                }).error(function (error) {
                    MessageService.showMessage("<strong>Error:</strong> Error while adding resource.", "alert alert-danger", "userMessage");
                });
            };

            $scope.cancel = function () {
                $modalInstance.close();
            };

        };
    }
]);