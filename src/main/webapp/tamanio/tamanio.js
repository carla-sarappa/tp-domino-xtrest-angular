app.controller('TamanioCtrl', function($resource, $timeout, $scope, $state, Tamanios) {
    'use strict';

    $scope.tamanios = [];

    function errorHandler(error) {
        console.log(error.data);
    }

    $scope.selectTamanio = function(tamanio){
        $scope.$parent.plato.tamanio= tamanio;
        $state.go('extras');
    };


    $scope.actualizarLista = function() {
        Tamanios.query()
            .then(function(data) {
                console.log(data);
                $scope.tamanios = data;
            })
            .catch(errorHandler);
    };

    $scope.actualizarLista();

})
    .directive('tamanios', function() {
        return {
            template: '<div class="list-group">\n' +
            '  <a href="#" class="list-group-item ">\n' +
            '    <div class="row"><div class="col-md-10"><h4 class="list-group-item-heading">{{tamanio.nombre}}</h4></div>\n' +
            '    <div class="col-md-1 centrar-div"><span class="badge dinero" >{{plato.pizza.precio * tamanio.factor}}</span></div><div class="col-md-1"><button type="button" class="btn btn-default btn-lg">\n' +
            '  <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>\n' +
            '</button></div></div>\n' +
            '  </a>\n' +
            '</div>'
        }
    })
;
