

angular.module("TOERH.Login").factory("LoginFactory", ["$http",
    function ($http) {
        'use strict';
        return {
            signout: function (auth_token) {
                return $http({
                    method: "GET",
                    url: "http://localhost:3000/signout",
                    headers: {
                        "X-Auth-Token": auth_token
                    }
                });
            }
        };
    }
]);