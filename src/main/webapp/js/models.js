function Pizza(json) {
    json.ingredientes = json.ingredientes.map(function (ingrediente) {
        return {ingrediente: ingrediente.ingrediente, distribucion: ingrediente.distribucion.nombre};
    });

    angular.extend(this, json);
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

function Pedido(){
    this.platos = [];
    this.cliente = {};
    this.aclaraciones = '';
    this.envio = '';

}

function Plato(pizza){
    this.promo = pizza;
    this.extras = [];
    this.tamanio = { factor:1 };

    this.sumarExtras = function(){
        return this.extras.map(function (extra) {
            return extra.ingrediente.precio
        }).reduce(function (a, b) {
            return a+b;
        }, 0)
    };

    this.precio = function () {
        return (this.promo.precio * this.tamanio.factor)
            + this.sumarExtras();
    };

    this.ingredientesAsString = function () {
        var all = this.promo.ingredientes.concat(this.extras);
        var s;
        var length = all.length;
        for(var i = 0; i<length ; i++){
            console.log("Ingrediente: ", all[i].ingrediente);
            s = (s?(s + ( i === length-1? " y " : ", ")):"") + all[i].ingrediente.nombre;
        }
        return s;
    }
}

function Cliente(json){
    angular.extend(this, json);
}
