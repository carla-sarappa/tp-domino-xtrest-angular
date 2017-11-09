app.controller('LoginCtrl', function($resource, $timeout, $scope, $state, LoginService) {

    $scope.loginRequest = {username: '', password: ''};

    $scope.loginAsInvitado = function () {
        $scope.$parent.cliente = new Cliente({nick: 'Invitado'});
        $state.go('menu');
    };

    $scope.login = function(){
        LoginService.login(
            $scope.loginRequest,
            function(response){
                var cliente = new Cliente(response.data);
                console.log(cliente);
                $scope.$parent.cliente = cliente ;
                $state.go('menu');
            },
            function (response) {
                $scope.loginError.message = response.data.message;
            }
        );
    };

    $scope.signupRequest = {username: '', password: '', nombre: '', email: '', direccion: ''};

    $scope.signup = function(){
        LoginService.signup(
            $scope.signupRequest,
            function(){
                $state.go('menu');
            },
            function (response) {
                $scope.signupError.message = response.data.message;
            }
        );


    };

    $scope.loginError = {};
    $scope.signupError = {};
}).service('LoginService', function($http) {

    var host = "http://localhost:9000/";

    return {
        login: function (loginRequest, cb, errorHandler) {
            return $http.post(host + "login", loginRequest)
                .then(cb, errorHandler);
        },
        signup: function (signupRequest, cb, errorHandler){
            return $http.post(host + "usuarios", signupRequest)
                .then(cb)
                .catch(errorHandler);
        }
    }
});
