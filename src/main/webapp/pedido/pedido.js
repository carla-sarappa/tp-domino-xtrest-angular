app.controller('PedidoCtrl', function($resource, $timeout, $scope, $state) {
    'use strict';

    $scope.pedidos = [];

    function errorHandler(error) {
        console.log(error.data);
    }

    $scope.sendPedido = function(promo){

    };

});
