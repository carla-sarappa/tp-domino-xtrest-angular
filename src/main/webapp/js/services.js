app.service('Promos', function($http) {

    var host = "http://localhost:9000/";

    var getData = function(response) { return response.data };
    var transform = function(json) { return new Pizza(json) };

    return {
        query: function() {
            return $http.get(host + "promos")
                .then(getData)
                .then(function(listaJson){
                    return listaJson.map(transform)
                })
        },
        update: function(libro, cb, errorHandler) { $http.put("libros/"+libro.id, libro).then(getData).then(cb).catch(errorHandler) },
        save: function(libro, cb, errorHandler) { $http.post("libros", libro).then(getData).then(cb).catch(errorHandler) },
        remove: function(libro, cb, errorHandler) { $http.delete("libros/"+libro.id).then(getData).then(cb).catch(errorHandler) }
    }
});

