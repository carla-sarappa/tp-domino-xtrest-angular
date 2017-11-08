app.controller('ExtrasCtrl', function($resource, $timeout, $scope, $state, Extras) {
    'use strict';

    $scope.extras = [];
    $scope.distribuciones = ["Mitad izquierda", "Toda la pizza", "Mitad derecha"];
    $scope.$parent.extrasSeleccionados = [];


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

    $scope.selectExtra = function(extra){
        $scope.$parent.extrasSeleccionados.push(new IngredienteDistribuido(extra, true));
        console.log($scope.$parent.extrasSeleccionados);
    };


})
    .directive('ingredientes', function() {
        return {
            templateUrl: 'extras/ingredientes.html'

        }
    })
    .directive('extras', function() {
        return {
            template: '<div><a href="#" ng-click="selectExtra(extra)"><p><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> {{extra.nombre}} <span class="badge">{{extra.precio}}</span></p></a></div>'
        }
    })
    .directive('distribucion', function (elem, attr) {
        return{
            template: '<span><input type="radio" name="distribuciones" ng-model="ingrediente.distribucion"\n' +
            '                         value="'+ attr.nombre +'"\n' +
            '                         ng-disabled="!ingrediente.isExtra && ingrediente.distribucion != \'' +
            attr.nombre +
            '\'"\n' +
            '                         ng-checked="ingrediente.distribucion == \''+ attr.nombre +'\'">\n' +
            '                '+ attr.nombre +'\n' +
            '            </span>'
        }
    })
;
