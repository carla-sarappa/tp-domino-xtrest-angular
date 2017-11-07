var app = angular.module('dominoApp', ['ui.router','ngResource']);

app.config(function($stateProvider) {
    $stateProvider.state('login', {
        templateUrl: 'login/login.html',
        controller: 'LoginCtrl'
    });

    $stateProvider.state('menu', {
        templateUrl: 'menu/menu.html',
        controller: 'MenuCtrl'
    });

    $stateProvider.state('tamanio', {
        templateUrl: 'tamanio/tamanio.html',
        controller: 'TamanioCtrl'
    });

    $stateProvider.state('extras', {
        templateUrl: 'extras/extras.html',
        controller: 'ExtrasCtrl'
    });
});

