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

function pedidoFromJson(json) {
    var pedido = new Pedido();
    angular.extend(pedido, json);
    pedido.platos = pedido.platos.map(platoFromJson);
    console.log('PEDIDO: ', pedido);
    return pedido;
}

function Pedido(){
    this.platos = [];
    this.cliente = {};
    this.aclaraciones = '';

    this.conEnvio = function (dir) {
        this.formaDeEnvio = {
            nombre:'delivery',
            direccion: dir,
            costo: 15
        };
    };

    this.retiraPorLocal = function () {
        this.formaDeEnvio = {
            nombre:'retira por el local',
            costo: 0.0
        };
    };

    this.total = function(){
        return this.platos.map(function (plato) {
            return plato.precio()
        }).reduce(sumar, 0)
        + this.formaDeEnvio.costo;
    };

    this.retiraPorLocal();

}

function sumar(a, b) {
    return a+b;
}

function platoFromJson(json) {
    var plato = new Plato();
    angular.extend(plato, json);
    plato.extras = plato.extras.map(function(e){
        var extra = new IngredienteDistribuido(e.ingredienteDistribuido.ingrediente, true);
        extra.distribucion = e.ingredienteDistribuido.distribucion.nombre;
        return extra;
    });
    return plato;
}

function Plato(pizza){
    this.pizza = pizza;
    this.extras = [];
    this.tamanio = { factor:1 };

    this.sumarExtras = function(){
        return this.extras.map(function (extra) {
            return extra.ingrediente.precio
        }).reduce(sumar, 0)
    };

    this.precio = function () {
        return (this.pizza.precio * this.tamanio.factor)
            + this.sumarExtras();
    };

    this.allIngredientes = function () {
        return this.pizza.ingredientes.concat(this.extras);
    }
}

function Cliente(json){
    angular.extend(this, json);
}
