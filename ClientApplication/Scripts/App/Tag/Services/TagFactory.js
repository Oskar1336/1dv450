

angular.module("TOERH.Tag").factory("TagFactory", ["$http", function ($http) {
    'use strict';
    return {
        getAllTags: function () {
            return $http({
                method: "GET",
                url: "http://localhost:3000/api/v1/tag?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe"
            });
        },
        searchForResourcesByTag: function (tagName) {
            return $http({
                method: "GET",
                url: "http://localhost:3000/api/v1/tag/" + tagName + "?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe&page=1"
            });
        }
    }
}
]);