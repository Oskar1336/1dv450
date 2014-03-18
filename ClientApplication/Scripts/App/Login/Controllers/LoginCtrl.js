

angular.module("TOERH.Login").controller("LoginCtrl", ["$scope", "$rootScope", "$routeParams",
    function ($scope, $rootScope, $routeParams) {
        $rootScope.isLoggedIn = true;

        $scope.login = function () {
            window.location.href = "http://localhost:3000/authenticate?callback=http://localhost:39322/"
        };
    }
]);