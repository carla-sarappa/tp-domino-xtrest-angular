app.controller('PedidoCtrl', function($resource, $timeout, $scope, $state, Pedidos) {
    'use strict';

    $scope.direccion = '';

    function errorHandler(error) {
        console.log(error.data);
    }

    $scope.confirmarPedido = function(){
        console.log($scope.$parent.pedido);
        Pedidos.crearPedido($scope.$parent.pedido, function () {
            $state.go('usuario');
        }, function (error) {
            console.log(error)
        });

    };

    $scope.deletePlato = function (plato) {
        var index = $scope.$parent.pedido.platos.indexOf(plato);
        $scope.$parent.pedido.platos.splice(index, 1);
    };

}).service('Pedidos', function($http) {
    var getData = function(response) { return response.data };
    var toPedido = function (json) {
        return pedidoFromJson(json);
    };

    return {
        crearPedido: function(pedido, cb, errorHandler) {
            var pedidoRequest = {
                platos: pedido.platos.map(function (plato) {

                    return{
                        pizza: plato.pizza.id,
                        tamanio: plato.tamanio.nombre,
                        extras: plato.extras.map(function (extra) {
                            return{
                                ingrediente: extra.ingrediente.id,
                                distribucion: extra.distribucion
                            }
                        })
                    }
                })               ,
                cliente: pedido.cliente.id,
                aclaraciones: pedido.aclaraciones,
                formaDeEnvio: pedido.formaDeEnvio
            };

            return $http.post(HOST + "pedidos", pedidoRequest)
                .then(cb)
                .catch(errorHandler);
        },
        historial: function (id, cb, errorHandler) {
            return $http.get(HOST + "pedidos?userId=" + id)
                .then(getData)
                .then(function (pedidosJson) {
                    return pedidosJson.map(toPedido)
                })
                .then(cb)
                .catch(errorHandler);
        }
    }
});
