

angular.module("TOERH.Resource").factory("ResourceFactory", ["$http", function ($http) {
        return {
            getAllResources: function (url) {
                url = typeof url !== "undefined" ? url : "http://localhost:3000/api/v1/resource?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe&page=1";
                return $http({
                    method: "GET",
                    url: url
                });
            },
            searchForResources: function (url, searchString) {
                url = typeof url !== "undefined" ? url : "http://localhost:3000/api/v1/resource?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe&limit=10&page=1&resourcename=" + searchString;
                return $http({
                    method: "GET",
                    url: url
                });
            },
            deleteResource: function (id) {
                return $http({
                    method: "DELETE",
                    url: "http://localhost:3000/api/v1/resource/" + id + "?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe",
                    headers: { "Authorization": "Basic dGVzdDp0ZXN0" }
                });
            },
            insertResource: function (resource) {
                var authstring = window.btoa("test:test");
                return $http({
                    method: "POST",
                    url: "http://localhost:3000/api/v1/resource?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe",
                    headers: {
                        "Content-Type": "application/json",
                        "Authorization": "Basic " + authstring // dGVzdDp0ZXN0
                    },
                    data: JSON.stringify(resource)
                });
            }
        }
    }
]);