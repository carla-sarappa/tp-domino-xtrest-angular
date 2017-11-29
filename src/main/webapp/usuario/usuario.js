app.controller('UsuarioCtrl', function($resource, $timeout, $scope, $state, UsuarioService, Pedidos) {
    'use strict';

    $scope.historial = [];
    $scope.error = {};

    function errorHandler(error) {
        $scope.error = error.data;
    }

    $scope.editarUsuario = function(){
        UsuarioService.update($scope.$parent.cliente, function () {
            console.log('Usuario actualizado');
        }, errorHandler);
    };

    $scope.buscarHistorial = function () {
        Pedidos.historial($scope.$parent.cliente.id, function(pedidos){
            $scope.historial = pedidos;
            console.log(pedidos);
        }, errorHandler)

    };

    $scope.buscarHistorial();

    $scope.repetirPedido = function (pedido) {
        $scope.$parent.pedido = pedido;
        $state.go('pedido'); //TODO chequear repetido sin cambiar
    }

}).service('UsuarioService', function($http) {
    return {
        update: function (updatedUser, cb, errorHandler){
            return $http.put(HOST + "usuarios/" + updatedUser.id, updatedUser)
                .then(getData)
                .then(cb)
                .catch(errorHandler);
        }
    }
}).filter('joinStringList', function () {
    return function(list,attr) {

        var all = list.map(function (elem) {return elem[attr].nombre });
        var s;
        var length = all.length;
        for(var i = 0; i<length ; i++){
            s = (s?(s + ( i === length-1? " y " : ", ")):"") + all[i];
        }
        return s;
    }
});