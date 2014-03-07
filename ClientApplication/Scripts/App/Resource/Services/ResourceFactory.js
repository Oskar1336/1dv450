

angular.module("TOERH.Resource").factory("ResourceFactory", ["$http", function ($http) {
        return {
            getAllResources: function () {
                return $http.jsonp("http://localhost:3000/api/v1/resource?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe&callback=JSON_CALLBACK");
            },

            getResource: function (id) {
                return $http.jsonp("http://localhost:3000/api/v1/resource/" + id + "?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe&callback=JSON_CALLBACK");
            }
        }
    }
]);