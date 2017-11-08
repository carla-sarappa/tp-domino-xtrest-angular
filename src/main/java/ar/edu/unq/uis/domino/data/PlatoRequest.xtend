package ar.edu.unq.uis.domino.data

import ar.edu.unq.uis.domino.model.IngredienteDistribuido
import java.util.List
import ar.edu.unq.uis.domino.model.PizzaFactory
import ar.edu.unq.uis.domino.repo.Repositories
import ar.edu.unq.uis.domino.model.Tamanio
import ar.edu.unq.uis.domino.model.Plato
import ar.edu.unq.uis.domino.model.Pedido

class PlatoRequest {
	Integer promo
	List<IngredienteDistribuidoRequest> extras
	String tamanio
	
	new() {}
	
	static def from(Plato plato){
		val platoRequest = new PlatoRequest()
		platoRequest.promo = plato.pizzaBase.id
		platoRequest.extras = plato.ingredientes.map[new IngredienteDistribuidoRequest(it)]
		platoRequest.tamanio = plato.tamanio.nombre
		platoRequest
	}
	
	def getPizza(){
		if (promo == null){
			PizzaFactory.construirPizzaCustom("custom")
			
		} else {
			Repositories.pizzas.searchById(promo)
		}
	}
	
	def getTamanio(){
		Tamanio.tamanios.findFirst[it.nombre.toLowerCase == tamanio.toLowerCase]
	}
		
	def createPlato(Pedido pedido){
		val plato = new Plato(getPizza, getTamanio, pedido)	
			
		extras.map[it.ingredienteDistribuido].forEach[ plato.agregarExtra(it) ] 
		return plato
	}
}

