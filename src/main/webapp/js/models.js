function Pizza(json) {
    json.ingredientes = json.ingredientes.map(function (ingrediente) {
        return {ingrediente: ingrediente.ingrediente, distribucion: ingrediente.distribucion.nombre};
    });

    angular.extend(this, json);

    this.ingredientesAsString = function(){
        var s;
        for(var i = 0; i<this.ingredientes.length ; i++){
            s = (s?(s + ", "):"") + this.ingredientes[i].ingrediente.nombre;
        }
        return s;
    }
}

function Tamanio(json){
    angular.extend(this, json);
}

function Ingrediente(json){
    angular.extend(this, json);
}

function IngredienteDistribuido(ingrediente, isExtra){
    this.ingrediente = ingrediente;
    this.distribucion = "Toda la pizza";
    this.isExtra = isExtra;
}


function Cliente(json){
    angular.extend(this, json);
}
