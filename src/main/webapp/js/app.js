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

});

