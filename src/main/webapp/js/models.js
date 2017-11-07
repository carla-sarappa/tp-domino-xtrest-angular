function Pizza(json) {
    angular.extend(this, json);

    this.ingredientesAsString = function(){
        var s;
        for(var i = 0; i<this.ingredientes.length ; i++){
            s = (s?(s + ", "):"") + this.ingredientes[i].ingrediente.nombre;
        }
        return s;
    }
}
