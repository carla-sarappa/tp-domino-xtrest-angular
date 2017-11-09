app.controller('UsuarioCtrl', function($resource, $timeout, $scope, $state) {
    'use strict';

    $scope.direccion = '';

    function errorHandler(error) {
        console.log(error.data);
    }

    $scope.editarUsuario = function(){
        console.log($scope.$parent.usuario)
    };

});
