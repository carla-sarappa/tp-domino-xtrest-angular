app.controller('MenuCtrl', function($resource, $timeout, $scope, Promos) {
    'use strict';

    $scope.promos = [];

    function errorHandler(error) {
        console.log(error.data);
    }

    $scope.actualizarLista = function() {
        Promos.query()
            .then(function(data) {
                console.log(data);
                $scope.promos = data;
            })
            .catch(errorHandler);
    };

    $scope.actualizarLista();

});
