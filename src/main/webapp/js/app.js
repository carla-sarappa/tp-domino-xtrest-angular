var app = angular.module('dominoApp', ['ui.router','ngResource']);
var HOST = "http://localhost:9000/";
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
    $stateProvider.state('pedido', {
        templateUrl: 'pedido/pedido.html',
        controller: 'PedidoCtrl'
    });
    $stateProvider.state('usuario', {
        templateUrl: 'usuario/usuario.html',
        controller: 'UsuarioCtrl'
    });
});