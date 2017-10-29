package ar.edu.unq.uis.domino.data

import ar.edu.unq.uis.domino.repo.Repositories
import ar.edu.unq.uis.domino.model.IngredienteDistribuido

class IngredienteDistribuidoRequest {
	Integer ingrediente
	Integer distribucion
	
	new(){	}
	new(IngredienteDistribuido ingredienteDistribuido){
		this.ingrediente = ingredienteDistribuido.ingrediente.id
		this.distribucion = ingredienteDistribuido.distribucion.id
	}
	
	def getIngredienteDistribuido(){
		new IngredienteDistribuido(
			Repositories.ingredientes.searchById(ingrediente), 
			Repositories.distribuciones.searchById(distribucion)
		)
	}
	
}