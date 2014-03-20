

angular.module("TOERH.Login").controller("LoginCtrl", ["$scope", "$rootScope", "LoginFactory",
    function ($scope, $rootScope, LoginFactory) {
        'use strict';
        $rootScope.isLoggedIn = false;
        var authUpdated = false;

        var getAuthInfo = function (urlString) {
            var paramObject = {};
            var params = urlString.split("&");
            for (var i = 0; i < params.length; i++) {
                var urlParam = params[i].split("=");
                if (urlParam[0] === "token_expires" || urlParam[0] === "auth_token") {
                    if (urlParam[0] === "token_expires") {
                        var dateArray = urlParam[1].split("%3A");
                        var date = dateArray[0].split("+");
                        dateArray[0] = date[1];
                        date.pop();
                        var secandzone = dateArray[2].split("+");
                        dateArray[2] = secandzone[0];
                        dateArray.push(secandzone[1]);
                        paramObject[urlParam[0]] = new Date(date[0] + " " + dateArray[0] + ":" + dateArray[1] + ":" + dateArray[2] + " " + dateArray[3]);
                    } else {
                        paramObject[urlParam[0]] = urlParam[1];
                    }
                    $rootScope.isLoggedIn = true;
                }
            }
            return paramObject;
        };

        if (authUpdated === false) {
            $rootScope.authInfo = getAuthInfo(location.search.substring(1));
        }
        
        $rootScope.$watch("isLoggedIn", function () {
            $scope.isLoggedIn = $rootScope.isLoggedIn;
        });

        $scope.login = function () {
            window.location.href = "http://localhost:3000/authenticate?callback=http://localhost:39322/";
        };
        
        $scope.logout = function () {
            LoginFactory.signout($rootScope.authInfo.auth_token).success(function () {
                window.location.href = "http://localhost:39322/";
            }, function (error) {

            });
        };
    }
]);