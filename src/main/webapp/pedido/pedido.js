app.controller('PedidoCtrl', function($resource, $timeout, $scope, $state, Pedidos) {
    'use strict';

    $scope.direccion = '';

    function errorHandler(error) {
        console.log(error.data);
    }

    $scope.confirmarPedido = function(){
        console.log($scope.$parent.pedido)
        Pedidos.crearPedido($scope.$parent.pedido);

    };

}).service('Pedidos', function($http) {
    var getData = function(response) { return response.data };
    var toPlato = function(json) { return new Plato(new Pizza(json)) };

    return {
        crearPedido: function(pedido) {
            var pedidoRequest = {
                platos: pedido.platos.map(function (plato) {

                    return{
                        promo: plato.promo.id,
                        tamanio: plato.tamanio.nombre,
                        extras: plato.extras.map(function (extra) {
                            return{
                                ingrediente: extra.ingrediente.id,
                                distribucion: extra.distribucion.id
                            }
                        })
                    }
                })               ,
                cliente: pedido.cliente.id,
                aclaraciones: pedido.aclaraciones,
                formaDeEnvio: pedido.envio
            };

            return $http.post(HOST + "pedidos", pedidoRequest)
                .then(function(response){
                    console.log(response);
                })
        }
    }
});
