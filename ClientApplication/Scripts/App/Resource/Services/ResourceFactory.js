

angular.module("TOERH.Resource").factory("ResourceFactory", ["$http",
    function ($http) {
        'use strict';
        return {
            getAllResources: function (url) {
                url = typeof url !== "undefined" ? url : "http://localhost:3000/api/v1/resource?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe&page=1";
                return $http({
                    method: "GET",
                    url: url
                });
            },
            getResource: function (id) {
                return $http({
                    method: "GET",
                    url: "http://localhost:3000/api/v1/resource/" + id + "?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe"
                });
            },
            searchForResources: function (searchString) {
                return $http({
                    method: "GET",
                    url: "http://localhost:3000/api/v1/resource?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe&page=1&resourcename=" + searchString
                });
            },
            deleteResource: function (id, auth_token) {
                return $http({
                    method: "DELETE",
                    url: "http://localhost:3000/api/v1/resource/" + id + "?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe",
                    headers: {
                        "X-Auth-Token": auth_token
                    }
                });
            },
            insertResource: function (resource, auth_token) {
                return $http({
                    method: "POST",
                    url: "http://localhost:3000/api/v1/resource?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe",
                    headers: {
                        "Content-Type": "application/json",
                        "X-Auth-Token": auth_token
                    },
                    data: JSON.stringify(resource)
                });
            },
            updateResource: function (resource, auth_token) {
                return $http({
                    method: "PUT",
                    url: "http://localhost:3000/api/v1/resource/" + resource.resource_id + "?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe",
                    headers: {
                        "Content-Type": "application/json",
                        "X-Auth-Token": auth_token
                    },
                    data: JSON.stringify(resource)
                });
            }
        };
    }
]);