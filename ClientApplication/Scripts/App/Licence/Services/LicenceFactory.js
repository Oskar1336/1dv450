

angular.module("TOERH.Licence").factory("LicenceFactory", ["$http", function ($http) {
    return {
        getAllLicences: function () {
            return $http({
                method: "GET",
                url: "http://localhost:3000/api/v1/licence?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe"
            });
        },
        searchForResourcesByLicence: function (id) {
            var url = "http://localhost:3000/api/v1/licence/" + id + "?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe&page=1";
            return $http({
                method: "GET",
                url: url
            });
        }
    }
}
]);