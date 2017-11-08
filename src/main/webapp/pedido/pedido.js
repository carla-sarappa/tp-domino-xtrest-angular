app.controller('PedidoCtrl', function($resource, $timeout, $scope, $state) {
    'use strict';

    $scope.direccion = '';

    function errorHandler(error) {
        console.log(error.data);
    }

    $scope.confirmarPedido = function(){
        console.log($scope.$parent.pedido)
    };

});
