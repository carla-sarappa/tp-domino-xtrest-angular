app.controller('ExtrasCtrl', function($resource, $timeout, $scope, $state, Extras) {
    'use strict';

    $scope.extras = [];
    $scope.distribuciones = ["Mitad izquierda", "Toda la pizza", "Mitad derecha"];


    function errorHandler(error) {
        console.log(error.data);
    };

    $scope.actualizarLista = function() {
        Extras.query()
            .then(function(data) {
                $scope.extras = data;
            })
            .catch(errorHandler);
    };

    $scope.actualizarLista();

    $scope.selectExtra = function(extra){
        $scope.$parent.plato.extras.push(new IngredienteDistribuido(extra, true));
        console.log($scope.$parent.plato.extras);
    };

    $scope.quitarExtra = function (extra) {
        var index = $scope.$parent.plato.extras.indexOf(extra);
        $scope.$parent.plato.extras.splice(index, 1);
        console.log($scope.$parent.plato.extras);
    };

    $scope.continuar = function(){
        $scope.$parent.pedido.platos.push($scope.$parent.plato);
        $state.go('pedido');
    };

})
    .directive('ingredientes', function() {
        return {
            templateUrl: 'extras/ingredientes.html'

        }
    })
    .directive('extras', function() {
        return {
            template: '<div><a href="#" ng-click="selectExtra(extra)"><p><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> {{extra.nombre}} <span class="badge dinero">{{extra.precio}}</span></p></a></div>'
        }
    })
    .directive('distribucion', function ($compile) {
        return function ($scope, element, attrs) {
                var html =  '<span><input type="radio" name="distribuciones" ng-model="ingrediente.distribucion"\n' +
                    '                         value="'+ attrs.nombre +'"\n' +
                    '                         ng-disabled="!ingrediente.isExtra && ingrediente.distribucion != \'' +
                    attrs.nombre +
                    '\'"\n' +
                    '                         ng-checked="ingrediente.distribucion == \''+ attrs.nombre +'\'">\n' +
                    '                '+ attrs.nombre +'\n' +
                    '            </span>';
                element.replaceWith($compile(html)($scope));
        }
    })
;
