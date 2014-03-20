

angular.module("TOERH.ResourceType").factory("ResourceTypeFactory", ["$http", function ($http) {
    'use strict';
    return {
        getAllResourceType: function () {
            return $http({
                method: "GET",
                url: "http://localhost:3000/api/v1/resourcetype?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe"
            });
        },
        searchForResourcesByResourceType: function (resourceType) {
            var url = "http://localhost:3000/api/v1/resourcetype/" + resourceType + "?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe&page=1";
            return $http({
                method: "GET",
                url: url
            });
        }
    }
}
]);