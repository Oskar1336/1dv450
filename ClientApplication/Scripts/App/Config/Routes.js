

angular.module('TOERH').config(['$routeProvider', '$httpProvider', function ($routeProvider, $httpProvider) {
    'use strict';

    $httpProvider.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

    $routeProvider.when('/:type', {
        controller: '', // @TODO: root controller
        templateUrl: '' // @TOOD: root template
    }).otherwise({
        redirectTo: '/' // @TODO: Change to root url.
    });
}]);