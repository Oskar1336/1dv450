

angular.module("TOERH.Resource").factory("ResourceFactory", ["$http", function ($http) {
        return {
            getAllResources: function (url) {
                url = typeof url !== "undefined" ? url : "http://localhost:3000/api/v1/resource?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe&callback=JSON_CALLBACK&page=1";
                return $http.jsonp(url);
            }
        }
    }
]);