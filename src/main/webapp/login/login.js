app.controller('LoginCtrl', function($resource, $timeout, $scope, $state, LoginService) {

    $scope.loginRequest = {username: '', password: ''};

    $scope.login = function(){
        LoginService.login(
            $scope.loginRequest,
            function(){
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
});
