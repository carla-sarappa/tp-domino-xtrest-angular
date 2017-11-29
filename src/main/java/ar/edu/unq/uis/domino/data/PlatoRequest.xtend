package ar.edu.unq.uis.domino.data

import ar.edu.unq.uis.domino.model.IngredienteDistribuido
import java.util.List
import ar.edu.unq.uis.domino.model.PizzaFactory
import ar.edu.unq.uis.domino.repo.Repositories
import ar.edu.unq.uis.domino.model.Tamanio
import ar.edu.unq.uis.domino.model.Plato
import ar.edu.unq.uis.domino.model.Pedido
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class PlatoRequest {
	Integer pizza
	List<IngredienteDistribuidoRequest> extras
	String tamanio
	Double monto
	
	new() {}
	
	static def from(Plato plato){
		val platoRequest = new PlatoRequest()
		platoRequest.pizza = plato.pizzaBase.id
		platoRequest.extras = plato.ingredientes.map[new IngredienteDistribuidoRequest(it)]
		platoRequest.tamanio = plato.tamanio.nombre
		platoRequest.monto = plato.precio
		platoRequest
	}
	
	def getPizza(){
		if (pizza == null){
			PizzaFactory.construirPizzaCustom("custom")
			
		} else {
			Repositories.pizzas.searchById(pizza)
		}
	}
	
	def getTamanio(){
		Tamanio.tamanios.findFirst[it.nombre.toLowerCase == tamanio.toLowerCase]
	}
		
	def createPlato(Pedido pedido){
		val plato = new Plato(getPizza, getTamanio, pedido)	
		if (extras != null) {
			extras.map[it.ingredienteDistribuido].forEach[ plato.agregarExtra(it) ] 
		}	
		
		return plato
	}
}

