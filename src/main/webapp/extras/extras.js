app.controller('ExtrasCtrl', function($resource, $timeout, $scope, Extras) {
    'use strict';

    $scope.extras = [];

    function errorHandler(error) {
        console.log(error.data);
    }

    $scope.actualizarLista = function() {
        Extras.query()
            .then(function(data) {
                console.log(data);
                $scope.extras = data;
            })
            .catch(errorHandler);
    };

    $scope.actualizarLista();

})
    .directive('extras', function() {
        return {
            template: '<div class="list-group">\n' +
            '  <a href="#" class="list-group-item ">\n' +
            '    <h4 class="list-group-item-heading">{{extra.nombre}}</h4>\n' +
            '    <p class="list-group-item-text">{{extra.nombre}}</p> <span class="badge">{{extra.precio}}</span><button type="button" class="btn btn-default btn-lg">\n' +
            '  <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>\n' +
            '</button>\n' +
            '  </a>\n' +
            '</div>'
        }
    })
;
