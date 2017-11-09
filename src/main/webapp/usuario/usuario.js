app.controller('UsuarioCtrl', function($resource, $timeout, $scope, $state, UsuarioService, Pedidos) {
    'use strict';

    $scope.historial = [];

    function errorHandler(error) {
        console.log(error.data);
    }

    $scope.editarUsuario = function(){
        UsuarioService.update($scope.$parent.cliente, function () {
            console.log('Usuario actualizado');
        },function () {
            console.log('Error al actualizar el usuario');
        });
    };

    $scope.buscarHistorial = function () {
        Pedidos.historial($scope.$parent.cliente.id, function(pedidos){
            $scope.historial = pedidos;
            console.log(pedidos);
        }, function () {
            console.log("Error historial");
        })

    };

    $scope.buscarHistorial();

}).service('UsuarioService', function($http) {
    return {
        update: function (updatedUser, cb, errorHandler){
            return $http.put(HOST + "usuarios", updatedUser)
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