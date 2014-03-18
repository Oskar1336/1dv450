

angular.module("TOERH.User").factory("UserFactory", ["$http", function ($http) {
    return {
        getAllUsers: function () {
            return $http({
                method: "GET",
                url: "http://localhost:3000/api/v1/user?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe"
            });
        },
        searchForResourcesByUser: function (Username) {
            var url = "http://localhost:3000/api/v1/user/" + Username + "?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe&page=1";
            return $http({
                method: "GET",
                url: url
            });
        },
        createUser: function (user) {
            return $http({
                method: "POST",
                url: "http://localhost:3000/api/v1/user?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe",
                data: JSON.stringify(user)
            });
        }
    }
}
]);