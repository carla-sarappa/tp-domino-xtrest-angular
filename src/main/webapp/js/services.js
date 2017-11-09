var getData = function(response) { return response.data };

app.service('Tamanios', function($http) {

    var transform = function(json) { return new Tamanio(json) };

    return {
        query: function() {
            return $http.get(HOST + "tamanios")
                .then(getData)
                .then(function(listaJson){
                    return listaJson.map(transform)
                })
        }
    }
}).service('Extras', function($http) {
    var getData = function(response) { return response.data };
    var transform = function(json) { return new Ingrediente(json) };

    return {
        query: function() {
            return $http.get(HOST + "ingredientes")
                .then(getData)
                .then(function(listaJson){
                    return listaJson.map(transform)
                })
        }
    }
});

