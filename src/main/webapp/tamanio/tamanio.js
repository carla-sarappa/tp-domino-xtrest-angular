app.controller('TamanioCtrl', function($resource, $timeout, $scope, Tamanios) {
    'use strict';

    $scope.tamanios = [];

    function errorHandler(error) {
        console.log(error.data);
    }

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
            '    <h4 class="list-group-item-heading">{{tamanio.nombre}}</h4>\n' +
            '    <p class="list-group-item-text">{{tamanio.factor}}</p><button type="button" class="btn btn-default btn-lg">\n' +
            '  <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>\n' +
            '</button>\n' +
            '  </a>\n' +
            '</div>'
        }
    })
;
