app.controller('MenuCtrl', function($resource, $timeout, $scope, $state, Promos) {
    'use strict';

    $scope.promos = [];
    $scope.$parent.sarasa = "Hola";

    function errorHandler(error) {
        console.log(error.data);
    }

    $scope.selectPromo = function(promo){
        $scope.$parent.promoSeleccionada = promo;
        $state.go('tamanio');
    };

    $scope.actualizarLista = function() {
        Promos.query()
            .then(function(data) {
                console.log(data);
                $scope.promos = data;
            })
            .catch(errorHandler);
    };

    $scope.actualizarLista();

})
    .directive('promos', function() {
        return {
            templateUrl: 'menu/promoTemplate.html'
        }
    })
;
